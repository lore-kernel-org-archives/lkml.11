Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AFDAC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 20:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358417AbiELUhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 May 2022 16:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358404AbiELUhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:37:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FA9483A5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652387829; x=1683923829;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sJns4Zakux3U6ugKMkl/CKKaonPuYM6F/Elq9CtKmqo=;
  b=f1LIgWmRFslOMGphph8wgSKiFmQ7D0VAb5FkvSZglyGing+4rDfri7F0
   vxydSPvd06/wMpWcycsiTUBQD/sd1Qb9DfgkNxrG6XMDHvCe0ATm48sc3
   2ORrTBLdzD3eF4MY/H0QP4ZvFDt2lXdlBnZAKlQ90PZGVU8yXL/wYe4yP
   ePsX41re/xZHCx+KbLtrgJkiloEXn6RgCFwZsDLnWkuej0715wo4WuKv5
   YI2BiA+86QrZi895ID8UTHqLZAYCMwAMNmcn4TWsrEbZSaMbCuQeYt3zU
   8pzssCy0K5KX9INpFtmfhhDZeAORknFaNDNknbdHbIwj7xEx1yl2Ryn65
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="333164386"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="333164386"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 13:36:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="553931668"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 May 2022 13:36:49 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npFYH-000Ku2-7z;
        Thu, 12 May 2022 20:36:49 +0000
Date:   Fri, 13 May 2022 04:36:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: ERROR: modpost: "devm_ioremap"
 [drivers/net/ethernet/altera/altera_tse.ko] undefined!
Message-ID: <202205130434.HnLCNmz3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0ac824f379fba2c2b17b75fd5ada69cd68c66348
commit: ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f PHY: Ingenic: fix unconditional build of phy-ingenic-usb
date:   1 year, 4 months ago
config: s390-buildonly-randconfig-r006-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130434.HnLCNmz3-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout ef019c5daf032dce0b95ed4d45bfec93c4fbcb9f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "devm_ioremap" [drivers/net/ethernet/altera/altera_tse.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
