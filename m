Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1036C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 21:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240422AbiGHVBP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 17:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbiGHVBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 17:01:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37E86547;
        Fri,  8 Jul 2022 14:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657314070; x=1688850070;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Yoww4SLGe7Zan0PdL2poiGB/sv86HmPit8PeAmTEsxg=;
  b=L028gRz5ixpRtvfhcPbkYN4WgJZh/rOVJnx1L0n8OdD54k1Cyh/tFIMf
   W+s05nxuuIye3G24HOAiaydX4ujrEqDOi24A9xcwe/u89Z8sEPke9+pT7
   NXgdu+QEkVMK56R55RnWk6y21RqYxbEOtyz9jaIDbAE5pl8dIhJE2nhkL
   NYYhqkDtLHzJILJKkmf4h6O9J1WjyJJYHntpBNcrMiWxOuXHMCoq4kp6V
   kCuTBWf+NbvDdDK19r9moeENEqpVqzBMqiMCgkbmBum0aZDSZkET9cv5J
   cqyGHGKlbdeq7iZuAhzae1g6xP+AHAgnaqNNljSAbdOLw0jl+h8zvFtG4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10402"; a="284387784"
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="284387784"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2022 14:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,256,1650956400"; 
   d="scan'208";a="544337068"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 08 Jul 2022 14:01:08 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9v63-000Nvg-Fg;
        Fri, 08 Jul 2022 21:01:07 +0000
Date:   Sat, 9 Jul 2022 05:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 130/411] htmldocs:
 Documentation/x86/tdx.rst:69: WARNING: Unexpected indentation.
Message-ID: <202207090435.U7loKEX3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   36253a6ed7e922a2e6888cde465578b98145404e
commit: 9b8d86c1e54a7018b65c179d4ede26ad89746c7c [130/411] Documentation/x86: Add documentation for TDX host support
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/x86/tdx.rst:69: WARNING: Unexpected indentation.
>> Documentation/x86/tdx.rst:70: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +69 Documentation/x86/tdx.rst

    66	
    67	        ret = tdx_init();
    68	        if (ret)
  > 69	                goto no_tdx;
  > 70	        // TDX is ready to use
    71	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
