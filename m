Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38304C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 18:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiGNS63 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiGNS6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9EC6B77A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:58:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C5F621D1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E84C34115;
        Thu, 14 Jul 2022 18:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657825093;
        bh=U+HabZePJJwRc+QTAmL3xyXjfIPAokxMHtpQkugjOlo=;
        h=From:To:Cc:Subject:Date:From;
        b=QhdVx2KoYRVmU510amPvni5m5MEUrL689trjQCEtCepQdL5koFNPwXanVZHM/gEKe
         AfUa/EsYxLpcnVqZ06BxeDYYjglk40OhNQ/Zf7Of1mYGVE3d55J89MgELPiTMF3shh
         EET790KIt1t7RHFGpO8a34qlYKOSleH3vvPNM34Aa0DVnuCiJ7QKEkkRLXWfJCwjFe
         /UZKHbej+/qM2rIKM8Rz3UZdutD/dhSjSuiZvacAH/pU+rmtNIrySDce21XyNCJvLm
         tX539ROI34b5mxXP/O34dw+jXDg8nKtbQRWq3AOfMQJlXVNQAhozltlBhPCb2OaSlK
         mIs3q/RBvSz2A==
Received: by pali.im (Postfix)
        id 507421295; Thu, 14 Jul 2022 20:58:11 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: ioremap: Fix compilation of code which use pci_remap_iospace() without CONFIG_MMU
Date:   Thu, 14 Jul 2022 20:57:00 +0200
Message-Id: <20220714185700.6137-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Custom ARM version of pci_remap_iospace() is implemented only for MMU
kernel builds. So do not define pci_remap_iospace() without CONFIG_MMU.

See compilation failures:
https://lore.kernel.org/r/202112040150.wvyJZIZO-lkp@intel.com/
https://lore.kernel.org/r/202112261802.u9iXqdWh-lkp@intel.com/
https://lore.kernel.org/r/202201131529.A2s7rKQc-lkp@intel.com/
https://lore.kernel.org/r/202203090147.24cUL0De-lkp@intel.com/

Fixes: bc02973a06a6 ("arm: ioremap: Implement standard PCI function pci_remap_iospace()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pali Rohár <pali@kernel.org>

---

PING!!!! Is somebody interested in fixing these compile errors? As nobody
answered to my emails where I proposed this fix more than half year ago and
asked for opinion...

https://lore.kernel.org/r/20211204022131.bmhla4gkph7s7hy2@pali/
https://lore.kernel.org/r/20211205123209.lyx76daqdwzqwex4@pali/
https://lore.kernel.org/r/20211226215135.blcnafbuwhrq5ram@pali/
https://lore.kernel.org/r/20220113134938.3tx7iiukphvazvsq@pali/
https://lore.kernel.org/r/20220308184851.jmw2xvrapy5wzwof@pali/

If nobody is interested then please STOP sending me these Intel "0-DAY CI
Kernel Test Service" emails. Thanks!
---
 arch/arm/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index eba7cbc93b86..47cf79229b7c 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -180,10 +180,12 @@ void pci_ioremap_set_mem_type(int mem_type);
 static inline void pci_ioremap_set_mem_type(int mem_type) {}
 #endif
 
+#ifdef CONFIG_MMU
 struct resource;
 
 #define pci_remap_iospace pci_remap_iospace
 int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr);
+#endif
 
 /*
  * PCI configuration space mapping function.
-- 
2.20.1

