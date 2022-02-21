Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0839C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 01:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245410AbiBUBB1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Feb 2022 20:01:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbiBUBBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 20:01:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A87A40A23
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 17:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645405263; x=1676941263;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AE7SrTfmgLf86nxtawr2ZZGRGlQywR2+2dAYA8i/tK4=;
  b=E2ARRkQu0qLmiKzz+9J3ptyKapbimcwHYVZQdOpluVXliwukK1WLb64m
   LGeABUxe3ZKzhX2+JZQh6P0VryQ5zEkkjWNZRxX/ubGxR0eb3rMJY9doR
   fC1It6qmhnm3z0IB6MmLacnS/E4aCr6yZGgtAOnxpZH1VNar0B7XNvA8Z
   Hu7xSTjI4wEmE1zf94g9QGwZmYWtf9Qz11VjBwSq9MWBq+VFqVoYqyLHb
   Y1PSrN3yN33HL9KzNxkPu6X9v7JNgBGeNexLNIvOM3FHTA1iqHujduT23
   CgG9CFMexP+uHgGX0m1aYhxvtXbHwSAfrHLGLyqhUJLXhslEQMy1SLUCs
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10264"; a="251596791"
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="251596791"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2022 17:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,384,1635231600"; 
   d="scan'208";a="706067791"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 20 Feb 2022 17:01:01 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nLx4W-00017G-Eg; Mon, 21 Feb 2022 01:01:00 +0000
Date:   Mon, 21 Feb 2022 09:00:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bo Jiao <Bo.Jiao@mediatek.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>
Subject: [nbd168-wireless:mt76 8/22] ERROR: modpost: "__aeabi_ldivmod"
 [drivers/net/wireless/mediatek/mt76/mt7915/mt7915e.ko] undefined!
Message-ID: <202202210822.gUmfl8An-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/nbd168/wireless mt76
head:   5a42c2f71d00b1df6f5790623bce66596a640e5f
commit: 1df906b554bcad9da1eb7e42952fa58133f577e8 [8/22] mt76: mt7915: add support for MT7986
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220221/202202210822.gUmfl8An-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/nbd168/wireless/commit/1df906b554bcad9da1eb7e42952fa58133f577e8
        git remote add nbd168-wireless https://github.com/nbd168/wireless
        git fetch --no-tags nbd168-wireless mt76
        git checkout 1df906b554bcad9da1eb7e42952fa58133f577e8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__aeabi_ldivmod" [drivers/net/wireless/mediatek/mt76/mt7915/mt7915e.ko] undefined!
>> ERROR: modpost: "__aeabi_uldivmod" [drivers/net/wireless/mediatek/mt76/mt7915/mt7915e.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
