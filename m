Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CE0C35294
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353952AbiDLHQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351948AbiDLHE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:04:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3502946154;
        Mon, 11 Apr 2022 23:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2084661045;
        Tue, 12 Apr 2022 06:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344E2C385A6;
        Tue, 12 Apr 2022 06:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746049;
        bh=Hzb/60PTNbC86qMbYGr/Gly1OYzLxsR3fCnMTsch53k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tzHgx0k16FI44/Vg4sIBIvNHPnEx44Yvf98MgX8dd4nEDXvR0PYHnNLQw6889kmVO
         tN75qn2BQ9a8gYFN69m9Ns5psXx0QrLy7m8e7p8t/3PIRTn+uI5G/+OI9KVtiN/T6U
         6iLWYC9s8WoadIXr2WHwhZAO1c1vbisTNuwxCfAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 101/277] MIPS: ingenic: correct unit node address
Date:   Tue, 12 Apr 2022 08:28:24 +0200
Message-Id: <20220412062944.964837277@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062942.022903016@linuxfoundation.org>
References: <20220412062942.022903016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

[ Upstream commit 8931ddd8d6a55fcefb20f44a38ba42bb746f0b62 ]

Unit node addresses should not have leading 0x:

  Warning (unit_address_format): /nemc@13410000/efuse@d0/eth-mac-addr@0x22: unit name should not have leading "0x"

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index 9e34f433b9b5..efbbddaf0fde 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -450,7 +450,7 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			eth0_addr: eth-mac-addr@0x22 {
+			eth0_addr: eth-mac-addr@22 {
 				reg = <0x22 0x6>;
 			};
 		};
-- 
2.35.1



