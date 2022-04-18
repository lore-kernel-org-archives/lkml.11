Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08AFC46467
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 14:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343774AbiDRONR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbiDRN4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:56:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B8E49F32;
        Mon, 18 Apr 2022 06:05:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D21C60F09;
        Mon, 18 Apr 2022 13:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37099C385A1;
        Mon, 18 Apr 2022 13:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650287120;
        bh=Su2XOz/6uNUdLXlGxtYxG+pWQnN+YPHhgf6T/GlW8dc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lvzFUj6U8VkkPrzjLf/1iM6epWKw/+SPC5OEynn103m7ztQKULg6r4lHMPNJD3JvL
         cmCnENymEINpcX9OKjIo1VWJGdBGuxbYniQOTRmGrxlKtFgQ+2TnCvC7i++2UAaVh0
         be2vfF9IcjAZ4rBO1OOmLcERDTo0y/3Iij7pVbYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank Wunderlich <frank-w@public-files.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 063/218] arm64: dts: broadcom: Fix sata nodename
Date:   Mon, 18 Apr 2022 14:12:09 +0200
Message-Id: <20220418121201.414868099@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121158.636999985@linuxfoundation.org>
References: <20220418121158.636999985@linuxfoundation.org>
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
 arch/arm64/boot/dts/broadcom/ns2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/broadcom/ns2.dtsi b/arch/arm64/boot/dts/broadcom/ns2.dtsi
index 8a94ec8035d3..83c1718dac29 100644
--- a/arch/arm64/boot/dts/broadcom/ns2.dtsi
+++ b/arch/arm64/boot/dts/broadcom/ns2.dtsi
@@ -514,7 +514,7 @@
 			};
 		};
 
-		sata: ahci@663f2000 {
+		sata: sata@663f2000 {
 			compatible = "brcm,iproc-ahci", "generic-ahci";
 			reg = <0x663f2000 0x1000>;
 			reg-names = "ahci";
-- 
2.34.1



