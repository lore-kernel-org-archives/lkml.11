Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B7FBC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244421AbiCJUAO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 15:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242308AbiCJUAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:00:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFFE44DF62
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 11:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646942348; x=1678478348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lF0+CNF5nz8tK8GJlyBLSTkUD1qN/XW+oz3/veUSFrE=;
  b=Vr3j/ffZOVK34Dcw5qyWZjoWWe0fAACgQmbGj4ZwZeEJj+6u1WlL8kug
   69c3Nx8+JlozZaMLxmdvimFHb6a+XhtdgtMaJsAjnee8MFwpwWbZR4iYK
   8kveZqSRFQtbsDRcLJ+agRu8grheTQbZf8AirngrCVGQrSOaFWrws6oA2
   TLdZSF4DUQvl3/KtqefgmEHAz4RH24aQmom7XNetNK/StsdYvwF/PL57K
   w/k5KWZMTLTvXEV1U3yuOdZlZ4uKOJdsj3+LfvN8bVUmPSEzEU34VlkI1
   0LnodJKuIajWuFj8xM2bFP5sS1jw6UNUEb+3sCPwvGaVCTARdBzSWSHLH
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="242812065"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="242812065"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 11:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="578936968"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Mar 2022 11:59:01 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSOw8-0005Kg-G6; Thu, 10 Mar 2022 19:59:00 +0000
Date:   Fri, 11 Mar 2022 03:58:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-q-release
 2598/9999] kernel/trace/ftrace.c:6567:6: warning: no previous declaration
 for 'ftrace_graph_return_stub'
Message-ID: <202203110327.RrhhRaPm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-q-release
head:   556853b32b4656f1072ed285ee06b9519bb5ed8b
commit: 03002d0374dd37a1969c6c3aa5e16ffe9844af24 [2598/9999] ANDROID: ftrace: fix function type mismatches
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220311/202203110327.RrhhRaPm-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/03002d0374dd37a1969c6c3aa5e16ffe9844af24
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-q-release
        git checkout 03002d0374dd37a1969c6c3aa5e16ffe9844af24
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/trace/ftrace.c:2727:13: warning: no previous declaration for 'arch_ftrace_trampoline_free' [-Wmissing-declarations]
    void __weak arch_ftrace_trampoline_free(struct ftrace_ops *ops)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:3488:1: warning: no previous declaration for 'arch_ftrace_trampoline_func' [-Wmissing-declarations]
    arch_ftrace_trampoline_func(struct ftrace_ops *ops, struct dyn_ftrace *rec)
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:3726:15: warning: no previous declaration for 'arch_ftrace_match_adjust' [-Wmissing-declarations]
    char * __weak arch_ftrace_match_adjust(char *str, const char *search)
                  ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c: In function 'process_mod_list':
   kernel/trace/ftrace.c:4008:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     int ret;
         ^~~
   kernel/trace/ftrace.c: In function 'ftrace_regex_release':
   kernel/trace/ftrace.c:5040:6: warning: variable 'ret' set but not used [-Wunused-but-set-variable]
     int ret;
         ^~~
   kernel/trace/ftrace.c: At top level:
   kernel/trace/ftrace.c:5949:13: warning: no previous declaration for 'arch_ftrace_update_trampoline' [-Wmissing-declarations]
    void __weak arch_ftrace_update_trampoline(struct ftrace_ops *ops)
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/trace/ftrace.c:6567:6: warning: no previous declaration for 'ftrace_graph_return_stub' [-Wmissing-declarations]
    void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
         ^~~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:6571:5: warning: no previous declaration for 'ftrace_graph_entry_stub' [-Wmissing-declarations]
    int ftrace_graph_entry_stub(struct ftrace_graph_ent *trace)
        ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/trace/ftrace.c:1093:27: warning: 'ftrace_swapper_pid' defined but not used [-Wunused-const-variable=]
    static struct pid * const ftrace_swapper_pid = &init_struct_pid;
                              ^~~~~~~~~~~~~~~~~~


vim +/ftrace_graph_return_stub +6567 kernel/trace/ftrace.c

  6566	
> 6567	void ftrace_graph_return_stub(struct ftrace_graph_ret *trace)
  6568	{
  6569	}
  6570	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
