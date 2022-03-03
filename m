Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681A7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 00:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiCCAYt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiCCAYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 19:24:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4A483BE
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 16:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646267043; x=1677803043;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fzm+qEROIyiUz+azDaC04IamnmVidu9TtEqHCSHAanM=;
  b=ZP5+tKmiM4ZYk2HafE2gPzqg5E8P0rsbEmS03l8Ovp27yO3Uavl26ip/
   s/DhhUkAaNzyqPSM4TXLkhgHrdE4BtO/+LD8/SAa6wRV//ju+9P5k5d8Y
   RlBg0r+gXT/NXlA02LgcvamkLUTG629gtkzwOi32Gr11cC4JJPN7pcBsF
   HpLDZP76uC8+tHoJUiZgmSRef5rwMuXI+COWrBajtjq5UxjMspHWHvMbM
   X65gPX6j5c5ZER9ALFEHbyYtl9hn89PpW2SxjRYz88Dvl0utGCz8UsKAj
   vCCjaGuCIq7ZeGSPgo6nhuq72zQx+hMSJ0x1S+qYnVzJmO1CAwJtD0jmq
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253467662"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="253467662"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 16:24:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="709711091"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 02 Mar 2022 16:24:02 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPZGD-00028M-Pu; Thu, 03 Mar 2022 00:24:01 +0000
Date:   Thu, 3 Mar 2022 08:23:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Burton <paul.burton@mips.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: undefined reference to `handle_fpe_int'
Message-ID: <202203030828.apRR1JFr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92ebf5f91b4dd5156886d2509202be0fb4230dfd
commit: 183b40f992c8f98082c4d72043ecdeba0e6a4367 MIPS: Allow FP support to be disabled
date:   3 years, 4 months ago
config: mips-randconfig-r005-20220130 (https://download.01.org/0day-ci/archive/20220303/202203030828.apRR1JFr-lkp@intel.com/config)
compiler: mipsel-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=183b40f992c8f98082c4d72043ecdeba0e6a4367
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 183b40f992c8f98082c4d72043ecdeba0e6a4367
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mipsel-linux-ld: arch/mips/dec/int-handler.o: in function `fpu':
>> (.text+0x148): undefined reference to `handle_fpe_int'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
