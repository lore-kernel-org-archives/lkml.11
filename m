Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCE8C35278
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 01:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbiBHBDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245457AbiBGXD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 18:03:29 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D28C043180
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 15:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644275009; x=1675811009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pSiI5bRDWKZ8wcmfvSwFj0dyl6gbbkbtffSYluVkHLo=;
  b=F1vjZWnddLAVvyvUSU4871QEz5idrLoEk5yShnWA8YgS9bzzOdQZrC1t
   R6iMD68wvheMDsMSUC0hdGOHV9Lt/o3NhhvTLdJ0wya7dSo+vEmV6hdYt
   vjr9uHzO9Uj1piB3DcDChDOTgw5R97fUuGdoN2ooK/X2l//xKaHHrmCB4
   UaplCBBQoX/lVujeeGnfDJYxxpuw9SGRqbJgaBjIHe/2geUj7n+cwyGs6
   xxDhUDxACKxlUIGc7dVi0dMrDKigfWHLoFTburJkokjYJhku3EcjB/J69
   IwMLb16Z3dL8EKTGwC66WMgzHbLgvMYeX83Qxx0dUeXU5Y11yj+0sPsIN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229475014"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="229475014"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 15:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; 
   d="scan'208";a="540324061"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga008.jf.intel.com with ESMTP; 07 Feb 2022 15:03:04 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 06/11] x86/fpu: Clear PASID when copying fpstate
Date:   Mon,  7 Feb 2022 15:02:49 -0800
Message-Id: <20220207230254.3342514-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220207230254.3342514-1-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel must allocate a Process Address Space ID (PASID) on behalf of
each process which will use ENQCMD and program it into the new MSR to
communicate the process identity to platform hardware. ENQCMD uses the
PASID stored in this MSR to tag requests from this process.

The PASID state must be cleared on fork() since fork creates a
new address space.

For clone(), it would be functionally OK to copy the PASID. However,
clearing it is _also_ functionally OK since any PASID use will trigger
the #GP handler to populate the MSR.

Copying the PASID state has two main downsides:
 * It requires differentiating fork() and clone() in the code,
   both in the FPU code and keeping tsk->pasid_activated consistent.
 * It guarantees that the PASID is out of its init state, which
   incurs small but non-zero cost on every XSAVE/XRSTOR.

The main downside of clearing the PASID at fpstate copy is the future,
one-time #GP for the thread.

Use the simplest approach: clear the PASID state both on clone() and
fork().  Rely on the #GP handler for MSR population in children.

Also, just clear the PASID bit from xfeatures if XSAVE is supported.
This will have no effect on systems that do not have PASID support.  It
is virtually zero overhead because 'dst_fpu' was just written and
the whole thing is cache hot.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
v4:
- Add "Reviewed-by: Thomas Gleixner <tglx@linutronix.de>" (Thomas).

v2:
- Rewrite changelog (Dave Hansen).
- Move xfeature tweaking into fpu_clone() and make it unconditional
  if XSAVE is supported (Dave Hansen).

 arch/x86/kernel/fpu/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8dea01ffc5c1..19821f027cb3 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -612,6 +612,13 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 		fpu_inherit_perms(dst_fpu);
 	fpregs_unlock();
 
+	/*
+	 * Children never inherit PASID state.
+	 * Force it to have its init value:
+	 */
+	if (use_xsave())
+		dst_fpu->fpstate->regs.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
+
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
-- 
2.35.1

