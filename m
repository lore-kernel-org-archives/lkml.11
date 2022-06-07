Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A994CCA483
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 21:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359354AbiFGVVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376516AbiFGU06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAFD17D391;
        Tue,  7 Jun 2022 11:32:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D17861500;
        Tue,  7 Jun 2022 18:32:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876CCC385A2;
        Tue,  7 Jun 2022 18:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654626765;
        bh=Fj/fW43wd9kwqA+LnYirM/9rZBHeydYkYqpZlhxcRNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qNjHIeUX1pAhZt0CC/Xy7ZTeEzBBIPfnaFwrJulO2nL3ZKapdcTvV99lynlCKiOLE
         dyFmRr7CPVSMHB2wb6hWwOIbvGC34xfT6vKNvquDFVrMYtGUElgGyjDJQdatQ+KpM3
         z1hMXA2PzV6uzfdg5wex+YR0Sif7+qaXCPBRdCiw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, QintaoShen <unSimple1993@163.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 496/772] soc: bcm: Check for NULL return of devm_kzalloc()
Date:   Tue,  7 Jun 2022 19:01:28 +0200
Message-Id: <20220607165003.599524223@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: QintaoShen <unSimple1993@163.com>

[ Upstream commit b4bd2aafacce48db26b0a213d849818d940556dd ]

As the potential failure of allocation, devm_kzalloc() may return NULL.  Then
the 'pd->pmb' and the follow lines of code may bring null pointer dereference.

Therefore, it is better to check the return value of devm_kzalloc() to avoid
this confusion.

Fixes: 8bcac4011ebe ("soc: bcm: add PM driver for Broadcom's PMB")
Signed-off-by: QintaoShen <unSimple1993@163.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/bcm/bcm63xx/bcm-pmb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/bcm/bcm63xx/bcm-pmb.c b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
index 7bbe46ea5f94..9407cac47fdb 100644
--- a/drivers/soc/bcm/bcm63xx/bcm-pmb.c
+++ b/drivers/soc/bcm/bcm63xx/bcm-pmb.c
@@ -312,6 +312,9 @@ static int bcm_pmb_probe(struct platform_device *pdev)
 	for (e = table; e->name; e++) {
 		struct bcm_pmb_pm_domain *pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 
+		if (!pd)
+			return -ENOMEM;
+
 		pd->pmb = pmb;
 		pd->data = e;
 		pd->genpd.name = e->name;
-- 
2.35.1



