Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36A4C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 02:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiGRC0O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jul 2022 22:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiGRC0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 22:26:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AF210FED
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 19:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658111171; x=1689647171;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=E/f/xd2rmOqtAKvPXucthGOuo5Ii7MemqTTqoJuDICE=;
  b=GhtdSFUw3zGJMsu38IVInj2EqiC57z0bG3n30oCPWc2dWtbCyQRR7K6y
   KyuDm4tIkPuTVQU7Ty1wn9t+4kyrSHBMGzvyl9EZf6D0xWEVO9X0vML+K
   NgY2PjPiA1DKbpxHpGLuBzP0d0h5UGfHvvELwOLwL0YrlxgSKAVCIjMqt
   cFJ1+h2Vqe8RF4MQX2FtGNo1uc+gLuLfIdJFgaFzALcv2JpzmqBdxSl4W
   Q4zQbwtZ6m8+C1q6b6WHGuUYc4imAPsOEPlRyfcTNjo0PptATrgv5Bjyb
   UbZj7jbqeeVVTmTc+m8fPT8P7V2tNaZLe6EVx7BaDrZCMi1j62gST9SFo
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10411"; a="347803784"
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="347803784"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2022 19:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,280,1650956400"; 
   d="scan'208";a="597087705"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Jul 2022 19:26:10 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDGSX-0003us-F4;
        Mon, 18 Jul 2022 02:26:09 +0000
Date:   Mon, 18 Jul 2022 10:25:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [axboe-block:for-5.20/io_uring 54/171] io_uring/rw.c:912:2-7:
 WARNING: NULL check before some freeing functions is not needed.
Message-ID: <202207181028.PrDZ92aj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.20/io_uring
head:   004523ebfe6de8dd664ddf6fc26c47801b3bdaf5
commit: 9d6c15adf84bd6618f37ad7427537f97d7c68045 [54/171] io_uring: move read/write related opcodes to its own file
config: s390-randconfig-c043-20220717 (https://download.01.org/0day-ci/archive/20220718/202207181028.PrDZ92aj-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> io_uring/rw.c:912:2-7: WARNING: NULL check before some freeing functions is not needed.
   io_uring/rw.c:1017:2-7: WARNING: NULL check before some freeing functions is not needed.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
