Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B664C4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 04:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbiDSEdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 00:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiDSEdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:33:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D2221E0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 21:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650342626; x=1681878626;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qySfP5zH9EMGVRLCovLYQaW1W68FxTzitWV5nZA27Cs=;
  b=RMa/c43iIS8qxt49CSNuJucd5Xrl4fGTir7mR61TTs92y7bUsAsExP15
   gVH28TZu27iZtsQSSVvVhA+kJ4OudnJN50pN/w7/ABfpbbyqeVdB/iF6B
   icTMgPTvtyKU43/nvKPbZdpUq0RuFhzBiT7IwUfEabd1WWKt6GSTu4UQm
   Rkn4Fas3MrBuZah3nQ6KQz2h199lhLCHMI1LN34GFBnm1Pr6jB27RRPQ+
   LO+wh2AzLc+IsjuMg2qpBS3TWA+xX5QTmVY1RU0yLipPgVZiFe7Y52Cpx
   sI1ZOIIaEb0aUP72HIIGz6chDgzE/N6FWIxpBIlMA/K33RhhnAJYdTkRr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="262531824"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="262531824"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 21:30:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="665770647"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 18 Apr 2022 21:30:24 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngfVP-0005L8-Mv;
        Tue, 19 Apr 2022 04:30:23 +0000
Date:   Tue, 19 Apr 2022 12:30:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Suman Anna <s-anna@ti.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/remoteproc/ti_k3_dsp_remoteproc.c:432:17: sparse: sparse:
 cast removes address space '__iomem' of expression
Message-ID: <202204191250.9zqeCPVs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: b8431920391d36c273f63a29eab0dfc7e884dd17 remoteproc: k3-dsp: Add support for IPC-only mode for all K3 DSPs
date:   5 weeks ago
config: arm64-randconfig-s031-20220419 (https://download.01.org/0day-ci/archive/20220419/202204191250.9zqeCPVs-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b8431920391d36c273f63a29eab0dfc7e884dd17
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout b8431920391d36c273f63a29eab0dfc7e884dd17
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/ti_k3_dsp_remoteproc.c:432:17: sparse: sparse: cast removes address space '__iomem' of expression

vim +/__iomem +432 drivers/remoteproc/ti_k3_dsp_remoteproc.c

   402	
   403	/*
   404	 * This function implements the .get_loaded_rsc_table() callback and is used
   405	 * to provide the resource table for a booted DSP in IPC-only mode. The K3 DSP
   406	 * firmwares follow a design-by-contract approach and are expected to have the
   407	 * resource table at the base of the DDR region reserved for firmware usage.
   408	 * This provides flexibility for the remote processor to be booted by different
   409	 * bootloaders that may or may not have the ability to publish the resource table
   410	 * address and size through a DT property. This callback is invoked only in
   411	 * IPC-only mode.
   412	 */
   413	static struct resource_table *k3_dsp_get_loaded_rsc_table(struct rproc *rproc,
   414								  size_t *rsc_table_sz)
   415	{
   416		struct k3_dsp_rproc *kproc = rproc->priv;
   417		struct device *dev = kproc->dev;
   418	
   419		if (!kproc->rmem[0].cpu_addr) {
   420			dev_err(dev, "memory-region #1 does not exist, loaded rsc table can't be found");
   421			return ERR_PTR(-ENOMEM);
   422		}
   423	
   424		/*
   425		 * NOTE: The resource table size is currently hard-coded to a maximum
   426		 * of 256 bytes. The most common resource table usage for K3 firmwares
   427		 * is to only have the vdev resource entry and an optional trace entry.
   428		 * The exact size could be computed based on resource table address, but
   429		 * the hard-coded value suffices to support the IPC-only mode.
   430		 */
   431		*rsc_table_sz = 256;
 > 432		return (struct resource_table *)kproc->rmem[0].cpu_addr;
   433	}
   434	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
