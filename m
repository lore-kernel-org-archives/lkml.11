Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D91C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 00:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243684AbiCKA7j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 19:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiCKA7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:59:35 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F418E7ADD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 16:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646960313; x=1678496313;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qdRZwcheezTGfs6H8foja5La9g1WfULiBkuZy4sc1Hs=;
  b=BVI+1L1BHyl8NzGNTo+OH9vjJo+ELs2LACOOxZ8L1fJnZ2eGuzyf7ocA
   gr19fP9kiJ27YquhmealWGU6cpO2s9YflbychIpjlIzlCH4ADu+3TBI/L
   ADPQOAQExY8vmGyBgHJRKeAE2Um0niYV7dA4EfAcf1SpaZmxniXXHTwME
   OaZo7lqjsApJtfOCCAJoBb+bKNltvSjGVnltG/Fitd7+SiJcBaDP1bK08
   a5711tVpFHtDkg9bw38E3GmZU+lTaJ9r/O+jH6E56QlVRspEyUXMsSgAO
   zF8eJUUr+51gNyfvYQ0zDhNA0oKwotX12eVilQcbdnELL5KYwjFq9weqb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255405800"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255405800"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="538750557"
Received: from gdavids1-mobl.amr.corp.intel.com (HELO localhost) ([10.212.65.108])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 16:57:45 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] x86/pkeys: Clean up arch_set_user_pkey_access() declaration
Date:   Thu, 10 Mar 2022 16:57:38 -0800
Message-Id: <20220311005742.1060992-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220311005742.1060992-1-ira.weiny@intel.com>
References: <20220311005742.1060992-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

arch_set_user_pkey_access() was declared two times in the header.

Remove the 2nd declaration.

Suggested-by: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/include/asm/pkeys.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 1d5f14aff5f6..9c530530b9a7 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -118,8 +118,6 @@ int mm_pkey_free(struct mm_struct *mm, int pkey)
 	return 0;
 }
 
-extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
-		unsigned long init_val);
 extern int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 
-- 
2.35.1

