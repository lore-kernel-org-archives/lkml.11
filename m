Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7204EC25B08
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 03:05:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236923AbiHUDFh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Aug 2022 23:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiHUDFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 23:05:32 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4802A263;
        Sat, 20 Aug 2022 20:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661051130; x=1692587130;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=WrVs/E+xHMeEhe59JN/PkFv7sBd6vnlBOld2g+aWPBs=;
  b=EXbi6ABd0rg/2rFg+yqIrxahc3N36gPGfcDWX2K1OIuxgwjyoG5bl9hn
   f0q1OUGJcSv8iCDMHvYf7Lrbhvc9Xjg2Lwr8JpupEf5/wGVRr2b2T2mTf
   bqGYRE+d7Dcq7Z+oMr2+pMOE13z4Kq2uL2vdo+SYRjJWoWUTy+uloOohJ
   N+oKvOluz8gQfOGot5NuNtVHzjxtcQ3eAsGjMnpt11gie1wb6gkMBFLbf
   /A+8DyLVPkY0o3DA4GhJbSNUqa7L7sgeX71kGN9hW94eDXE/H1383FxC7
   1qttJo5MfSD/EsI6AU7QPAllvNg3CZAEbhKjoa58PtQYW6FhRlB9tABuU
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="272976585"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="272976585"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 20:05:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="750906933"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2022 20:05:29 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPbHE-0003ZD-28;
        Sun, 21 Aug 2022 03:05:28 +0000
Date:   Sun, 21 Aug 2022 11:05:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [lunn:v6.0-rc1-kirkwood-dt 50/57] htmldocs: Warning:
 Documentation/hwmon/g762.rst references a file that doesn't exist:
 Documentation/devicetree/bindings/hwmon/g762.txt
Message-ID: <202208211031.HJs4zq0a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/lunn/linux.git v6.0-rc1-kirkwood-dt
head:   ccd2fc5bd7bb1e532d745c8a145bac7e4aaa1614
commit: 7e6133f17b207b5fa0eacdfba745b7a3f8b0c7ab [50/57] DT: hwmon: Convert g762.txt to YAML
reproduce:
        # https://github.com/lunn/linux/commit/7e6133f17b207b5fa0eacdfba745b7a3f8b0c7ab
        git remote add lunn https://github.com/lunn/linux.git
        git fetch --no-tags lunn v6.0-rc1-kirkwood-dt
        git checkout 7e6133f17b207b5fa0eacdfba745b7a3f8b0c7ab
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/hwmon/g762.rst references a file that doesn't exist: Documentation/devicetree/bindings/hwmon/g762.txt

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
