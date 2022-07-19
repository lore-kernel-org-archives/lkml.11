Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A309C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 12:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbiGSM41 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 08:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242226AbiGSMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:55:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BDB9823F;
        Tue, 19 Jul 2022 05:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8CB56177D;
        Tue, 19 Jul 2022 12:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62D0C341CA;
        Tue, 19 Jul 2022 12:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658233327;
        bh=NiPU0w4OCUfUSJ6Q5Kk8g7EVke2HETspl8rD2SltnnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYkIJ/Y0HLs3AbRIVmkaEwTvbYLWIKkBfz37qU/VoG4EN6HJRTNPCBFcXTvfuqQzI
         uy2lIIs4d6PZY8ZXtYIbal8o0DIFpk32B+QnIP3UCJ7rj3/FtetjlVMi74ud5O/AYQ
         UBHZX6nUl0Wi5wfabPUrXIpd1cdMC/mVMLqU+BLg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 084/231] arm64: dts: broadcom: bcm4908: Fix cpu node for smp boot
Date:   Tue, 19 Jul 2022 13:52:49 +0200
Message-Id: <20220719114721.904833629@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719114714.247441733@linuxfoundation.org>
References: <20220719114714.247441733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: William Zhang <william.zhang@broadcom.com>

[ Upstream commit 8bd582ae9a71d7f14c4e0c735b2eacaf7516d626 ]

Add spin-table enable-method and cpu-release-addr properties for
cpu0 node. This is required by all ARMv8 SoC. Otherwise some
bootloader like u-boot can not update cpu-release-addr and linux
fails to start up secondary cpus.

Fixes: 2961f69f151c ("arm64: dts: broadcom: add BCM4908 and Asus GT-AC5300 early DTS files")
Signed-off-by: William Zhang <william.zhang@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
index a4be040a00c0..967d2cd3c3ce 100644
--- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
+++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
@@ -29,6 +29,8 @@ cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "brcm,brahma-b53";
 			reg = <0x0>;
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0xfff8>;
 			next-level-cache = <&l2>;
 		};
 
-- 
2.35.1



