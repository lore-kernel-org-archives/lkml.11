Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FCD5C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 12:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbiGOM1z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 08:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGOM1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:27:53 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6CC820D1;
        Fri, 15 Jul 2022 05:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657888072; x=1689424072;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w074g1tOYcgeAMYykMXyZe6g/HWtwmXYOmJTBgqRCRA=;
  b=eEhXXZ9w/mBhYw4YurongBdtQHUQVNjjJYJThs7aJXMxxRdn1NmwaxOo
   D47xktdc2wskDwnFXNjgSXAMzdosdFyMnBx1qURZy+inE/t0rfLS3PQFf
   skRRzwya7znoouImMRTpkPQoTQxD+72X9XtcyUkKMxTg5rXwri2QFRkcu
   i+nf6Fiog6K0ouz+bctmTThB4gf59LWO0RPqu9Ekg2id5r3PC3t6LdE/A
   VcAwVWMxfbuLhy9Vm8M4+Oa5BRvL8q9HYGtrBRBdwOLoLUP52Or2J/rfA
   eWpvuLjxVQQn4tX46++i2yL1btWZnq5Sayh8MJNAIasaL9j7JBaOzxgZW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="286521370"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="286521370"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 05:27:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="923489361"
Received: from skxmcp01.bj.intel.com ([10.240.193.86])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2022 05:27:50 -0700
From:   Yu Zhang <yu.c.zhang@linux.intel.com>
To:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        jmattson@google.com, joro@8bytes.org, wanpengli@tencent.com,
        kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix the #PF injection logic for smaller MAXPHYADDR in nested.
Date:   Fri, 15 Jul 2022 19:42:09 +0800
Message-Id: <20220715114211.53175-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM shall inject the #PF directly to L2 when L2 has a smaller MAXPHYADDR
and L1 has no desire to intercept it, yet currently the #PF will be
delivered to L1 anyway.

Patch 1 fixes this, by initializing the 'fault' variable.
Patch 2 is just a cleanup for the comments.

Yu Zhang (2):
  KVM: X86: Initialize 'fault' in kvm_fixup_and_inject_pf_error().
  KVM: X86: Fix the comments in prepare_vmcs02_rare()

 arch/x86/kvm/vmx/nested.c | 8 ++++----
 arch/x86/kvm/x86.c        | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.25.1

