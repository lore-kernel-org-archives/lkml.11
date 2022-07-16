Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A5C43334
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jul 2022 23:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiGPXXC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jul 2022 19:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiGPXWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:22:52 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38091208A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658013659; x=1689549659;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=wykNfR/iep6HPkaJF69DpWCCPgF53zZVnjM3Ja3R8ho=;
  b=PwWk5HnPsijRCWokixQL1OGokBRm4GRZH6FXiqJIcrHTmzuRsVO7KFr0
   +E9ODpwqcRyzsvnWUM81bcY5rlG+9lGVIIeQxyEHhe/I9h2tdz2cBORLQ
   wTdZLFw7lPaUJvJgXq17WPODNsxcp4Xqy0n6MHaf9dHvU0gTKGWU448HP
   1jwwwx2u+Goyn3bzH+5o57Q+nRa5jxIMedObaTnnzuDsXyfaxumKHUbJk
   VGMUdwMEVd7z7mPnVJLMblY8y9ECRdcpvyrXtEQFUzU5nmbl0CN6tCpI1
   F7znTole9r1s9xndRMSjFP/aqVe+ppIR8kRBb7gx1zJ7zLdj1oHejj6oz
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="266419901"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="266419901"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 16:20:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="699604349"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 16 Jul 2022 16:20:58 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCr5m-0002I2-0t;
        Sat, 16 Jul 2022 23:20:58 +0000
Date:   Sun, 17 Jul 2022 07:20:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final
 BE8 format
Message-ID: <202207170709.VKgrHNoN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   972a278fe60c361eb8f37619f562f092e8786d7c
commit: 5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3 ARM: rework endianess selection
date:   3 months ago
config: arm-randconfig-r014-20220717 (https://download.01.org/0day-ci/archive/20220717/202207170709.VKgrHNoN-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 5d6f52671e76ca2d55d74e676ac4c38ceb14a2d3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arm-linux-gnueabi-ld: error: .btf.vmlinux.bin.o is already in final BE8 format
   arm-linux-gnueabi-ld: failed to merge target specific data of file .btf.vmlinux.bin.o

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
