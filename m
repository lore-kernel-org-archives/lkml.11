Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D97C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 15:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbiCBPsS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 10:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbiCBPsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:48:13 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CE31FCC5
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646236050; x=1677772050;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=gjdFb26op0SuccXH+Dqw1LZrlCOwANu8RdzBZDGSrJg=;
  b=mh2rU6pDYv6e89e8H2gkTEsy1gJJqq/vAvS3PV5BkAxG/JXSYRjzKISh
   Ar36sUODHHr17BflrxIPrBdZ75b1W74HPOdCjNbUcFTcoCmqZI4uQhxdz
   VcOj0mIdXWyGqj0V6MT0d++2XttEOYi/s+G15MpPEmqFfkJQM91Q4erGa
   xWtLWcUlnDf4RnFCxW1K6/qumEL2tMHupSwR8ogK2nNRpW3opT5qvZPRE
   EQEJM1+dHaaTYF/3XwSQCHeldQ2Dn3Ah2pA5eR67OPqoJo2rUihpuMVe3
   8P7E9mMRGRf+31aKm/oeHBI5cSTj8DuzNf1DvKYC/UQhKKI3EyWgwmsJ6
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="278103463"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="278103463"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 07:47:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="576146627"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 02 Mar 2022 07:47:11 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPRC3-0001X0-5y; Wed, 02 Mar 2022 15:47:11 +0000
Date:   Wed, 02 Mar 2022 23:46:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [paulmck-rcu:rcu/next] BUILD SUCCESS
 1498a74770d7ec2f6b62083cbd671c2ca7ca7549
Message-ID: <621f9154.AW4rv7+OIBOAjuS2%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
branch HEAD: 1498a74770d7ec2f6b62083cbd671c2ca7ca7549  torture: Enable CSD-lock stall reports for scftorture

elapsed time: 1121m

configs tested: 115
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
sh                          kfr2r09_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc837x_mds_defconfig
sh                     magicpanelr2_defconfig
m68k                        mvme16x_defconfig
sh                              ul2_defconfig
sh                            migor_defconfig
microblaze                          defconfig
m68k                          amiga_defconfig
arm                            pleb_defconfig
sh                        apsh4ad0a_defconfig
arm                          iop32x_defconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
arm                         nhk8815_defconfig
sh                      rts7751r2d1_defconfig
sh                           se7724_defconfig
h8300                            alldefconfig
powerpc                   motionpro_defconfig
arm                            qcom_defconfig
ia64                             alldefconfig
arm                        oxnas_v6_defconfig
m68k                        stmark2_defconfig
mips                     decstation_defconfig
powerpc                     taishan_defconfig
i386                                defconfig
powerpc                         ps3_defconfig
arm                         axm55xx_defconfig
powerpc                        warp_defconfig
sh                         ecovec24_defconfig
sh                           se7780_defconfig
arm                  randconfig-c002-20220301
arm                  randconfig-c002-20220302
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
powerpc                     mpc5200_defconfig
arm                                 defconfig
powerpc                  mpc866_ads_defconfig
arm                          imote2_defconfig
arm                      pxa255-idp_defconfig
mips                     cu1830-neo_defconfig
arm                        mvebu_v5_defconfig
arm                         lpc32xx_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
