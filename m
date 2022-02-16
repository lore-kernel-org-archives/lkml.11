Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C004C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 04:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344467AbiBPEkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 23:40:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344444AbiBPEkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:40:42 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FA5F406B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644986430; x=1676522430;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f9nny1FjAVESb1bhZWB+zYKFO3ktt8MPMbm+cj2MSrA=;
  b=kSRTr3ahalhDwqMBJ4c6dFu8inO+lwzs99c8jx0c5M/zBUaiQ5b5wAJP
   EVUynJEihjPxGjpggDkUveOsg+EChnJ6G4yHWbNJLVA33G2lsSLdq5syb
   WnJZeQqqELo9vYsCN3XLLjQ4P2ur7fOiGLi0+/HhfAhW6cXDQnICuOhpa
   bblOTcPLg2GpnB+xgpofUs4fLWk+uV6qzMzRnaWGhbsUVK785OxAnPIjT
   7AG877MemZ9BPNKZRS8kxOd2g7mzBBV21IaKREk9H2Iwdvx8CBgb8pvaN
   3FqJyWx2h6xTxgXZ+TMljo+xSgAn8APsRofgSSX5FVK9gqHKFuHBxviwh
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275101907"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="275101907"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 20:40:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="498189992"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Feb 2022 20:40:24 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKC75-000APW-JR; Wed, 16 Feb 2022 04:40:23 +0000
Date:   Wed, 16 Feb 2022 12:40:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [ebiggers:crypto-pending 7/7]
 arch/arm64/crypto/polyval-ce-glue.c:355:33: warning: unused variable
 'polyval_cpu_feature'
Message-ID: <202202161205.0mACsVya-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crypto-pending
head:   67824d3cb5325de4264ad344174a7e4ea69e5303
commit: 67824d3cb5325de4264ad344174a7e4ea69e5303 [7/7] crypto: arm64/polyval: Add PMULL accelerated implementation of POLYVAL
config: arm64-randconfig-r033-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161205.0mACsVya-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0e628a783b935c70c80815db6c061ec84f884af5)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/commit/?id=67824d3cb5325de4264ad344174a7e4ea69e5303
        git remote add ebiggers https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git
        git fetch --no-tags ebiggers crypto-pending
        git checkout 67824d3cb5325de4264ad344174a7e4ea69e5303
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/crypto/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/crypto/polyval-ce-glue.c:355:33: warning: unused variable 'polyval_cpu_feature' [-Wunused-const-variable]
   static const struct cpu_feature polyval_cpu_feature[] = {
                                   ^
   1 warning generated.


vim +/polyval_cpu_feature +355 arch/arm64/crypto/polyval-ce-glue.c

   354	
 > 355	static const struct cpu_feature polyval_cpu_feature[] = {
   356		{ cpu_feature(PMULL) }, { }
   357	};
   358	MODULE_DEVICE_TABLE(cpu, polyval_cpu_feature);
   359	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
