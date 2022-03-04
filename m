Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86ADC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 20:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiCDUeZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiCDUcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 15:32:20 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E0A1E6974;
        Fri,  4 Mar 2022 12:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646425889; x=1677961889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WfSc1fDdQw41JvzIresVWLingmn314GFgb6rX6iaMCA=;
  b=WvCjRc8Kg5j2itcBJnAUUxxGbowNfAuWbWkuQ7G/rEzjuKL4qfo4//2V
   dQNzh1DcRX6Wy8aVJ0KP9sWxdZDhPwhgcwyXzXG5YKsnALVTJ9d2KJqXe
   oX/nKgKchE7+3jDxTLWN+6fOLePj/1z6PwX33T1bxrbfw94eAlnz24+nG
   af2G759ZlZVaBFGSwF9lVrbveaAXo7s8e1BiRrNbL+KMzDl2Y5BNdR2La
   3Tp4nuDXwbQOTFIW71e4WHsPNwmEVKFWuAt0/XLMQp9LOOVJLlBmIMvOB
   NOsJWPs3kJyGebiHwGDVjIHYoxjHYXvijpN7elHHADQlyuFWK40c7Uyxs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="251624233"
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="251624233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:50:29 -0800
X-IronPort-AV: E=Sophos;i="5.90,156,1643702400"; 
   d="scan'208";a="552344423"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 11:50:29 -0800
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Subject: [RFC PATCH v5 059/104] [MARKER] The start of TDX KVM patch series: TD finalization
Date:   Fri,  4 Mar 2022 11:49:15 -0800
Message-Id: <778e895973ec553dfc8cd2c455bb722d5772da43.1646422845.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1646422845.git.isaku.yamahata@intel.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Isaku Yamahata <isaku.yamahata@intel.com>

This empty commit is to mark the start of patch series of TD finalization.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
---
 Documentation/virt/kvm/intel-tdx-layer-status.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/intel-tdx-layer-status.rst b/Documentation/virt/kvm/intel-tdx-layer-status.rst
index d56b3890ddfe..3737b966ea07 100644
--- a/Documentation/virt/kvm/intel-tdx-layer-status.rst
+++ b/Documentation/virt/kvm/intel-tdx-layer-status.rst
@@ -21,11 +21,11 @@ Patch Layer status
 * TD VM creation/destruction:           Applied
 * TD vcpu creation/destruction:         Applied
 * TDX EPT violation:                    Applied
-* TD finalization:                      Not yet
+* TD finalization:                      Applying
 * TD vcpu enter/exit:                   Not yet
 * TD vcpu interrupts/exit/hypercall:    Not yet
 
 * KVM MMU GPA stolen bits:              Applied
 * KVM TDP refactoring for TDX:          Applied
 * KVM TDP MMU hooks:                    Applied
-* KVM TDP MMU MapGPA:                   Not yet
+* KVM TDP MMU MapGPA:                   Applied
-- 
2.25.1

