Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AA2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 01:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbiCJBTd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 20:19:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbiCJBT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:19:29 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBA042A1B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646875109; x=1678411109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8adlvJoy+2Wk+csq4zAqS4rbi5PlP3Ci4blYKU8wuyQ=;
  b=f+6/wLaIVgeAJRqxBpBScEHF+3rVkswFaEF7V+kyiz0mwN0iBdSsjh4n
   86RHudO8/bbpiJL9umFoMpQhQcge/WQq6RVOFcFitsV7zDxdfZXW1uNJu
   0UqCyg/ZznxJ/RGEOCdgIEpdVKO4htYxOQSKZ0KqXQDl+cXc4AhceA4+/
   +4KCi5D/RQx10wZakQpcSg1/w79SBKiTmi+B8tRUe58a9Up1ZMt2bVJv3
   j0ZQXh1RLWZnCameGO/3B3+yQf2aMzdKZ9Zv7d1aX1tCqq0MuQ+m7jkkM
   yD9WNtaw4SgcmNK4SE15OJve5XD8nZNPyBiD1oKCz6FtwFtCfLQFlm5/j
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318355191"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="318355191"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:18:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="688491591"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Mar 2022 17:18:27 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS7Ri-00047d-E5; Thu, 10 Mar 2022 01:18:26 +0000
Date:   Thu, 10 Mar 2022 09:17:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
Message-ID: <202203100900.4UKi7486-lkp@intel.com>
References: <20220309144644.4278-1-osalvador@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309144644.4278-1-osalvador@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Oscar-Salvador/mm-Only-re-generate-demotion-targets-when-a-numa-node-changes-its-N_CPU-state/20220309-224707
base:   https://github.com/hnaz/linux-mm master
config: riscv-randconfig-s032-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100900.4UKi7486-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/8af0c9ff9475c64e31963a5810b127875081c5ff
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Oscar-Salvador/mm-Only-re-generate-demotion-targets-when-a-numa-node-changes-its-N_CPU-state/20220309-224707
        git checkout 8af0c9ff9475c64e31963a5810b127875081c5ff
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/vmstat.c: In function 'vmstat_cpu_online':
>> mm/vmstat.c:2056:17: error: implicit declaration of function 'set_migration_target_nodes' [-Werror=implicit-function-declaration]
    2056 |                 set_migration_target_nodes();
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/set_migration_target_nodes +2056 mm/vmstat.c

  2049	
  2050	static int vmstat_cpu_online(unsigned int cpu)
  2051	{
  2052		refresh_zone_stat_thresholds();
  2053	
  2054		if (!node_state(cpu_to_node(cpu), N_CPU)) {
  2055			node_set_state(cpu_to_node(cpu), N_CPU);
> 2056			set_migration_target_nodes();
  2057		}
  2058	
  2059		return 0;
  2060	}
  2061	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
