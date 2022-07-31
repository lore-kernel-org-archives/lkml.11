Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FF6C3F6B0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Jul 2022 09:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiGaJNF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Jul 2022 05:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGaJND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 05:13:03 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9575FD18
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659258782; x=1690794782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=v2WXiaAeka1vFsLk5TXuKXJOwdFlcwrwYqPuUrR8DZY=;
  b=Uv1dgk29U4M9chKiO6Q8yeOK9hIaukz88dG+B2aBLW7GKgw4bziCRHCV
   hGtFSo0R9fmUgx0Bs82cKuV74wIqC679Dm4C5PxVZFOdpoCUfB9UFjLst
   lR0GUPanCfQ/89ZjQtXceZ6mecRNs8PZ0seaRv53IR48Qd5ng+5jmmtR/
   UvwgjSgkN817eHLLjRJwsOyP5TvSisjjqORtIfqwc8bipRcZgejzYZChV
   MHCunlO5kfiV1iv3Xf6dDv42bJVi78s4pI9iclGZKqUzW6UPqXkBZeQuh
   euXEEjZqDbZF4LGEdS1CNtZsXHviuRD/a/XlONVffV8cA9v03YWrrTJUh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="272024413"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="272024413"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 02:13:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="552199357"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2022 02:13:00 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oI50O-000DxA-09;
        Sun, 31 Jul 2022 09:13:00 +0000
Date:   Sun, 31 Jul 2022 17:12:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: [steev:linux-v5.19.0-rc8-tests 66/182]
 drivers/usb/typec/ucsi/ucsi_glink.c:622:34: warning: 'ucsi_glink_of_match'
 defined but not used
Message-ID: <202207311745.ZHWywfeV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/steev/linux linux-v5.19.0-rc8-tests
head:   171125613e081f0d0d9aeb710dc7469ce2c6a219
commit: 94fd877710430bce932c2ad94a97b9b082b03d5a [66/182] pmic_glink: Add UCSI/PAN prototype
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220731/202207311745.ZHWywfeV-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/steev/linux/commit/94fd877710430bce932c2ad94a97b9b082b03d5a
        git remote add steev https://github.com/steev/linux
        git fetch --no-tags steev linux-v5.19.0-rc8-tests
        git checkout 94fd877710430bce932c2ad94a97b9b082b03d5a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/usb/typec/ucsi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/ucsi/ucsi_glink.c:622:34: warning: 'ucsi_glink_of_match' defined but not used [-Wunused-const-variable=]
     622 | static const struct of_device_id ucsi_glink_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~


vim +/ucsi_glink_of_match +622 drivers/usb/typec/ucsi/ucsi_glink.c

   621	
 > 622	static const struct of_device_id ucsi_glink_of_match[] = {
   623		{ .compatible = "qcom,glink-ucsi", },
   624		{}
   625	};
   626	//MODULE_DEVICE_TABLE(of, ucsi_glink_of_match);
   627	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
