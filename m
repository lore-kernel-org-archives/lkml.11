Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5FDC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 07:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiBPHqy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 02:46:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiBPHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:46:51 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C863D7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644997599; x=1676533599;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZbHq30c9suHqVxOsxPX/mZ0QzsgvzvZU/DMFUUxsqKY=;
  b=Uzc4CMZ0YjJLpo1X9fnfMalbLubBbPs35pHrfpMzwElU7AYrqn5EeGmj
   w/MuyhgMZ05xRIkdkMpv5u5BNS1H6ZXS661VV5O0YjKnU4lCuBZB3O8l3
   rJnmpFZdwKCl0d+RvOzhXotY8pXkJI/q22VCSUs0dkYDKrgg6k3kgzKsX
   tqum/mXwr5jbEX4AsopuiiYwWi/s8MlnUZyxsIq8cfLTEjNuGSgK3cwr3
   PKEK++W24340iUocoHMyBUGJJ61FXg5rxiZVQbj3vsah7htHmgQzFZqmQ
   4PylqSea99dWFBW7z9ZmXtfsQVhsLKI4ELbNt2muAVo5qDdYiTcncsQgk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="275118727"
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="275118727"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 23:03:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,373,1635231600"; 
   d="scan'208";a="704179198"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 15 Feb 2022 23:03:28 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKELY-000AY1-6B; Wed, 16 Feb 2022 07:03:28 +0000
Date:   Wed, 16 Feb 2022 15:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: ERROR: start_text address is c000000000000600, should be
 c000000000000100
Message-ID: <202202161525.m2QCBrwR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c5d9ae265b105d9a67575fb67bd4650a6fc08e25
commit: 47c258d71ebfc832a760a1dc6540cf3c33968023 powerpc/head_check: use stdout for error messages
date:   6 months ago
config: powerpc64-randconfig-c004-20220216 (https://download.01.org/0day-ci/archive/20220216/202202161525.m2QCBrwR-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=47c258d71ebfc832a760a1dc6540cf3c33968023
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 47c258d71ebfc832a760a1dc6540cf3c33968023
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ERROR: start_text address is c000000000000600, should be c000000000000100
   ERROR: try to enable LD_HEAD_STUB_CATCH config option
   ERROR: see comments in arch/powerpc/tools/head_check.sh

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
