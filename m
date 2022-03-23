Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE97C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 07:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242285AbiCWHnz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiCWHnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:43:53 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910D87306E
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648021344; x=1679557344;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ygLNADackCmR2jzQmDaUNEkOL3IhABMfIUt16EPr7GI=;
  b=FBsI2trHPBlMsnPXJayDnoDW/Ae2Rcn3i0bKh12ieyJqUF70fB/MgC9d
   zcAbpxGKpzNa7gdGe2/LzcWHGgL/GoymS4p/TJ3FVJnIBFs1O2GMssNtp
   HiKeLP3+niOXTiWZ3pqTEEVdEOcBLL+9nE06cjwYS2HJRB19rkga0P0jI
   VDtW9rRaqLmgjVtMCWHrekdlytlIGKPfVnR/a9uduGRHHa9khqvIUGZ0+
   vHiichsZCsIDd8n/Rrte4LZ/tXas+M8zWoHqV2apACBP2mWjXJqpTDggY
   xb6/M8qMblro72JWTD+QKrqQyssxHV0QglDwZx5URfaG90Z/V/kQTxEsN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="282889920"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="282889920"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 00:42:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="717289042"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2022 00:42:22 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWvdN-000Jnr-FV; Wed, 23 Mar 2022 07:42:21 +0000
Date:   Wed, 23 Mar 2022 15:41:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atish Patra <atishp@rivosinc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Anup Patel <anup@brainfault.org>
Subject: arch/riscv/kernel/cpu_ops_sbi.c:24:1: sparse: sparse: symbol
 '__pcpu_scope_boot_data' was not declared. Should it be static?
Message-ID: <202203231551.BfR9MKWQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6b1f86f8e9c7f9de7ca1cb987b2cf25e99b1ae3a
commit: 9a2451f1866344d38b4a1dc20396e3a03954fcd7 RISC-V: Avoid using per cpu array for ordered booting
date:   9 weeks ago
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220323/202203231551.BfR9MKWQ-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9a2451f1866344d38b4a1dc20396e3a03954fcd7
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9a2451f1866344d38b4a1dc20396e3a03954fcd7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/kernel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/cpu_ops_sbi.c:24:1: sparse: sparse: symbol '__pcpu_scope_boot_data' was not declared. Should it be static?

vim +/__pcpu_scope_boot_data +24 arch/riscv/kernel/cpu_ops_sbi.c

    15	
    16	extern char secondary_start_sbi[];
  > 17	const struct cpu_operations cpu_ops_sbi;
    18	
    19	/*
    20	 * Ordered booting via HSM brings one cpu at a time. However, cpu hotplug can
    21	 * be invoked from multiple threads in parallel. Define a per cpu data
    22	 * to handle that.
    23	 */
  > 24	DEFINE_PER_CPU(struct sbi_hart_boot_data, boot_data);
    25	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
