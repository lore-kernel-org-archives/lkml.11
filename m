Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF6EC4167B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 10:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345612AbiBNKGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:06:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345603AbiBNKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:01:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE61C13C;
        Mon, 14 Feb 2022 01:47:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C5D661284;
        Mon, 14 Feb 2022 09:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04320C340E9;
        Mon, 14 Feb 2022 09:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644832076;
        bh=I4fTghh8t62Mct8NDcrob1gP89ZwL1gZIENffU7Umzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lqTUSEc55nQBODrxO/Xe4OYC/zU1MQpBbWCuVPVfT2tH7gsi14VNoZb9W9StbNY3U
         YZCuXFr19Pgknu95GvN/yituhcQppx51Bt2xjMROQNX5MLXgARyWxV7QDjmGYhTJS9
         LHcPN3JBMafBGd3d0m5f633xLEL1zwTATLpzYPZU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: [PATCH 5.15 072/172] ARM: socfpga: fix missing RESET_CONTROLLER
Date:   Mon, 14 Feb 2022 10:25:30 +0100
Message-Id: <20220214092508.892193177@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220214092506.354292783@linuxfoundation.org>
References: <20220214092506.354292783@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

commit 3037b174b1876aae6b2d1a27a878c681c78ccadc upstream.

The SocFPGA machine since commit b3ca9888f35f ("reset: socfpga: add an
early reset driver for SoCFPGA") uses reset controller, so it should
select RESET_CONTROLLER explicitly.  Selecting ARCH_HAS_RESET_CONTROLLER
is not enough because it affects only default choice still allowing a
non-buildable configuration:

  /usr/bin/arm-linux-gnueabi-ld: arch/arm/mach-socfpga/socfpga.o: in function `socfpga_init_irq':
  arch/arm/mach-socfpga/socfpga.c:56: undefined reference to `socfpga_reset_init'

Reported-by: kernel test robot <lkp@intel.com>
Cc: <stable@vger.kernel.org>
Fixes: b3ca9888f35f ("reset: socfpga: add an early reset driver for SoCFPGA")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-socfpga/Kconfig |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -2,6 +2,7 @@
 menuconfig ARCH_INTEL_SOCFPGA
 	bool "Altera SOCFPGA family"
 	depends on ARCH_MULTI_V7
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
@@ -18,6 +19,7 @@ menuconfig ARCH_INTEL_SOCFPGA
 	select PL310_ERRATA_727915
 	select PL310_ERRATA_753970 if PL310
 	select PL310_ERRATA_769419
+	select RESET_CONTROLLER
 
 if ARCH_INTEL_SOCFPGA
 config SOCFPGA_SUSPEND


