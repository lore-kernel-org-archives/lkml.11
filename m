Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67760ECAAD1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiH3OmZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiH3OmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:42:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8888DB9595
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 07:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661870542; x=1693406542;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pu8Q/b4XRvcBDqBHduteESSvJpz3NewTom0z08Ex+p8=;
  b=Rjhuc+CUh9qc6eo9YXuX3lCt5OmO37dtcjyM9Yiv8vE7DnzHIA+tE+Nt
   KwfYkmcTQxHFoGGvJiwpr3xrLmbqeLlt56CK+wxtUWvWAvJML89NdCVRY
   3+HjO1BfGYeNeRYukAH3j8OwT4b8QzSLs4jE8898zqh+fU5YYSsXIM+RQ
   GcURbcda9RJBmDwcDKatr0krAzWzZlP4xKJ9K66QSLzPDinNKXFSstWDb
   yUoKRNxS9HO9KKceCxsbixZs0vJSu91uNTXj1XTsYjnBjiXJ599WY6/Wl
   nFwjVMmhDgIkQC1r4kYsW+Q/WZPUnNnAXMAETVk4q19sFUp70wTgMFNTd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="282163107"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="282163107"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 07:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="672890833"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2022 07:42:20 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oT2RY-0000Kh-18;
        Tue, 30 Aug 2022 14:42:20 +0000
Date:   Tue, 30 Aug 2022 22:42:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_sbi_dbcn_v1 15/42]
 drivers/irqchip/irq-riscv-intc.c:90:10: error: 'const struct irq_domain_ops'
 has no member named 'alloc'
Message-ID: <202208302216.JZekZCma-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_sbi_dbcn_v1
head:   74814d446b33fc095867181d8953a92ede0b042c
commit: 17f1dcd006f4ae2d52bb463151339b6af6ff7d08 [15/42] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220830/202208302216.JZekZCma-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/17f1dcd006f4ae2d52bb463151339b6af6ff7d08
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel riscv_sbi_dbcn_v1
        git checkout 17f1dcd006f4ae2d52bb463151339b6af6ff7d08
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/irqchip/irq-riscv-intc.c:90:10: error: 'const struct irq_domain_ops' has no member named 'alloc'
      90 |         .alloc  = riscv_intc_domain_alloc
         |          ^~~~~
   drivers/irqchip/irq-riscv-intc.c:90:19: warning: excess elements in struct initializer
      90 |         .alloc  = riscv_intc_domain_alloc
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-riscv-intc.c:90:19: note: (near initialization for 'riscv_intc_domain_ops')


vim +90 drivers/irqchip/irq-riscv-intc.c

    86	
    87	static const struct irq_domain_ops riscv_intc_domain_ops = {
    88		.map	= riscv_intc_domain_map,
    89		.xlate	= irq_domain_xlate_onecell,
  > 90		.alloc	= riscv_intc_domain_alloc
    91	};
    92	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
