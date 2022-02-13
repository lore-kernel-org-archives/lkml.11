Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DA0C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Feb 2022 19:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237949AbiBMTaO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Feb 2022 14:30:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBMTaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 14:30:13 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7237B56C11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 11:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644780606; x=1676316606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Z+IPQbc3DoIThr1y05QJVgCJisA7QjZzfj+r0fgo/G8=;
  b=Mgz9UvtJAjrzRZZ36064nW6jLT4hdq6BCkJBCsPHKzfwSuS1G6YHYypw
   T5iQIDjRO0Drpu4YZKyYJPJmXylTkU1SOlX5UO9+p1lLV1CcPdhWXZvvD
   LGLwRzfP7Ke0CwClK44IKV6nUPVgIlehrlsERje7G+MTOR8S5/bE5C2AE
   x3dL6HH/tuf0UWCOfQ6TTyx7tMGTCrjAmzJJk74aeLv/d/KZU/UDDAnki
   uCJDgoh+tMyV5WjH/vyk73rzSUupxC+etUwMj9h3A0RxkwJZA0oHJjLhQ
   dzgsAFurux90RFPopDEgjvvkjOXG1Ue5jPRHdpRfrKPz0G22RUo3Y4/c3
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249717716"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="249717716"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 11:30:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="484955778"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2022 11:30:04 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJKZP-0007mF-WD; Sun, 13 Feb 2022 19:30:04 +0000
Date:   Mon, 14 Feb 2022 03:29:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: kernel/sched/rt.c:257:6: error: no previous prototype for function
 'unregister_rt_sched_group'
Message-ID: <202202140339.Uk9VGrvV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b81b1829e7e39f6cebdf6e4d5484eacbceda8554
commit: b027789e5e50494c2325cc70c8642e7fd6059479 sched/fair: Prevent dead task groups from regaining cfs_rq's
date:   3 months ago
config: riscv-randconfig-c006-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140339.Uk9VGrvV-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 478c237e21b2c3a83e46f26fcbeb3876682f9b14)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b027789e5e50494c2325cc70c8642e7fd6059479
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b027789e5e50494c2325cc70c8642e7fd6059479
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/ drivers/clk/bcm/ drivers/gpu/drm/ kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/sched/rt.c:257:6: error: no previous prototype for function 'unregister_rt_sched_group' [-Werror,-Wmissing-prototypes]
   void unregister_rt_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/rt.c:257:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void unregister_rt_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/rt.c:259:6: error: no previous prototype for function 'free_rt_sched_group' [-Werror,-Wmissing-prototypes]
   void free_rt_sched_group(struct task_group *tg) { }
        ^
   kernel/sched/rt.c:259:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void free_rt_sched_group(struct task_group *tg) { }
   ^
   static 
   kernel/sched/rt.c:261:5: error: no previous prototype for function 'alloc_rt_sched_group' [-Werror,-Wmissing-prototypes]
   int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
       ^
   kernel/sched/rt.c:261:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
   ^
   static 
   kernel/sched/rt.c:675:6: error: no previous prototype for function 'sched_rt_bandwidth_account' [-Werror,-Wmissing-prototypes]
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
        ^
   kernel/sched/rt.c:675:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
   ^
   static 
   4 errors generated.


vim +/unregister_rt_sched_group +257 kernel/sched/rt.c

   256	
 > 257	void unregister_rt_sched_group(struct task_group *tg) { }
   258	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
