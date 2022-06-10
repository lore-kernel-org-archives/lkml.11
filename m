Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F023C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 04:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbiFJE1G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 00:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiFJE1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 00:27:03 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29C21D491
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 21:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654835223; x=1686371223;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uazHZwevntjsAVAjIl+HPS16ETFIYtI7hPDAFNU6USc=;
  b=KsnTw5YKaH3lPdthtNvDtnLu4vJBadBoRmZElINPQLQuNb8bJ3GDDDBg
   Y1eXa7WVhMs+he/DwxtZKJRRuyASFFWDZ4KJ942wB0DLVfsJkXiB2rRTq
   kcV/vYZhctYIZGjNvZUjAbS5Kb6btW+cKgdmkru2eJ8TpyZlYA0UBWgZk
   qesiPy5t3abhvSyxQXtqWId8rztR9R3hJ5AsfN0BsKvFwhbq9UOIkCd65
   5aKiF65Wx6GZB3NmBRS13fOBrkk9wFD/88+nHHx5RhS2yGIIfSEcN0cim
   I3cGYViMfYsBAFhe46bWsCBEDGnoMpFB8h8Xk9zsrCvtMdMmXI6QElH5C
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="278313611"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="278313611"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 21:27:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="585993201"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2022 21:27:01 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzWEe-000Ghh-Ha;
        Fri, 10 Jun 2022 04:27:00 +0000
Date:   Fri, 10 Jun 2022 12:26:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mayuresh Chitale <mchitale@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [avpatel:virtio_rpmsg_bus_fix_v1 35/52]
 arch/riscv/include/asm/tlbflush.h:33:1: error: type defaults to 'int' in
 declaration of 'DECLARE_STATIC_KEY_FALSE'
Message-ID: <202206101257.TRD6p5sy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git virtio_rpmsg_bus_fix_v1
head:   390aaf641ff2f8919268d611e864227265c3f3f2
commit: efaaec7bcbaf3346e07955be46d5e3c2bd662167 [35/52] riscv: mm: use svinval instructions instead of sfence.vma
config: riscv-randconfig-r002-20220609 (https://download.01.org/0day-ci/archive/20220610/202206101257.TRD6p5sy-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/efaaec7bcbaf3346e07955be46d5e3c2bd662167
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel virtio_rpmsg_bus_fix_v1
        git checkout efaaec7bcbaf3346e07955be46d5e3c2bd662167
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/ipv4/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/compat.h:17,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from net/ipv4/route.c:63:
>> arch/riscv/include/asm/tlbflush.h:33:1: warning: data definition has no type or storage class
      33 | DECLARE_STATIC_KEY_FALSE(riscv_flush_tlb_svinval);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/tlbflush.h:33:1: error: type defaults to 'int' in declaration of 'DECLARE_STATIC_KEY_FALSE' [-Werror=implicit-int]
>> arch/riscv/include/asm/tlbflush.h:33:1: warning: parameter names (without types) in function declaration
   net/ipv4/route.c: In function 'ip_rt_send_redirect':
   net/ipv4/route.c:880:13: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
     880 |         int log_martians;
         |             ^~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/riscv/include/asm/pgtable.h:108,
                    from arch/riscv/include/asm/uaccess.h:12,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/compat.h:17,
                    from arch/riscv/include/asm/elf.h:12,
                    from include/linux/elf.h:6,
                    from include/linux/module.h:19,
                    from net/ipv4/inetpeer.c:10:
>> arch/riscv/include/asm/tlbflush.h:33:1: warning: data definition has no type or storage class
      33 | DECLARE_STATIC_KEY_FALSE(riscv_flush_tlb_svinval);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/include/asm/tlbflush.h:33:1: error: type defaults to 'int' in declaration of 'DECLARE_STATIC_KEY_FALSE' [-Werror=implicit-int]
>> arch/riscv/include/asm/tlbflush.h:33:1: warning: parameter names (without types) in function declaration
   cc1: some warnings being treated as errors


vim +33 arch/riscv/include/asm/tlbflush.h

    31	
    32	/* Check if we can use sinval for tlb flush */
  > 33	DECLARE_STATIC_KEY_FALSE(riscv_flush_tlb_svinval);
    34	#define riscv_use_flush_tlb_svinval() \
    35		static_branch_unlikely(&riscv_flush_tlb_svinval)
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
