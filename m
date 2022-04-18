Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348B6C43217
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 13:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243985AbiDRNnF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242684AbiDRNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:14:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38603A5EC;
        Mon, 18 Apr 2022 05:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 231CE61277;
        Mon, 18 Apr 2022 12:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24290C385A7;
        Mon, 18 Apr 2022 12:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650286270;
        bh=peh+jRBriRQ0JjYZv0+MjDjiNHtrCumnADdIoYLH6s4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tsfw6ZjS3gSLt0YKUSehGxxuVFBEo5zjbKm/s7lAXHkXgZrwo9V65M5Z5vJJsLGok
         myg2VTUu0vEoNbc2qaTTdpp1wyctBvkTHDXLigf7IbZT21OaOQ8gNa3wpRTZdTDoNE
         QnLgaCpjmhAyOmCfM1oZDD2yA/XapjJ7wEVDjcpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Wunderlich <frank-w@public-files.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 080/284] arm64: dts: broadcom: Fix sata nodename
Date:   Mon, 18 Apr 2022 14:11:01 +0200
Message-Id: <20220418121212.960710149@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121210.689577360@linuxfoundation.org>
References: <20220418121210.689577360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

[ Upstream commit 55927cb44db43a57699fa652e2437a91620385dc ]

After converting ahci-platform txt binding to yaml nodename is reported
as not matching the standard:

arch/arm64/boot/dts/broadcom/northstar2/ns2-svk.dt.yaml:
ahci@663f2000: $nodename:0: 'ahci@663f2000' does not match '^sata(@.*)?$'

Fix it to match binding.

Fixes: ac9aae00f0fc ("arm64: dts: Add SATA3 AHCI and SATA3 PHY DT nodes for NS2")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
index 05f82819ae2d..46676af48c31 100644
--- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
@@ -687,7 +687,7 @@
 			};
 		};
 
-		sata: ahci@663f2000 {
+		sata: sata@663f2000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x663f2000 0x1000>;
 			dma-coherent;
-- 
2.34.1



