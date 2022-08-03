Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859BDC00140
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 00:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234593AbiHCAYp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 20:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHCAYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:24:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD86371A5
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659486282; x=1691022282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3DsjlwD58ZxUfhl3gDUiPA9dH45sXj3Z7zgEqfAuR1g=;
  b=RMDCI8tbqN0I9UoWPej+DR1jr6+Mc1sazUfEowSmSVksX7eYoOtoLg9D
   K0Z2NGJ5Cu9TZSRG68BmjA7f0xyLzSsMabMAIEmIIn+XAJmRvJiAe+kh2
   YxKOT9sOOf8cVgeYU2wcuXlHPW0x7SZCDcA45nsyPMv9HF7dR7JrBJZOa
   hZtQfmuwsW2929Y7TUv5QEVQs4GOWGyLSWIZgmZU+O/6mlza+5NHcgKrs
   uSwCdK5dPmdKhvjir0v98Z0/eju6VK+lxkFqGWHJH4xEd5Ty8mfEyC61N
   8Yl6ubDBbwQeQNawn4YhcmfJ79pVObpnK2BKOnrm/JRbQOVoS0UEY6Rgb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287109700"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="287109700"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="848394029"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Aug 2022 17:24:40 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ2Bj-000GbQ-1N;
        Wed, 03 Aug 2022 00:24:39 +0000
Date:   Wed, 3 Aug 2022 08:24:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:crng/random/jd/vdso 9/9] vgetrandom.c:undefined
 reference to `__memset'
Message-ID: <202208030854.seELtKRV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block crng/random/jd/vdso
head:   29d7baa1e13b4304df93126e0c8baf56584b720a
commit: 29d7baa1e13b4304df93126e0c8baf56584b720a [9/9] random: implement getrandom() in vDSO
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220803/202208030854.seELtKRV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/29d7baa1e13b4304df93126e0c8baf56584b720a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block crng/random/jd/vdso
        git checkout 29d7baa1e13b4304df93126e0c8baf56584b720a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   ld: arch/x86/entry/vdso/vgetrandom.o: in function `__vdso_getrandom':
>> vgetrandom.c:(.text+0x50b): undefined reference to `__memset'
   objdump: 'arch/x86/entry/vdso/vdso64.so.dbg': No such file
--
>> ld: arch/x86/entry/vdso/vgetrandom-x32.o: warning: relocation against `__memset' in read-only section `.text'
   ld: arch/x86/entry/vdso/vgetrandom-x32.o: relocation R_X86_64_PC32 against undefined symbol `__memset' can not be used when making a shared object; recompile with -fPIC
   ld: final link failed: bad value
   objdump: 'arch/x86/entry/vdso/vdsox32.so.dbg': No such file

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
