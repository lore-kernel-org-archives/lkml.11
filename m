Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5EEECAAA2
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Aug 2022 03:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244598AbiHZD1M (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 23:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiHZD1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 23:27:08 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86352CE32F
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661484427; x=1693020427;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xh85nLxaUjBtsJIZl9k+ItWaOqSFiLEU2F325yruyQ4=;
  b=GxbROKPidn0v6ZbqXETvD2EqxkN50snqFvv+69VEdwokBK2WlqPLHMQp
   JdBmBIR7xAag99VfRewji6Gw8OLcMc+hbCHVYJIvM3PZ8iRTSTEUjFX5c
   yq/WDTusvDjlhO6YEz+eHmMaID6MuCzB+Qp4t1iSXNYlhcZgLUcvVTJDJ
   YkX/0VMipTh9lP0+3/z3qLO3/4nVO+JzR75w7gYuxPwHNUOMXumvRx3n0
   g54yHoJUrX4ymGqdf3pb1SAfQou98F+zZC4F193qnDLQP0bbhNHhyWDJW
   J/peKeI0M1chD7ctI8crG4eFtWuOMIegmU41dy4D21Qwtmb38xPvdje5J
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="358380227"
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="358380227"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 20:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="587145796"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2022 20:26:47 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRPza-0003IM-2o;
        Fri, 26 Aug 2022 03:26:46 +0000
Date:   Fri, 26 Aug 2022 11:26:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [rt-devel:linux-6.0.y-rt-rebase 22/59] kernel/softirq.c:640:1:
 sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be
 static?
Message-ID: <202208261154.FhNaCbjE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git linux-6.0.y-rt-rebase
head:   1d8c2694d3f649c97636d991dca099bd86f63f97
commit: 18e8ee31af7ca8ec3b042a2b5bc76d2d3772c78d [22/59] rcutorture: Also force sched priority to timersd on boosting test.
config: alpha-randconfig-s051-20220824 (https://download.01.org/0day-ci/archive/20220826/202208261154.FhNaCbjE-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git/commit/?id=18e8ee31af7ca8ec3b042a2b5bc76d2d3772c78d
        git remote add rt-devel https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
        git fetch --no-tags rt-devel linux-6.0.y-rt-rebase
        git checkout 18e8ee31af7ca8ec3b042a2b5bc76d2d3772c78d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/softirq.c:640:1: sparse: sparse: symbol '__pcpu_scope_timersd' was not declared. Should it be static?

vim +/__pcpu_scope_timersd +640 kernel/softirq.c

   639	
 > 640	DEFINE_PER_CPU(struct task_struct *, timersd);
   641	static DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
   642	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
