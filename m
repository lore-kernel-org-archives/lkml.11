Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8C6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 07:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiBVHD3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 02:03:29 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiBVHDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:03:25 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94E09A4C9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 23:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645513377; x=1677049377;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5jyXCSr1ZhMyQB5gDvaDshzPt8lHlK2+sZKFBeKu0y0=;
  b=WFDqmF8XPCKUgub7VRWx8VBbkp8abjDk2hCNmWxt3+bo+4CgmoriOwyM
   Wxm9BwEmxrJPuJlaUETtItbJLzGmH14JlRqUficbRph+9n5QqPH4XTtwo
   b7gbd8MNX/5jiglmdcVOLhj1CFaB36xQvNmMz0wVdIYf/J7abjaJUBB6F
   GbFd3F/rJLSUeldrHdac7QzTVpui8imJ0PM7XgsuCgPvaWzuDoLNgeTZ6
   JrkAzoM+UQSys+gOnj/Ah8Ioz/7jJyI2LWJu9xeX3SaCcOy64pAH6unAG
   G4+1wODP9yBtFHUir9eIDWNLiwccRTELuFC287oIh/0+HH7PqbfnqklTy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="239045422"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="239045422"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 23:02:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="638802182"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2022 23:02:56 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMPCJ-0002Sc-Bv; Tue, 22 Feb 2022 07:02:55 +0000
Date:   Tue, 22 Feb 2022 15:02:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephane Eranian <eranian@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:perf/amd 10/10] ERROR: modpost:
 "perf_amd_brs_lopwr_cb" [drivers/acpi/acpi_pad.ko] undefined!
Message-ID: <202202221450.1pf84xUs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/amd
head:   91d86bda42957558b912776088bb7d77232abb2e
commit: 91d86bda42957558b912776088bb7d77232abb2e [10/10] perf/x86/amd: Add idle hooks for branch sampling
config: i386-randconfig-c024-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221450.1pf84xUs-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=91d86bda42957558b912776088bb7d77232abb2e
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue perf/amd
        git checkout 91d86bda42957558b912776088bb7d77232abb2e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "perf_amd_brs_lopwr_cb" [drivers/acpi/acpi_pad.ko] undefined!
>> ERROR: modpost: "perf_lopwr_needed" [drivers/acpi/acpi_pad.ko] undefined!
>> ERROR: modpost: "perf_lopwr_needed" [drivers/acpi/processor.ko] undefined!
>> ERROR: modpost: "perf_amd_brs_lopwr_cb" [drivers/acpi/processor.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
