Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F83C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 19:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiHWTJT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 15:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231919AbiHWTIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:08:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022D665D5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661276848; x=1692812848;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g3N8QaZ47KTjxRr1VmyrexxfaDyUTuIj7D/06GMA7EQ=;
  b=R+PRJTZKLawuzOW9r3UW+c/kNIIzP/XsxOgZfkoTI2FqjdpiczW3wNBc
   n+tTLDNkW17M0RTUS8j/hAqX94xBcs82G0RiVHwWpm+TZ1X6XmgibeuUh
   Z2n4+5VYVDN4Wm4WaHCYqOiC8wac5t7JnrJ5mIzZJ5pGnMB5VV7eCiBko
   RutXd269LGJ1U4q7KAII3s287vaMT+n7VfEhQ0UVnsB5U/X5i+QZH4mD3
   3X5u0u3fj3kfROBJkFX750hnIBgALG4gW1Gd9s6sXbNzFanf4jlhMcSJ+
   WufSm1jswTbwx98whceWyjDZKUJ+zL2/JTMpe0ZtiV6su31U7kiS7grrY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="319806585"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="319806585"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:45:43 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="642530901"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 10:45:43 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/cpu: Add yet another Raptorlake CPU model number
Date:   Tue, 23 Aug 2022 10:45:30 -0700
Message-Id: <20220823174530.223914-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a second model number used by Raptorlake client CPUs.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/intel-family.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index def6ca121111..c4e316921dd5 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -22,6 +22,7 @@
  *		Common OPTDIFFs:
  *
  *			- regular client parts
+ *		_S	- other client parts
  *		_L	- regular mobile parts
  *		_G	- parts with extra graphics on
  *		_X	- regular server parts
@@ -112,6 +113,7 @@
 
 #define INTEL_FAM6_RAPTORLAKE		0xB7
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
+#define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 /* "Small Core" Processors (Atom) */
 
-- 
2.35.3

