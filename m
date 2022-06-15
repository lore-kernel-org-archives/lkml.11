Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FDDC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 01:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbiFOB4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 21:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344884AbiFOB4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:56:12 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D654C43C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 18:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655258172; x=1686794172;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OdaunfrBMsujmaZ6H6qOl81nb/1ETmeU93c4cCunUgA=;
  b=aV4AcHM/s4TZGpZIOXMCy4JXXdLq871rYmvNdJCv3TEd0gMy0dlJwkxI
   Yx8ArXtk9rcj1UZ7dFYvHvB6lLe2aVvcEF0L9nSVb1JF98sRDp38oZ8FL
   hzOs9HfYDc2CEDOyWQCjJ9MmFyvYzXC1wQCXx08UzWbvtYQCxlStAqYxe
   Pf/xgFj2YtNAmPDLmZT5EIHeamSVSJbtuICB+mgnPyaoTIhXBqL8y/t5p
   3Pnpr0O9V4BZRb64+kMFYQz/zj3W2rM/zoFq0N6MOxzlJZdV+R5O3lK09
   D2g53RXF+HPX0lXD2t4J3eL0iDNrKK/wcws0gVfdVX+dzT3dHqtUkLLrH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="267488604"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="267488604"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 18:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="712726930"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Jun 2022 18:55:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1IGD-000MTr-BL;
        Wed, 15 Jun 2022 01:55:57 +0000
Date:   Wed, 15 Jun 2022 09:55:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.18 10/11] vmlinux.o: warning: objtool:
 vmx_vcpu_enter_exit()+0x183: call to wrmsrl.constprop.0() leaves
 .noinstr.text section
Message-ID: <202206150927.aBwTdEW8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.18
head:   8017603a918a3337089ebc456406d7309f866994
commit: 95678f288dd161892be7b211cbf45529d6dd538d [10/11] KVM: x86/speculation: Disable Fill buffer clear within guests
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220615/202206150927.aBwTdEW8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=95678f288dd161892be7b211cbf45529d6dd538d
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.18
        git checkout 95678f288dd161892be7b211cbf45529d6dd538d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: vmx_vcpu_enter_exit()+0x183: call to wrmsrl.constprop.0() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
