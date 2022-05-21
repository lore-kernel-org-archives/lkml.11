Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F070C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 23:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347365AbiEUXh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 19:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiEUXh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 19:37:57 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE04E3BC
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653176276; x=1684712276;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uNdwsBXZQ3pVlCDw0YosBGzFAfKUwHZXTi+VNrgzFyk=;
  b=ZppHrnQLdI1WJvMoSRZHjYs5E5n+eHKF5mMKalQPwV3Az0X6MWAZg/fP
   N7EaCZOKcWm/1tc9NxdQeyLVdOoFrbJhr816sZsvv+nJxm7ZId8uohNol
   +jb3wpf980lSIIBmQRKPOkTpTiecwzqoZs2s+O73QaAFVk1MXk29jutKV
   abG06YtDzWwoBUI1u6Ji2DOyFx1XLIqxySkaFA75Dm+hieL2xS78H7ZB9
   6Xc7sCE8d+TBJOMan/B3vlQr6TH0E07uqq95tnMJ3pdxvuKZ9MA+PrK5O
   4/TpYZx3ZmqxSiDLRcYkfWWt/9UlBCG/3z/ICuANJQ3EsruGWvlK2ns2R
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="273047395"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="273047395"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 16:37:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="558041800"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2022 16:37:55 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsYfS-0006iO-LM;
        Sat, 21 May 2022 23:37:54 +0000
Date:   Sun, 22 May 2022 07:36:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 2/3] filter.c:undefined reference to
 `bpf_skb_map_pop_proto'
Message-ID: <202205220744.AyoIDr9q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   9f6c12a2c218c56af7d37feeaf21c5b62a8192a0
commit: 87b07af86004ccc8db9ee11e670f947e4178cd89 [2/3] net_sched: introduce eBPF based Qdisc
config: csky-defconfig (https://download.01.org/0day-ci/archive/20220522/202205220744.AyoIDr9q-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/87b07af86004ccc8db9ee11e670f947e4178cd89
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout 87b07af86004ccc8db9ee11e670f947e4178cd89
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   csky-linux-ld: net/core/filter.o: in function `lwt_xmit_func_proto':
>> filter.c:(.text+0x896c): undefined reference to `bpf_skb_map_pop_proto'
>> csky-linux-ld: filter.c:(.text+0x8970): undefined reference to `bpf_skb_map_push_proto'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
