Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 128B2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 22:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbiCZW2V (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 18:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiCZW2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 18:28:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C927E5A6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 15:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648333600; x=1679869600;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8198OJbTIn96uQxJ6LTp6Y/NyKKBmUGOW4+KIz7uyXM=;
  b=C0yrihJo+BA4mH4CFTZxUoZN2MxjCLdhbri8QQS78Kms/ndqiwTPTDiZ
   HAASEHpuPOmN9/5DUdxSw4drPwwfRPBQ62cEBgNotTrh/FR+ybI+J6kvF
   ncrw0l1nCwwL6gWtrzIeeWmsp21+EzYBQtb6QLEHfuogiCvv1ArPXM8o3
   HqHuAx8aH84j74oGewina1KoIT5Abu9BBoqOW3YDd1VH0/I23kXXaBODg
   TlyZv75iHizG/TBw8bIVe37XeL3rHYhK/e2TIpCWcRG8lTXY1eaDGb9nD
   K1ECsMZyXTwnhrm/70OXlhpRdhWTmXKjGqHFUlqlmPqS+lsLtBzjTzFIW
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="345244224"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="345244224"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 15:26:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="584804407"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 26 Mar 2022 15:26:39 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYErm-0000St-KG; Sat, 26 Mar 2022 22:26:38 +0000
Date:   Sun, 27 Mar 2022 06:26:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: lib/zstd/common/debug.h: zstd_deps.h is included more than once.
Message-ID: <202203270632.BdIMZ4Zs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   710f5d627a98e86f821aceb840b8f2f1fcc6cf75
commit: e0c1b49f5b674cca7b10549c53b3791d0bbc90a8 lib: zstd: Upgrade to latest upstream zstd version 1.4.10
date:   5 months ago
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> lib/zstd/common/debug.h: zstd_deps.h is included more than once.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
