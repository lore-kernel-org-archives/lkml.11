Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60962C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 04:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiBXEEh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 23:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiBXEEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 23:04:35 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D56A1693AD
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 20:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645675446; x=1677211446;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J164G450mhfELhtInr78nU0U77B8yN4TO+jrb00pUkk=;
  b=Io469msc9Bn6uap9IgvwjbspF5ASWwS4XRcH/6XQT9oawl/sCVNtRs7/
   R2qh2aSWeHTDO7LMSAI4h38rVvrBeXqx4hOe2FvYXEAP0TSgC/ppqivx6
   hT5kadWp8SHd+UpbQF4R1kxpN219hdAMR9DHRpEd54fmjt4GfKshbbZ2X
   sjK8dcfh7PazVVxKd6oQCOg2VTaGBwqvmgRZ1GJOvbI8MmeSG9EvX1mdz
   uZZI6vx5bxMr2tjcl1HIiRiRXjOM2usC2h5aRKY+2T41Vp6416Y02kerl
   Q+vKNcxGGwJLAcRtQZ7qa2I9IMGJ0LUe8kxTOVGsAxvuctj/RaarMJfTt
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232119563"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="232119563"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 20:04:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="784678028"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2022 20:04:02 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN5MH-0002FO-O9; Thu, 24 Feb 2022 04:04:01 +0000
Date:   Thu, 24 Feb 2022 12:03:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 22/42] kernel/bpf/trampoline.c:154:33:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <202202241239.Qn6Kniwo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   27b6438f414b6a37b60dcd90c8980397586d49db
commit: 28a2850ec958722056cb6679cf68567905223971 [22/42] x86/bpf: Add ENDBR instructions to prologue and trampoline
config: sparc-randconfig-s031-20220224 (https://download.01.org/0day-ci/archive/20220224/202202241239.Qn6Kniwo-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=28a2850ec958722056cb6679cf68567905223971
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 28a2850ec958722056cb6679cf68567905223971
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/bpf/trampoline.c:154:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long ip @@     got void *ip @@
   kernel/bpf/trampoline.c:154:33: sparse:     expected unsigned long ip
   kernel/bpf/trampoline.c:154:33: sparse:     got void *ip

vim +154 kernel/bpf/trampoline.c

   146	
   147	/* first time registering */
   148	static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
   149	{
   150		void *ip = tr->func.addr;
   151		unsigned long faddr;
   152		int ret;
   153	
 > 154		faddr = ftrace_location(ip);
   155		if (faddr)
   156			tr->func.ftrace_managed = true;
   157	
   158		if (bpf_trampoline_module_get(tr))
   159			return -ENOENT;
   160	
   161		if (tr->func.ftrace_managed)
   162			ret = register_ftrace_direct((long)ip, (long)new_addr);
   163		else
   164			ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
   165	
   166		if (ret)
   167			bpf_trampoline_module_put(tr);
   168		return ret;
   169	}
   170	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
