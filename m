Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A7BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 18:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384031AbiEES0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 14:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383230AbiEESTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:19:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC535D644;
        Thu,  5 May 2022 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651774554; x=1683310554;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yzsW3HP34uHnzDykzPATauL2DDgMbwFkjBwFhJu1DX0=;
  b=S/1dSvFKJGer6u5GdJkEKG6eQbmZDEAdcpTFjnazSWkCsFENWs43aa5d
   aj65dXXcQkg4LLPZtju9wbbZK+y/TOJssaw92YX7MBwNUZW6XzLxCDBf8
   aOn8s+Q5uPOr9HYAaCtRRischm7hjPNux5zHSduRQ3qml4Wx8dHHCryXm
   3X/7+BRtpXN+yDNpmIdHeQWW0LRtYDx1IMG1xt9+umc7FjHziLAqFk39O
   W5C4nHmT/wOATbQXrSXCuMonc9qY82YpLHDJlDChwYvRqMVSnqF3Ort3G
   tt0tJtN21T6Qfma2VG+Lz84WvmjsZlz3170b9wfP1ZIBF+uMwS0Ee6paP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268354850"
X-IronPort-AV: E=Sophos;i="5.91,202,1647327600"; 
   d="scan'208";a="268354850"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 11:15:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,202,1647327600"; 
   d="scan'208";a="665083363"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 11:15:49 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>
Subject: [RFC PATCH v6 060/104] [MARKER] The start of TDX KVM patch series: TD finalization
Date:   Thu,  5 May 2022 11:14:54 -0700
Message-Id: <8627d70daf0e76bcfcc473a866366d22f9b088e3.1651774250.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1651774250.git.isaku.yamahata@intel.com>
References: <cover.1651774250.git.isaku.yamahata@intel.com>
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
index 5797d172176d..53897312699f 100644
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
 
 * KVM MMU GPA shared bits:              Applied
 * KVM TDP refactoring for TDX:          Applied
 * KVM TDP MMU hooks:                    Applied
-* KVM TDP MMU MapGPA:                   Not yet
+* KVM TDP MMU MapGPA:                   Applied
-- 
2.25.1

