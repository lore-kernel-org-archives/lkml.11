Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A71C43219
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 11:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384160AbiBGLZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 06:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382527AbiBGLTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 06:19:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D41C043188;
        Mon,  7 Feb 2022 03:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FC05B80EC3;
        Mon,  7 Feb 2022 11:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03E4C340EB;
        Mon,  7 Feb 2022 11:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644232772;
        bh=O4rkXDLKEF5e06Q+i6wlxpv1Ntkue5OXg90cmPybBtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qzKx86a+g+gI77tmCvO901KJ+lNdODx2eMIsyKueCpjZCCNFYedOfPEut4zO4CUD9
         JfJpdp3Vj5CwkdegzsUATDiux8QHbhHUBG4mWf3acCIANPgr9ekuja4btro69ZmlFQ
         eMSCko9TJj9s83jhUd8NRQJQOiPKOR/wmCmVCeGY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yannick Vignon <yannick.vignon@nxp.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 30/44] net: stmmac: ensure PTP time register reads are consistent
Date:   Mon,  7 Feb 2022 12:06:46 +0100
Message-Id: <20220207103754.139136514@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207103753.155627314@linuxfoundation.org>
References: <20220207103753.155627314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yannick Vignon <yannick.vignon@nxp.com>

commit 80d4609008e6d696a279e39ae7458c916fcd44c1 upstream.

Even if protected from preemption and interrupts, a small time window
remains when the 2 register reads could return inconsistent values,
each time the "seconds" register changes. This could lead to an about
1-second error in the reported time.

Add logic to ensure the "seconds" and "nanoseconds" values are consistent.

Fixes: 92ba6888510c ("stmmac: add the support for PTP hw clock driver")
Signed-off-by: Yannick Vignon <yannick.vignon@nxp.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Link: https://lore.kernel.org/r/20220203160025.750632-1-yannick.vignon@oss.nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -149,15 +149,20 @@ static int adjust_systime(void __iomem *
 
 static void get_systime(void __iomem *ioaddr, u64 *systime)
 {
-	u64 ns;
+	u64 ns, sec0, sec1;
 
-	/* Get the TSSS value */
-	ns = readl(ioaddr + PTP_STNSR);
-	/* Get the TSS and convert sec time value to nanosecond */
-	ns += readl(ioaddr + PTP_STSR) * 1000000000ULL;
+	/* Get the TSS value */
+	sec1 = readl_relaxed(ioaddr + PTP_STSR);
+	do {
+		sec0 = sec1;
+		/* Get the TSSS value */
+		ns = readl_relaxed(ioaddr + PTP_STNSR);
+		/* Get the TSS value */
+		sec1 = readl_relaxed(ioaddr + PTP_STSR);
+	} while (sec0 != sec1);
 
 	if (systime)
-		*systime = ns;
+		*systime = ns + (sec1 * 1000000000ULL);
 }
 
 const struct stmmac_hwtimestamp stmmac_ptp = {


