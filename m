Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38023C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 02:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356940AbiEBCiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 May 2022 22:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiEBCiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:38:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B68F7666
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651458888; x=1682994888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AWnO/8rZ1EP+nCqqV2rp2OCAbOQ8SvhmjBb53HSqCbQ=;
  b=YJSuOBOaT/ZEU/49OkfUYlFqXVqW1I4aoxz05cUWIFqRym/1ozqjoHfx
   vA73ZSB9I4FX5H6nmEsxiThrrdLEXm+2dQBINuKWB5i0wMY31hgcRHBXp
   kNv7dEjKCmbasv4TmgyEs5Uy3n+fcx0OPOsgheGAIR+xWl2HEIXFuYEec
   kMf2xohKwxcjGIxWZU0Irbo7baKuue/0NjIRmPOxiNhajHgDIyeRlk7jo
   KJVJt/DBFn/RrXg6psGDtOL2a22+jYGx2qhoXgT1UEjrk1+PeQhP9+GR3
   zPyhmQ1Z6SQvJEhjic8f/8+1AQhohd8wn9SyTKQGiCTg37kwBg68ALGsh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10334"; a="247653377"
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="247653377"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 19:34:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,190,1647327600"; 
   d="scan'208";a="515873112"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 May 2022 19:34:46 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlLte-0009Dp-2i;
        Mon, 02 May 2022 02:34:46 +0000
Date:   Mon, 2 May 2022 10:34:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@suse.de>
Subject: [tip:master 18/29] fs/ntfs3/ntfs3.prelink.o: warning: objtool:
 ni_read_frame() falls through to next function ni_readpage_cmpr.cold()
Message-ID: <202205021021.6sless1W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
head:   aea1ae1ab93e60b266453b008238fbc5f0c65865
commit: ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3 [18/29] Merge objtool/core into tip/master
config: x86_64-randconfig-c001-20220502 (https://download.01.org/0day-ci/archive/20220502/202205021021.6sless1W-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip master
        git checkout ad0952ac67d1bd2c1e0c25ce150b981f02cc23a3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/ntfs3/ntfs3.prelink.o: warning: objtool: ni_read_frame() falls through to next function ni_readpage_cmpr.cold()

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
