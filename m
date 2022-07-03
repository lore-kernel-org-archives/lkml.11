Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F19C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Jul 2022 19:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiGCTYN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 15:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiGCTYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:24:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA44821BE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 12:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656876248; x=1688412248;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DgUOhaZL+doTdcI97hc5GqPza7xHDjOMzIf1Et6iK8k=;
  b=g685l9CBeJWX+QJGPs/NA5UZGaQyENsHmmjVho+rPwTTwDB+Ks5ANukE
   KPOv88fa1sOmQqF5V7pDo13kowuADJcl1d3mrWplZ7CR8q2n+yMWY0nI5
   sRA7WrkUOwnP50yZfYXpzLbtlpuE15K8COozFcZBS9eGHQ8qB2hmJGbk1
   K3DnHG79aRVNLH+qu/0kPg9r3ewRVabuklqBiQpZl8nVLZlIYzEegxrt/
   6bDYq2XXdavV6BkW+0xKCSHjB0NoZ4Grt3Cb/eTRwGjYNdJjPoDs/9dBX
   u9PdJ4xVxTr8zEcI4QS9kHjDvxDvPODEHJlnRvcRkq/jbXEraZuwg78Xt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10397"; a="344657179"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="344657179"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2022 12:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="566916786"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2022 12:24:07 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o85CQ-000Gsl-EE;
        Sun, 03 Jul 2022 19:24:06 +0000
Date:   Mon, 4 Jul 2022 03:23:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Morse <james.morse@arm.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [morse:mpam/snapshot/v5.18 141/147] kismet: WARNING: unmet direct
 dependencies detected for RESCTRL_IOMMU when selected by ARM_CPU_RESCTRL
Message-ID: <202207040300.a956MZuI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git mpam/snapshot/v5.18
head:   9d1850bbdc3c9b2b9b6fce8963cde5b0a38fb2d7
commit: f2c8bd0e60bf35e9e12e5866c986cc2de96ab0e6 [141/147] untested: fs/resctrl: Add support for assigning iommu_groups to resctrl groups
config: (https://download.01.org/0day-ci/archive/20220704/202207040300.a956MZuI-lkp@intel.com/config)
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?id=f2c8bd0e60bf35e9e12e5866c986cc2de96ab0e6
        git remote add morse https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
        git fetch --no-tags morse mpam/snapshot/v5.18
        git checkout f2c8bd0e60bf35e9e12e5866c986cc2de96ab0e6
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_RESCTRL_IOMMU --selectors CONFIG_ARM_CPU_RESCTRL -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for RESCTRL_IOMMU when selected by ARM_CPU_RESCTRL
   
   WARNING: unmet direct dependencies detected for RESCTRL_IOMMU
     Depends on [n]: MISC_FILESYSTEMS [=n]
     Selected by [y]:
     - ARM_CPU_RESCTRL [=y] && ARM64 [=y] && ARCH_HAS_CPU_RESCTRL [=y] && ARM_SMMU_V3 [=y]
   
   WARNING: unmet direct dependencies detected for RESCTRL_FS
     Depends on [n]: MISC_FILESYSTEMS [=n] && ARCH_HAS_CPU_RESCTRL [=y]
     Selected by [y]:
     - ARM64_MPAM [=y]
   
   WARNING: unmet direct dependencies detected for RESCTRL_RMID_DEPENDS_ON_CLOSID
     Depends on [n]: MISC_FILESYSTEMS [=n]
     Selected by [y]:
     - ARM_CPU_RESCTRL [=y] && ARM64 [=y] && ARCH_HAS_CPU_RESCTRL [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
