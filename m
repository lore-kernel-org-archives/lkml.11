Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43847C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 20:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiCDUHg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiCDUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:06:58 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C332F94D7;
        Fri,  4 Mar 2022 12:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646424091; x=1677960091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yqw/sxKHW+e0yHFTITfYw+io3uKqM2HYUAxrX3Z4VvA=;
  b=TYz/B5T1DZUTA6WLk5a4yn4DjLRmZc7niDj4FSf13InZg7/4T6glP60D
   4GfPpeNvks27LnRyPXsvftM6zzn/xyGTjjh9TCuPEi7Cre9SsDfrwNq8R
   c06RI5AsNrenwhv42M2bQhiBIhR929EJLzuWUdq8M1gHQl0emjmMl6bFw
   9pg+0hflsfdswApVsv5dWHUGNGcHjGhyEZ399xKQOd5osoNFBL3uIz+AD
   L4+9ZLMTF25fqELM/WBlQj4I/nXZ8EAy7hSAqMjMN5xWAUL9cdyjvqooy
   OKGWpbSSWC8pO3ieroR1ZYIonAFRqkxBwfKOJsVKaRgb7TZ7tmeS1v9aP
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="253983365"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="253983365"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:50:11 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552344198"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:50:11 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH v5 018/104] [MARKER] The start of TDX KVM patch series: TD VM creation/destruction
Date:   Fri,  4 Mar 2022 11:48:34 -0800
Message-Id: <c1371294fe74a61ea0ff5e31c6d4d70344c65ba9.1646422845.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646422845.git.isaku.yamahata@intel.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

This empty commit is to mark the start of patch series of TD VM
creation/destruction.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 Documentation/virt/kvm/intel-tdx-layer-status.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/intel-tdx-layer-status.rst b/Documentation/virt/kvm/intel-tdx-layer-status.rst
index d4db90cb098b..4066495da3d1 100644
--- a/Documentation/virt/kvm/intel-tdx-layer-status.rst
+++ b/Documentation/virt/kvm/intel-tdx-layer-status.rst
@@ -15,8 +15,8 @@ Patch Layer status
 ------------------
   Patch layer                          Status
 * TDX, VMX coexistence:                 Applied
-* TDX architectural definitions:        Applying
-* TD VM creation/destruction:           Not yet
+* TDX architectural definitions:        Applied
+* TD VM creation/destruction:           Applying
 * TD vcpu creation/destruction:         Not yet
 * TDX EPT violation:                    Not yet
 * TD finalization:                      Not yet
-- 
2.25.1

