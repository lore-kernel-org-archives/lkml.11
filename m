Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC40C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Mar 2022 13:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiCMNfK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Mar 2022 09:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiCMNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 09:35:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E220E3ED04
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647178439; x=1678714439;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SYcSsAnbbn5vFrUQU3TqDSTKmSjU/JHD9neTeP1gINs=;
  b=amghT5OUcbTxTcSgoC7TgOCJREpbfd00DLdj1/LEbsMu0OYqXl0ZwCMX
   Yinui4onpmhiYJUwP95HY5yzKWndqY4cNRzD87AGHt4yykrWfq6hy1aCd
   h1pBy5Mq/foSnqyU4njTlYBGXi7SzqZ0V3s5YI+/qZTNkvcw1t+H7dQOG
   sfuOIjMrMnz63WbT0oMmvTcH1Xnjz7Wvhcp72ugrDTr0EYqRyMJiVtWz4
   mAAf1WAwuhQRelCuTPq7+vPpirxrROGGk2trmeDwZfOZMWSFu8cbcQFue
   eOfrLIFrsKtLnYtjtsr1ITMBuNHr5L/WFK2QzvyfKw9zjOwLssRYzd4uS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="280624013"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="280624013"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 06:33:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713408623"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 06:33:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTOM9-0008zP-HS; Sun, 13 Mar 2022 13:33:57 +0000
Date:   Sun, 13 Mar 2022 21:33:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 140/156] tcp.c:undefined reference to
 `nvme_keyring_lookup_generated_key'
Message-ID: <202203132117.2HedNSTG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 2025db31c639eb71ba4cd675cb846a14a48cd932 [140/156] nvme-tcp: derive retained keys for TLS
config: riscv-randconfig-m031-20220313 (https://download.01.org/0day-ci/archive/20220313/202203132117.2HedNSTG-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=2025db31c639eb71ba4cd675cb846a14a48cd932
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 2025db31c639eb71ba4cd675cb846a14a48cd932
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
   core.c:(.exit.text+0x8): undefined reference to `nvme_keyring_exit'
   riscv64-linux-ld: drivers/nvme/host/core.o: in function `.L0 ':
   core.c:(.init.text+0x17c): undefined reference to `nvme_keyring_init'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `.L646':
>> tcp.c:(.text+0x3188): undefined reference to `nvme_keyring_lookup_generated_key'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `.L649':
   tcp.c:(.text+0x31c2): undefined reference to `nvme_keyring_lookup_tls'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_timeout':
   tcp.c:(.text+0x3200): undefined reference to `nvme_keyring_lookup_generated_key'
>> riscv64-linux-ld: tcp.c:(.text+0x3238): undefined reference to `nvme_keyring_lookup_tls'
   riscv64-linux-ld: tcp.c:(.text+0x3290): undefined reference to `nvme_keyring_insert_tls'
   riscv64-linux-ld: tcp.c:(.text+0x32d2): undefined reference to `nvme_keyring_insert_tls'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `.L665':
>> tcp.c:(.text+0x3310): undefined reference to `nvme_keyring_lookup_retained_key'
   riscv64-linux-ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_handle_r2t':
>> tcp.c:(.text+0x3344): undefined reference to `nvme_keyring_insert_tls'
   riscv64-linux-ld: tcp.c:(.text+0x3382): undefined reference to `nvme_keyring_lookup_retained_key'
   riscv64-linux-ld: tcp.c:(.text+0x33b6): undefined reference to `nvme_keyring_insert_tls'

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
