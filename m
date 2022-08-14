Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832B9C25B06
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Aug 2022 17:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiHNRYL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNRYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 13:24:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEDD1B7AD
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 10:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660497847; x=1692033847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jfM7MQxObCaOX411Cy6kE4Z2T3scOHF1Pz+yX75DBMs=;
  b=IU3ODS73z5QTg9FpSy6n28jcvIgLBxw7sv6YJUcQGZuJ8QdXB90kSBAT
   kupNpLs8gCUEK26BTx9ub2Z2gzBspQVoEbRxoPBOfR3OFl8uUBdKhDIdr
   ez4ZjzIMKK+3G7DTVf876XOAz6WU1J8gAECimMJYeXgsfE2EYmYrXMpxs
   agSjQdefYxEvXpuF8O4Sp6LJ1TyUXZC/1BjbWX1wcKqsNMLZvCTnppfX4
   0KhKgf3J+0PFo4mDlfMihxC/7Q9sTrYV241h4k3StU7qhuoYoHCy0YDzc
   B1RNj/uepfSi7cLGs3khTdDlUoi8aJJmxOsiO1olN83J5VtsAMHDzqZTL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="289410447"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="289410447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 10:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="635222254"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2022 10:24:06 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNHLJ-0000MJ-22;
        Sun, 14 Aug 2022 17:24:05 +0000
Date:   Mon, 15 Aug 2022 01:23:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [sailus-media-tree:master 236/250]
 drivers/media/i2c/ar0521.c:409:5-8: Unneeded variable: "ret". Return "0" on
 line 426
Message-ID: <202208150111.rfHpFLvV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/sailus/media_tree.git master
head:   4678eb59b03291e9524912cc541fd82e8603cc6c
commit: dd422e09276972cf996ae85d31640664f85b5bc0 [236/250] ar0521: fix Kconfig: VIDEO_V4L2 -> VIDEO_DEV
config: openrisc-randconfig-c004-20220717 (https://download.01.org/0day-ci/archive/20220815/202208150111.rfHpFLvV-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> drivers/media/i2c/ar0521.c:409:5-8: Unneeded variable: "ret". Return "0" on line 426

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
