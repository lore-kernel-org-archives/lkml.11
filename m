Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3D6CCA481
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 22:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbiGLW3l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 18:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiGLW3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:29:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2756B851C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 15:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657664977; x=1689200977;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hIf7JOETL3U4PW1pZpGI4ivM/hW8aQW0YEe0B/6Lg6w=;
  b=cma37gSPgIbq/+x9Wp8TAG3Y9izmGWVlD1EMx+R7euc/xhvQxkIItwgw
   uujpUYGPLO9az1LyWY4vwOczSdEwrCfvbaxuafu2Tb0FvwGMDqizC4tXq
   7fCpSxVoyX54bFUXbxdR4uAZvU+0a+RyXttLZ+GshsQMdjxfWZITYJ/e9
   Ip8OAHl3ZJNjy1ZcTsX5lgPlbxALUmaJ3Ged4PfpUf2S49BC01lKNgLWl
   0J9nRc0t7N3AR65oz4hJYK8HlLw7Z9aCZpha/JFnhBlAjtqmoqNriqQy2
   mmhlASNYdHsc73SteNwbmEDqYUUSTG9fZTs/ZYMt+zsUkNuv1zJ2JnlRF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="268094713"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="268094713"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 15:29:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="737646505"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2022 15:29:35 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBONq-0002kR-Sm;
        Tue, 12 Jul 2022 22:29:34 +0000
Date:   Wed, 13 Jul 2022 06:29:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hector Martin <marcan@marcan.st>
Subject: [asahilinux:bits/070-audio 3/20] kismet: WARNING: unmet direct
 dependencies detected for APPLE_ADMAC when selected by SND_SOC_APPLE_MCA
Message-ID: <202207130614.AspjDmES-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/AsahiLinux/linux bits/070-audio
head:   55bc86786332628db127357b98246a6731108679
commit: 50833b1f649b754c7dc6af363080f758ffb76329 [3/20] ASoC: apple-mca: Add platform driver for Apple SoCs
config: (https://download.01.org/0day-ci/archive/20220713/202207130614.AspjDmES-lkp@intel.com/config)
reproduce:
        # https://github.com/AsahiLinux/linux/commit/50833b1f649b754c7dc6af363080f758ffb76329
        git remote add asahilinux https://github.com/AsahiLinux/linux
        git fetch --no-tags asahilinux bits/070-audio
        git checkout 50833b1f649b754c7dc6af363080f758ffb76329
        # 1. reproduce by kismet
           # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
           kismet --linux-ksrc=linux --selectees CONFIG_APPLE_ADMAC --selectors CONFIG_SND_SOC_APPLE_MCA -a=arm64
        # 2. reproduce by make
           # save the config file to linux source tree
           cd linux
           make ARCH=arm64 olddefconfig

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for APPLE_ADMAC when selected by SND_SOC_APPLE_MCA
   
   WARNING: unmet direct dependencies detected for APPLE_ADMAC
     Depends on [n]: DMADEVICES [=n] && (ARCH_APPLE [=y] || COMPILE_TEST [=n])
     Selected by [y]:
     - SND_SOC_APPLE_MCA [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (ARCH_APPLE [=y] || COMPILE_TEST [=n])

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
