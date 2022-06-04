Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B89FC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jun 2022 21:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbiFDVaB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jun 2022 17:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239132AbiFDV34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 17:29:56 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF48D10D
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 14:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654378195; x=1685914195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gFNxvLYNZl1TZ2AZycae92kk6hqpmzLDuFh7sQB7liU=;
  b=MsUSTn5O8sJHG4KifG/TcvAJAMx3Fngh+N7637NYjL6DKF9khNMKYYQp
   V49LXmBysYvgTrZFVKDft7TKFef3TGM0oA4GQKnM6iDpOWZd+YZ411hWl
   z44oFYDa2O0xiU4kE0NSfjXzJpk7rvVKj+vFz/iW7lNDz/knOZHv34zOF
   XjndYVarAEiMoTtl8OyGTPNHX7QUsulGwQcA1pzckI3r9rxBzkzDhx679
   d+F8R6/UVXbm94coqPtG58AmHSf2lxuRdHxiaYyUusRS1z3zfJB6ZDlSd
   tEHJ+33YXB/OdFtBnL7eQmZKHlU6Ecq+PJ492dtUlAeMyxKkGXnePN+Ss
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="337163273"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="337163273"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 14:29:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="564293386"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 04 Jun 2022 14:29:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxbLE-000BDt-Qt;
        Sat, 04 Jun 2022 21:29:52 +0000
Date:   Sun, 5 Jun 2022 05:29:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Li Zhengyu <lizhengyu3@huawei.com>
Subject: ld.lld: error: undefined symbol: machine_kexec
Message-ID: <202206050554.XnCXKQwp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   032dcf09e2bf7c822be25b4abef7a6c913870d98
commit: 6261586e0c91db14c34f894f4bc48f2300cff1d4 RISC-V: Add kexec_file support
date:   2 weeks ago
config: riscv-randconfig-r012-20220605 (https://download.01.org/0day-ci/archive/20220605/202206050554.XnCXKQwp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0a90b72c432d70aae035727ece4ba80ce820f381)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6261586e0c91db14c34f894f4bc48f2300cff1d4
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 6261586e0c91db14c34f894f4bc48f2300cff1d4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: machine_kexec_cleanup
   >>> referenced by kexec_core.c
   >>> kexec_core.o:(kimage_free) in archive kernel/built-in.a
--
>> ld.lld: error: undefined symbol: riscv_crash_save_regs
   >>> referenced by kexec_core.c
   >>> kexec_core.o:(__crash_kexec) in archive kernel/built-in.a
--
>> ld.lld: error: undefined symbol: machine_crash_shutdown
   >>> referenced by kexec_core.c
   >>> kexec_core.o:(__crash_kexec) in archive kernel/built-in.a
--
>> ld.lld: error: undefined symbol: machine_kexec
   >>> referenced by kexec_core.c
   >>> kexec_core.o:(__crash_kexec) in archive kernel/built-in.a
   >>> referenced by kexec_core.c
   >>> kexec_core.o:(kernel_kexec) in archive kernel/built-in.a
--
>> ld.lld: error: undefined symbol: machine_shutdown
   >>> referenced by kexec_core.c
   >>> kexec_core.o:(kernel_kexec) in archive kernel/built-in.a
--
>> ld.lld: error: undefined symbol: machine_kexec_prepare
   >>> referenced by kexec_file.c
   >>> kexec_file.o:(__se_sys_kexec_file_load) in archive kernel/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
