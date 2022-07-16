Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB47BC43334
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jul 2022 04:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbiGPEEH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jul 2022 00:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiGPEEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 00:04:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A472E6344;
        Fri, 15 Jul 2022 21:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657944239; x=1689480239;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=99kKm8rbtPIIR3wdQnreT6tQtUo9WlttywuIkD+dz+A=;
  b=gKKsz+tobD2jX9N2XYKAeH8ty08sJHeCwsPLeAbvKKbsa6ytJ9qxTJvC
   1+NG2Z1dsxvxr4wFx7NV7cdW5/MX1LEmuTMHWagnsHVlpg9mhdNFVzqRy
   uRcr+REIg5NjRxpRWc4Eq+LpiywdNsRHUCJZ1BgL0ndxGHC9vorbgakRF
   hHxsqVBd9qNEg6X/zDs3g0PUeQmbXOGObUWDzAxIxEh7tEJ28pmhJpon5
   etxx6GT/C3hFnCg8zEN3JSEASkTalAwW+oMrs0hQ4BL3zdzGMtbHLURLa
   HKvO7sbdWfp7gY5mV/IO8qUgHbOYYm9fCYM7IjbpAxQr9az5HhBMKJZ7b
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="372258437"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="372258437"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 21:03:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="546889434"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2022 21:03:57 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCZ24-00017d-PD;
        Sat, 16 Jul 2022 04:03:56 +0000
Date:   Sat, 16 Jul 2022 12:03:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [djwong-xfs:vectorized-scrub 23/378] htmldocs:
 Documentation/filesystems/xfs-online-fsck-design.rst:2347: WARNING:
 undefined label: _quotacheck (if the link has no caption the label must
 precede a section header)
Message-ID: <202207161123.gYWDmFFS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   ca1f215ce72afdad027367230130cc8d9b49290a
commit: 8ad3556744361cdde71410906513277e8224895b [23/378] xfs: document technical aspects of kernel space file repair code
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/filesystems/xfs-online-fsck-design.rst:2347: WARNING: undefined label: _quotacheck (if the link has no caption the label must precede a section header)

vim +2347 Documentation/filesystems/xfs-online-fsck-design.rst

  2346	
> 2347	Quota usage counters are checked and repaired separately by
  2348	:ref:`live quotacheck <_quotacheck>`.
  2349	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
