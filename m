Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D071C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 16:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348589AbiCHQ5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiCHQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:57:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDE652B14
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 08:56:44 -0800 (PST)
Date:   Tue, 08 Mar 2022 16:56:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646758603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pi1YJOXwAgCElzUXIauTP1A6u9zvZX9L9i6/aJF2M4Y=;
        b=aaCoTcFPuT630UjULVeXzjBlFaS3uw7YIeh7M0mVbI7SLvBCEiJsWf34oMEtafa1Fv1Ssx
        qfPD+cfID6um7wPx930nWzCCltfB1yxXvv7/jSPwx7tKtbtYvbSJmsruRAert2CMxjc5cj
        sjzEBmB3o8y7MEet5yUoP3o/PJyCS9kUVDGTx5Sz47XFow4HcX8/o2zgLkUPAd38ZTLde1
        BIzN4dybJlaWVAiuN/uCHt/Y5IdDmhKQDKRHluyxwy8Yoq87jp92RYcD8JRL8wCDCV1qIn
        NQvM73X1R5CxhE0xnPbPGELwO3Z7gfBP/jocLFYXy2L47HrZ/IiOfBTI3cGP+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646758603;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pi1YJOXwAgCElzUXIauTP1A6u9zvZX9L9i6/aJF2M4Y=;
        b=w8xrF6dGB77j1tWUdWlCsYKXTk2m/7+OVslaWju5T5INbWkf3MQc5v0jT/EyEm1QUkFiWd
        tjbGtNsbR1PWm3CA==
From:   "irqchip-bot for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] arm64: dts: apple: Add t8103 PMU
 interrupt affinities
Cc:     Marc Zyngier <maz@kernel.org>, tglx@linutronix.de
MIME-Version: 1.0
Message-ID: <164675860195.16921.996545906775527331.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     1852e22b318b8d1c02b574da679b1b74f3686090
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/1852e22b318b8d1c02b574da679b1b74f3686090
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 14 Dec 2021 15:56:55 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 07 Feb 2022 16:00:42 

arm64: dts: apple: Add t8103 PMU interrupt affinities

The two PMU pseudo interrupts have specific affinities. One set
is affine to the small cores, and the other set affine to the
big ones.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 arch/arm64/boot/dts/apple/t8103.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8103.dtsi b/arch/arm64/boot/dts/apple/t8103.dtsi
index 19afbc9..a2e0065 100644
--- a/arch/arm64/boot/dts/apple/t8103.dtsi
+++ b/arch/arm64/boot/dts/apple/t8103.dtsi
@@ -213,6 +213,18 @@
 			interrupt-controller;
 			reg = <0x2 0x3b100000 0x0 0x8000>;
 			power-domains = <&ps_aic>;
+
+			affinities {
+				e-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_E>;
+					cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
+				};
+
+				p-core-pmu-affinity {
+					apple,fiq-index = <AIC_CPU_PMU_P>;
+					cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
+				};
+			};
 		};
 
 		pmgr: power-management@23b700000 {
