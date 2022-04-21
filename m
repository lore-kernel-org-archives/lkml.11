Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A20C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Apr 2022 08:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386537AbiDUINV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Apr 2022 04:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386511AbiDUIMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:12:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9441D2BE6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650528600; x=1682064600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9Dvw55VSR2AYsXJHuar7PwFU+kUOe8VxzohYRnEFbv0=;
  b=lqvlWeDlZBek7fwQpvcFpoqQCK0a5JFz831u1PvXDi3x5ioXMbWM9ThQ
   j7f9WcahNCk2c1H2DFdDrZvWiWpM6gVMZKRogGjNjk3u4m1djS2BNKfQm
   UPqfR9vlbOKQHCQAWBD5lYLbDPh2IE65Cxu9Q8dSL2TH2Pqava5szgBp3
   G6IXVoDBYYSnxhZxHoohSHY7iJyjNifeL0tD3BXBMf7oubiwG0Xbhgcwq
   ZhA/ZaBxAaMbhq0DLVBf67yx7EfSDRC+yCJq4+MyoTjI5x3ZYO5scNVtk
   k3XbL+TXsoPupYBeJmvYjSsfysWrHjtfzfi1+RsxOBISYa/CO+fqTi61n
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263128112"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263128112"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 01:10:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="562475118"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2022 01:09:59 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhRt0-00086m-8P;
        Thu, 21 Apr 2022 08:09:58 +0000
Date:   Thu, 21 Apr 2022 16:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: kernel/sysctl.c:183:13: error: no previous prototype for
 'unpriv_ebpf_notify'
Message-ID: <202204211555.LOlUnkOB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b253435746d9a4a701b5f09211b9c14d3370d0da
commit: 44a3918c8245ab10c6c9719dd12e7a8d291980d8 x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting
date:   8 weeks ago
config: x86_64-sof-customedconfig-bpf-defconfig (https://download.01.org/0day-ci/archive/20220421/202204211555.LOlUnkOB-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44a3918c8245ab10c6c9719dd12e7a8d291980d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 44a3918c8245ab10c6c9719dd12e7a8d291980d8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/sysctl.c:183:13: error: no previous prototype for 'unpriv_ebpf_notify' [-Werror=missing-prototypes]
     183 | void __weak unpriv_ebpf_notify(int new_state)
         |             ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors
--
>> arch/x86/kernel/cpu/bugs.c:657:6: error: no previous prototype for 'unpriv_ebpf_notify' [-Werror=missing-prototypes]
     657 | void unpriv_ebpf_notify(int new_state)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/unpriv_ebpf_notify +183 kernel/sysctl.c

   182	
 > 183	void __weak unpriv_ebpf_notify(int new_state)
   184	{
   185	}
   186	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
