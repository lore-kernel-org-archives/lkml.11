Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052D6C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 17:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244742AbiCJRXs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244866AbiCJRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:22:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D741E19ABE9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646932896; x=1678468896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WpP+vv71UOEAq4C6Qpr453ktQWY8DDevCFkTA3RJgVU=;
  b=gwPBwLyX78zMedOYWolmjoM0PeJFJ4tl0R9WG1j0ddHsS3uso70jiCwN
   3Y1l7tFpYIF+Xt/m/OVLbBU+4FuLPkdsVY1yKQH3qlDlNDXYXJnvHp6SD
   uasOGyDdBXCvIOXiCM9GNRKDMqXOtm6MTej98ePFi4BOV+5unU4LnPJfT
   81VCbtnWYnfsKrUt3FynXpiT+uDkTowa27GAT5jeNyuS7n/IplFAA2eYN
   UXbe4ubcgOHqKvb1zm3C2UUi6KrHn+ewyw+cH2TCalVJohQr0DcW7ZcSg
   MTmdyJUIA45KRdysT6xIubPCyAy6As7DV/NA7zFMal5g2HJ/FUMsISuGQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="235918662"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="235918662"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:23 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="781532069"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 09:21:23 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V9 26/45] x86/entry: Define arch_{save|restore}_auxiliary_pt_regs()
Date:   Thu, 10 Mar 2022 09:20:00 -0800
Message-Id: <20220310172019.850939-27-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310172019.850939-1-ira.weiny@intel.com>
References: <20220310172019.850939-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The x86 architecture supports the new auxiliary pt_regs space if
ARCH_HAS_PTREGS_AUXILIARY is enabled.

Define the callbacks within the x86 code required by the core entry code
when this support is enabled.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	New patch
---
 arch/x86/include/asm/entry-common.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
index 43184640b579..5fa5dd2d539c 100644
--- a/arch/x86/include/asm/entry-common.h
+++ b/arch/x86/include/asm/entry-common.h
@@ -95,4 +95,16 @@ static __always_inline void arch_exit_to_user_mode(void)
 }
 #define arch_exit_to_user_mode arch_exit_to_user_mode
 
+#ifdef CONFIG_ARCH_HAS_PTREGS_AUXILIARY
+
+static inline void arch_save_aux_pt_regs(struct pt_regs *regs)
+{
+}
+
+static inline void arch_restore_aux_pt_regs(struct pt_regs *regs)
+{
+}
+
+#endif
+
 #endif
-- 
2.35.1

