Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D75DC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 21:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiBZV2t (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Feb 2022 16:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiBZV2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 16:28:46 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D046237CB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 13:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645910890; x=1677446890;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oTye8vKFJqZjlm4c9geYjhA5WCoO7z0Wt5+FaMLYkgk=;
  b=kqxa0sByQtKU3Q7snddlQ8w7EJJRkvY3olgRtAlvul7ll6sNtTgL52j7
   jJhT8Ds3OqZYK2Zlkbw3JGiH2HCrQErglBB+OlOxouXS13cGPLRO1/VKH
   v61y1HbOdeDzy3AkjL4504ThEC/bd8lXjxbZCJKykREx3tPPJdeHAfnMz
   KdYycK3OO4HUarypoo/JMbPMuyKLJLR5K1kgXOnVdNBSFwrgFags5oNDv
   VM2sJmxoEkZctmx8H/+PICpX1XMUKchYKUgsdgHaeBw0maUzCIEhmQ67G
   p5zIz+7FkFeGXvYamxedjkbQANLXiwX4llA0QsGv5am7wBvh0AFNzrqnB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="240091118"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="240091118"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 13:28:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="509636129"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Feb 2022 13:28:09 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO4bo-0005yM-BJ; Sat, 26 Feb 2022 21:28:08 +0000
Date:   Sun, 27 Feb 2022 05:27:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: {standard input}:3918: Error: pcrel offset for branch to .LS001F too
 far (0x3e)
Message-ID: <202202270526.f1MqX0AN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2293be58d6a18cab800e25e42081bacb75c05752
commit: cf536e185869d4815d506e777bcca6edd9966a6e Makefile: extend 32B aligned debug option to 64B aligned
date:   9 months ago
config: csky-buildonly-randconfig-r005-20220227 (https://download.01.org/0day-ci/archive/20220227/202202270526.f1MqX0AN-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cf536e185869d4815d506e777bcca6edd9966a6e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout cf536e185869d4815d506e777bcca6edd9966a6e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:3918: Error: pcrel offset for branch to .LS001F too far (0x3e)

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LOCKDEP
   Depends on DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT && (FRAME_POINTER || MIPS || PPC || S390 || MICROBLAZE || ARM || ARC || X86)
   Selected by
   - PROVE_LOCKING && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT
   - DEBUG_LOCK_ALLOC && DEBUG_KERNEL && LOCK_DEBUGGING_SUPPORT

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
