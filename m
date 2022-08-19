Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB06BC00140
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 01:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242927AbiHSBq3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiHSBqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:46:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E3D5D6303
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660873583; x=1692409583;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HOu9W0Z7Hb0AbvSxeFl3Bfr4eXNOKWNuHXBWb8n0dg4=;
  b=bocTYFxcnAqEUIv1zVDMGcMDVmUuKRDUD5JIosTqCkrm/gemSLbVdjgr
   YYxSdm/DV9lLwXEseKuNZu54HEVVo6EboaCbHcVrwaUe4PbblBIU+PYDW
   jsK2oGZW02Lur+ykgeYN75/EIoq85m3S0oGjoE0QhNrVqa5aNql6ZpvSv
   b1zW+0lQITcGV1cOKUgBP71x7NJCyYKcnljVZ3mUJxSwQkhlm8+6UA7G4
   /8oXc1eStpkkeDtinI2qgLUd2A0wzPsbYs6IV8scN2auy6F9rRcGtkNhA
   CaVWqKLQdSm6TM7o+HVyWpXXmGciLePmEiA08FuUNeY9hzt0JtorpC8x5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="273303581"
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="273303581"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 18:46:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="936038762"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2022 18:46:22 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOr5Z-0000sp-1P;
        Fri, 19 Aug 2022 01:46:21 +0000
Date:   Fri, 19 Aug 2022 09:45:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [alobakin:kallsyms 3/3] Failed to open
 ../lib/gcc/or1k-linux/12.1.0/libgcc.syms: No such file or directory at
 scripts/gen_sympaths.pl line 182.
Message-ID: <202208190907.vrsbCoX3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/alobakin/linux kallsyms
head:   0707de5041e9ba702fb490bf92d8742b797c9c3e
commit: 0707de5041e9ba702fb490bf92d8742b797c9c3e [3/3] kallsyms: add option to include relative filepaths into kallsyms
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20220819/202208190907.vrsbCoX3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/alobakin/linux/commit/0707de5041e9ba702fb490bf92d8742b797c9c3e
        git remote add alobakin https://github.com/alobakin/linux
        git fetch --no-tags alobakin kallsyms
        git checkout 0707de5041e9ba702fb490bf92d8742b797c9c3e
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 ARCH=openrisc 

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Failed to open ../lib/gcc/or1k-linux/12.1.0/libgcc.syms: No such file or directory at scripts/gen_sympaths.pl line 182.
   No valid symbol.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
