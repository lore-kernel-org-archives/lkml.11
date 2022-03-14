Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26B3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbiCNMB4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240081AbiCNMBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4F41F635;
        Mon, 14 Mar 2022 04:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 517E36126A;
        Mon, 14 Mar 2022 11:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D642DC340E9;
        Mon, 14 Mar 2022 11:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647259125;
        bh=DKNDYXgw49c2olI1scssS2MuoyX0fwBUl/q7icBUL2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C4WN8Rvy4LzwiMJ6n+LZbjnnboxy4YNDTil3ofW1EYF2RvOPj+2rpjRdjM2ivmQva
         EWKrITYivKSXKdg9YXz7ozCZqqJKnSIt/XP1bQxhwztYbqqJJIlHM7kKNCjCD3Soaz
         O6dSc1IdebACpvGrhzjpqWOZPDPat6RB4RixgTIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 01/71] ARM: boot: dts: bcm2711: Fix HVS register range
Date:   Mon, 14 Mar 2022 12:52:54 +0100
Message-Id: <20220314112737.973175326@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112737.929694832@linuxfoundation.org>
References: <20220314112737.929694832@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Ripard <maxime@cerno.tech>

[ Upstream commit 515415d316168c6521d74ea8280287e28d7303e6 ]

While the HVS has the same context memory size in the BCM2711 than in
the previous SoCs, the range allocated to the registers doubled and it
now takes 16k + 16k, compared to 8k + 16k before.

The KMS driver will use the whole context RAM though, eventually
resulting in a pointer dereference error when we access the higher half
of the context memory since it hasn't been mapped.

Fixes: 4564363351e2 ("ARM: dts: bcm2711: Enable the display pipeline")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/bcm2711.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
index 55ec83bde5a6..e46a3f4ad350 100644
--- a/arch/arm/boot/dts/bcm2711.dtsi
+++ b/arch/arm/boot/dts/bcm2711.dtsi
@@ -290,6 +290,7 @@ pixelvalve4: pixelvalve@7e216000 {
 
 		hvs: hvs@7e400000 {
 			compatible = "brcm,bcm2711-hvs";
+			reg = <0x7e400000 0x8000>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.34.1



