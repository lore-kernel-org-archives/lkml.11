Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19837C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 05:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiC2FWo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 01:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231225AbiC2FWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 01:22:41 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E2A199E36
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 22:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648531259; x=1680067259;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/tpErwfZgPi2yVBYzocg2PxkFms2E/b8plbXSTdtm1Q=;
  b=jWSibfkDojN3Vt1hHYkfWL04QaX9iuu2Uk1EM7sXbdUvoetfaLTsxyQx
   vywYqgyTvUb3UkL/ONATCfC11stbI2I0gLaess6GS48YINNabGyZnjIoI
   W0LNI01bRzASy0q9bJfc9LM0ACKUnaFCuRtba0YLaZm4g8Esrm1IRnyD0
   5bhk9FNywlMftdTQEUW7c86aFw4VxhfwQQBCSDf5vBbaw63TfcR0t8eua
   7R3Srxz+XBZsjExjpasudr6mKZa59zdBnDU2dcq+spiFQiN/Tt+19OvDK
   aNFKrv1F2gmLov07TR6CJb2Qi3omhML2kQD3UHZ6zx0h8GAzQo3bRwZti
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319863919"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="319863919"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 22:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="518689973"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 28 Mar 2022 22:20:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ4Hn-0002gp-KT; Tue, 29 Mar 2022 05:20:55 +0000
Date:   Tue, 29 Mar 2022 13:20:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: drivers/phy/ti/phy-tusb1210.c:158:12: sparse: sparse: symbol
 'tusb1210_chg_det_states' was not declared. Should it be static?
Message-ID: <202203291321.E3lqXEcg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1930a6e739c4b4a654a69164dbe39e554d228915
commit: 48969a5623ed918713552e2b4f9d391c89b5e838 phy: ti: tusb1210: Add charger detection
date:   5 weeks ago
config: i386-randconfig-s001-20220328 (https://download.01.org/0day-ci/archive/20220329/202203291321.E3lqXEcg-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=48969a5623ed918713552e2b4f9d391c89b5e838
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 48969a5623ed918713552e2b4f9d391c89b5e838
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/phy/ti/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/phy/ti/phy-tusb1210.c:158:12: sparse: sparse: symbol 'tusb1210_chg_det_states' was not declared. Should it be static?

vim +/tusb1210_chg_det_states +158 drivers/phy/ti/phy-tusb1210.c

   156	
   157	#ifdef CONFIG_POWER_SUPPLY
 > 158	const char * const tusb1210_chg_det_states[] = {
   159		"CHG_DET_CONNECTING",
   160		"CHG_DET_START_DET",
   161		"CHG_DET_READ_DET",
   162		"CHG_DET_FINISH_DET",
   163		"CHG_DET_CONNECTED",
   164		"CHG_DET_DISCONNECTING",
   165		"CHG_DET_DISCONNECTING_DONE",
   166		"CHG_DET_DISCONNECTED",
   167	};
   168	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
