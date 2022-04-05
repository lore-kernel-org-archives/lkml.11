Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18366C4332F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 21:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352784AbiDEVKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573703AbiDETpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:45:30 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C091A208
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649187810; x=1680723810;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FBU+tAHtxcA3U+08ZDABcnOpS8ebJ2z+wPcv1j7H39E=;
  b=Gz352RBU4yL6prwohET1kqCKEGrxiNZtw5S8NxrKL5IunMXZL3eDfcfz
   gBIQ9jNqp5lB1v8Fyp2deUoQ2QPO0AFe56XBDvHFxz7TXbf07uOO6qaFQ
   KRQPHuQifyNeMKkgF1GdWgpFqZU+PywgTjUd7PIllozqIJVjjmHcSemGr
   9yre+q9COYUWz1RT0VmqCxxYd3MnwLUk0Ntm1nBSugRfmtymJEnAkybKz
   FMiV53AwzKbLsSKpMRK0DNrWp8+3wNx5MIhdW6ssdY/pDmw93VHZ1V+mD
   C+LpZIVz5bD8JwThGr7N9b5Myoq4/wPS6CFQsRwiaRpcSCFdAA/wpgBk8
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="285809835"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="285809835"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 12:43:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="524139308"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 12:43:28 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbp5M-0003hr-7N;
        Tue, 05 Apr 2022 19:43:28 +0000
Date:   Wed, 6 Apr 2022 03:43:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: WARNING: modpost: vmlinux.o(.text.unlikely+0x3120): Section mismatch
 in reference from the function trace_define_common_fields() to the variable
 .init.data:initcall_level_names
Message-ID: <202204060353.d0FrU970-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3e732ebf7316ac83e8562db7e64cc68aec390a18
commit: a55f224ff5f238013de8762c4287117e47b86e22 tracing: Fix pid filtering when triggers are attached
date:   4 months ago
config: xtensa-randconfig-r026-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060353.d0FrU970-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a55f224ff5f238013de8762c4287117e47b86e22
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a55f224ff5f238013de8762c4287117e47b86e22
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

<< WARNING: modpost: vmlinux.o(.text.unlikely+0x2f30): Section mismatch in reference from the function init_tracefs.isra.0() to the variable .init.data:initcall_level_names
>> WARNING: modpost: vmlinux.o(.text.unlikely+0x3120): Section mismatch in reference from the function trace_define_common_fields() to the variable .init.data:initcall_level_names
The function trace_define_common_fields() references
the variable __initdata initcall_level_names.
This is often because trace_define_common_fields lacks a __initdata
annotation or the annotation of initcall_level_names is wrong.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
