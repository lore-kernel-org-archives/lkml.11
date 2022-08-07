Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8375C19F2A
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Aug 2022 22:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241576AbiHGWGp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Aug 2022 18:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiHGWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 18:03:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29BB9FE4;
        Sun,  7 Aug 2022 15:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659909762; x=1691445762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yzsW3HP34uHnzDykzPATauL2DDgMbwFkjBwFhJu1DX0=;
  b=Hz1IyAMDLGa/G4Bq3i88feVDceMVkco+oL9T7pijgQMRn028XfoL9sIB
   FSEguCS8YJjBxM5OQ32NDGoo2xiEneV3IWSMkx3JBdR9bPjD8+eLeVeBZ
   ZzOjchBUTAVHW3bHYiOcLkLsYMlrvXXlUiSEd3ZoF7HT3yyspKAGHdJGC
   e6VFwtGmOKQ1QrQVj1FPnKI2XYMsV1kQ0fwihfDVIBkt24Qq7mShHTmAC
   1t7GqezxMxkuehqmaxwDbaJOVavHs0LKaLW+ttU1p2CMkNHcMfamampfX
   Y7+tHoEdmRr9F1stcssElYAyaHYhkwVdlxYmxRBXwhTeAhap/LYdAWB2z
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10432"; a="354465752"
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="354465752"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 15:02:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,220,1654585200"; 
   d="scan'208";a="663682638"
Received: from ls.sc.intel.com (HELO localhost) ([143.183.96.54])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 15:02:38 -0700
From:   isaku.yamahata@intel.com
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@intel.com, isaku.yamahata@gmail.com,
        Paolo Bonzini <pbonzini@redhat.com>, erdemaktas@google.com,
        Sean Christopherson <seanjc@google.com>,
        Sagi Shahar <sagis@google.com>
Subject: [PATCH v8 059/103] [MARKER] The start of TDX KVM patch series: TD finalization
Date:   Sun,  7 Aug 2022 15:01:44 -0700
Message-Id: <cac4477aa7bd680626915451e180b3f7fa46a058.1659854790.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1659854790.git.isaku.yamahata@intel.com>
References: <cover.1659854790.git.isaku.yamahata@intel.com>
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

