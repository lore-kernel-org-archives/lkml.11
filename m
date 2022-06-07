Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2270BC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 21:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379128AbiFGV1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377710AbiFGUeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:34:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2AE1E7175;
        Tue,  7 Jun 2022 11:35:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D286C612EC;
        Tue,  7 Jun 2022 18:35:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACA4C385A2;
        Tue,  7 Jun 2022 18:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654626945;
        bh=WgDIF/Nn5X3L6731oKP1wO+QcgYZIyvshq7IQHL/d4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQlAf+OZbTS6LzPK3bebo46HqbIocj/6hHv9190yYOZatDkkWIK44yIDg/rwbgb7K
         4A++pgOD1GaClEFOI4SAnh0hYWsr2AbQe13OZBId9QNDsWzLUUktSuFNzZ/TcoVVIH
         esdS9lpZDF7+7H5vax00dvcrqf83ekSZK9ZeoVlQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 520/772] arm64: dts: marvell: espressobin-ultra: enable front USB3 port
Date:   Tue,  7 Jun 2022 19:01:52 +0200
Message-Id: <20220607165004.300755113@linuxfoundation.org>
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

From: Robert Marko <robert.marko@sartura.hr>

[ Upstream commit eacec7ebc16cf5d2f6a6c7cf5d57156da2c3e98f ]

Espressobin Ultra has a front panel USB3.0 Type-A port which works
just fine so enable it.
I dont see a reason why it was disabled in the first place anyway.

Fixes: 3404fe15a60f ("arm64: dts: marvell: add DT for ESPRESSObin-Ultra")
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
index 610ff6f385c7..119db6b541b7 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-ultra.dts
@@ -108,7 +108,6 @@
 
 &usb3 {
 	usb-phy = <&usb3_phy>;
-	status = "disabled";
 };
 
 &mdio {
-- 
2.35.1



