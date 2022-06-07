Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FD0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 01:18:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiFGBSm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 21:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbiFGBSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 21:18:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFD7DF7C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654564717; x=1686100717;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A0PTO2hbmFVY5OyczY0qP0J03m2O5YDtQt9q/9avEgA=;
  b=GySI9kat+LMOLBNU1fnRDjRt7skaXxrp1qSBa5NxVtD/j0ZHQCZYYKdz
   BsrSQlVjlMKMdwKeGKRxngIgo+Jf+eJIC8fELtQEkLgbAue/lUnT3yZ36
   642X/6/6kWOKE1x+SdN5qll1EYFW6JtCGfLBjq3AZtFh8CeifwSSkh/xs
   A8Q1WdwmLMDsw+MadqehVRkHLK3jlFHpubappzRgWqhDeVkjmnXpv7JE8
   kR0dpb8z92H/xgiLAtgPWDvtRgbgYb5QkRydqp71x1JZTPSnMEB0Wy9Np
   EolM5hhmRjpNhodwHgOb9hNAY+Xd9mCFaCDjxS36GO2MNrXrZokdGE5Wj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274238777"
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="274238777"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 18:18:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,282,1647327600"; 
   d="scan'208";a="647812363"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 06 Jun 2022 18:18:35 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyNrf-000DCX-5o;
        Tue, 07 Jun 2022 01:18:35 +0000
Date:   Tue, 7 Jun 2022 09:18:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_kvm_aia_v1 16/38] arch/riscv/kernel/smp.c:120:2-3:
 Unneeded semicolon
Message-ID: <202206070908.kJegL750-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_kvm_aia_v1
head:   0c38c32343008325233d4b0d253ce0b52c46f72e
commit: 2d75479ed6ec9caf1998a56343af18e5ad326692 [16/38] RISC-V: Treat IPIs as normal Linux IRQs
config: riscv-randconfig-c023-20220605 (https://download.01.org/0day-ci/archive/20220607/202206070908.kJegL750-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> arch/riscv/kernel/smp.c:120:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
