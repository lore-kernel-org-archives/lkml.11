Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035BDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 03:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbiBYDlb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 22:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiBYDla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:41:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2FF20B146
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 19:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645760459; x=1677296459;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/0LDxB0jJfdH+X/YIhUcuZWk8CKS73miUzIcakpdLhs=;
  b=jUKpwfEhIx6GzCiZJF2Zf3dYN2oFl7MWTD2OodX8c/ktplTR2x3WcOq0
   VW/LaguGeZCO/qGYOmTrrJL8yMVMb+yV+HJmPGTUbkusf+DVYh1Il4iJN
   DTOox6ZdaCcac9EDgVgyvziwuNPOuHVcDthrbpsGHk339ubEicVX1NTvI
   vWjkNRGfh5Ps5Z9+JxeEFmgsfBL8o2OUWZoQAp/QMD6lTJ9rChoByS4ZY
   zjTHYAHDCCg29uwCK7qTRXG6n+TXy8KVyZP7duVLb96J8yXHamBG9dYwG
   pgHcZfIPnzi+bHYAIVXdNTyMrkeKekUxDxB9OoXmrX9j7RhxmBPF93De8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338849610"
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="338849610"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:40:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,135,1643702400"; 
   d="scan'208";a="592326126"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2022 19:40:44 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNRTH-0003nz-IY; Fri, 25 Feb 2022 03:40:43 +0000
Date:   Fri, 25 Feb 2022 11:39:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [at91:at91-dt 6/12] Error: arch/arm/boot/dts/sama7g5.dtsi:102.21-22
 syntax error
Message-ID: <202202251149.RXyNYfXS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git at91-dt
head:   85aa52c46d5e8461eb2b87f8558e89cb83e4ab29
commit: 91b2007aba2e00f0cb9e0f9fa0a2db92cfeb70ff [6/12] ARM: dts: at91: sama7g5: Add NAND support
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220225/202202251149.RXyNYfXS-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/commit/?id=91b2007aba2e00f0cb9e0f9fa0a2db92cfeb70ff
        git remote add at91 https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git
        git fetch --no-tags at91 at91-dt
        git checkout 91b2007aba2e00f0cb9e0f9fa0a2db92cfeb70ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/sama7g5.dtsi:102.21-22 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
