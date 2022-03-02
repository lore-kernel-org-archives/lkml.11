Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0423C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 03:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbiCBDNh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 22:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiCBDNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 22:13:33 -0500
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98046220FA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 19:12:50 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0V60k4pS_1646190767;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0V60k4pS_1646190767)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 02 Mar 2022 11:12:48 +0800
Date:   Wed, 2 Mar 2022 11:12:47 +0800
From:   "dust.li" <dust.li@linux.alibaba.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Lu <tonylu@linux.alibaba.com>
Subject: Re: [saeed:net-next-mlx5 100/108] WARNING: modpost:
 vmlinux.o(.text+0x1fc2f20): Section mismatch in reference from the function
 trace_event_raw_event_smc_msg_event() to the variable
 .init.data:initcall_level_names
Message-ID: <20220302031247.GC9417@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <202203020919.C37R7nSW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203020919.C37R7nSW-lkp@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:51:58AM +0800, kernel test robot wrote:
>tree:   https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git net-next-mlx5
>head:   f6aab83b7decaf651cffe7fdac7d0bb316ea6bca
>commit: 462791bbfa350189e309a5a94541f6b63cd874e8 [100/108] net/smc: add sysctl interface for SMC
>config: xtensa-randconfig-r034-20220301 (https://download.01.org/0day-ci/archive/20220302/202203020919.C37R7nSW-lkp@intel.com/config)
>compiler: xtensa-linux-gcc (GCC) 11.2.0
>reproduce (this is a W=1 build):
>        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>        chmod +x ~/bin/make.cross
>        # https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git/commit/?id=462791bbfa350189e309a5a94541f6b63cd874e8
>        git remote add saeed https://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git
>        git fetch --no-tags saeed net-next-mlx5
>        git checkout 462791bbfa350189e309a5a94541f6b63cd874e8
>        # save the config file to linux build tree
>        mkdir build_dir
>        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=xtensa SHELL=/bin/bash
>
>If you fix the issue, kindly add following tag as appropriate
>Reported-by: kernel test robot <lkp@intel.com>
>
>All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
>>> WARNING: modpost: vmlinux.o(.text+0x1fc2f20): Section mismatch in reference from the function trace_event_raw_event_smc_msg_event() to the variable .init.data:initcall_level_names
>The function trace_event_raw_event_smc_msg_event() references
>the variable __initdata initcall_level_names.
>This is often because trace_event_raw_event_smc_msg_event lacks a __initdata
>annotation or the annotation of initcall_level_names is wrong.

Really sorry for the break !

I think its because we missed the '__net_exit' annotation for
smc_sysctl_exit(). I will send a patch to fix this soon

>
>---
>0-DAY CI Kernel Test Service, Intel Corporation
>https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
