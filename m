Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F29C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 21:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242230AbiF0V7m (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 17:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241519AbiF0Vzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:55:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B316BDECF;
        Mon, 27 Jun 2022 14:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656366902; x=1687902902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YTRyMTy4Cbklvo2axfnNj1XLWBlbWaoRN/EJpr2hGEo=;
  b=LPXa6aXLJNVkVV1mv0qcuePg+wIzndrbc168IwJhJfKNCjeK1BjCGLFm
   77VdiQwTnt5j+lU/sC0PjP99epgBtuOLdiPa9rqcWNxHZKCy/9pbBKFb4
   zBXIOfENj7PZ22ONhhVuBeJjIdTl1nSm2tRT69ppOeKQ9BrTZPJrjeYKQ
   sw/5LKSWSF8GY50OQxajNO/Py+i8DyYjMCMdd/M9TJsVr5bjCLaLoz2i5
   16UCZLszhpKxy68qKUDauZtrrfA2Rh1d/whBl0lsGuFl3YYAv3OTkOKDu
   uQ8PEvhg74zm+bKEu0qIENPTmEMyfAARHBPbA1DAB5MlOdp+iGEFj6J6X
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279116113"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279116113"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:54:58 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="657863667"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:54:58 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 071/102] KVM: TDX: restore debug store when TD exit
Date:   Mon, 27 Jun 2022 14:54:03 -0700
Message-Id: <bbcb1bc7da18c1675a1c72e6e25c27342c6834c7.1656366338.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1656366337.git.isaku.yamahata@intel.com>
References: <cover.1656366337.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

Because debug store is clobbered, restore it on TD exit.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/events/intel/ds.c | 1 +
 arch/x86/kvm/vmx/tdx.c     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 376cc3d66094..cdba4227ad3b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2256,3 +2256,4 @@ void perf_restore_debug_store(void)
 
 	wrmsrl(MSR_IA32_DS_AREA, (unsigned long)ds);
 }
+EXPORT_SYMBOL_GPL(perf_restore_debug_store);
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index c9cb9670f7cf..0de113a643e4 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -663,6 +663,7 @@ fastpath_t tdx_vcpu_run(struct kvm_vcpu *vcpu)
 	tdx_vcpu_enter_exit(vcpu, tdx);
 
 	tdx_user_return_update_cache();
+	perf_restore_debug_store();
 	tdx_restore_host_xsave_state(vcpu);
 	tdx->host_state_need_restore = true;
 
-- 
2.25.1

