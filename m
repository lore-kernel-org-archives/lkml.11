Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A5F3C32774
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 00:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbiHUAM1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Aug 2022 20:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHUAMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 20:12:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374E71116B;
        Sat, 20 Aug 2022 17:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661040744; x=1692576744;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OgpJQveWh/vXtivXtPcPMrum27LfVsDmLhL3OPvr4pA=;
  b=ft3HCpJva1wHr2JsXt0hba7WwM7n/2L4maO7dy3SIW3S3fgSlI+kFz1l
   DY4Op24Fy6lSaNQEWLkQNFmlagTZPJ4qw7gKXhfUodUEE5HRt5ShjIYh0
   OtNawu+OofVN3VFJUuH/vuyGlQu8GsgxlBrmONoBN5qdnIGeXGPBoMof4
   iL+3ZUoQ4eXDj9SeaKStFP7JjZQj1bn0CgEjV5QpaAE21J6/5j3VCetW9
   phSNtP3kbPib3lwC5XaP1BSQ1Y2w0+JfWo6jwSbEM2DBST5PXyMIPgt5n
   VqSExX6G4xKeytsRbaFedYIiIeBgz3TdGYMYuEcyEuYGLBzWvYguiw39R
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="273599675"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="273599675"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 17:12:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="637701657"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2022 17:12:22 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPYZh-0003OR-2b;
        Sun, 21 Aug 2022 00:12:21 +0000
Date:   Sun, 21 Aug 2022 08:11:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [lunn:v6.0-rc1-kirkwood-dt 32/57] htmldocs: Warning:
 Documentation/devicetree/bindings/spi/marvell,orion-spi.yaml references a
 file that doesn't exist:
 Documentation/devicetree/bindings/bus/mvebu-mbus.txt
Message-ID: <202208210856.xKX1U4gx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/lunn/linux.git v6.0-rc1-kirkwood-dt
head:   ccd2fc5bd7bb1e532d745c8a145bac7e4aaa1614
commit: 8198ea75cec5fbe318f7e46e7a11245e7106bef2 [32/57] DT: bus: Convert mvebu-mbus.txt bus controller to YAML
reproduce:
        # https://github.com/lunn/linux/commit/8198ea75cec5fbe318f7e46e7a11245e7106bef2
        git remote add lunn https://github.com/lunn/linux.git
        git fetch --no-tags lunn v6.0-rc1-kirkwood-dt
        git checkout 8198ea75cec5fbe318f7e46e7a11245e7106bef2
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/devicetree/bindings/spi/marvell,orion-spi.yaml references a file that doesn't exist: Documentation/devicetree/bindings/bus/mvebu-mbus.txt

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
