Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727B1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Apr 2022 07:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359587AbiDTHG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Apr 2022 03:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiDTHG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:06:27 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636D239680
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:03:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B588D68AFE; Wed, 20 Apr 2022 09:03:38 +0200 (CEST)
Date:   Wed, 20 Apr 2022 09:03:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Zhi Wang <zhi.a.wang@intel.com>, kbuild-all@lists.01.org,
        zhenyu.z.wang@intel.com, terrence.xu@intel.com,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [intel-gvt:gvt-next-bak-2022-04-13 2/4]
 drivers/gpu/drm/i915/intel_gvt.h:66:5: error: no previous prototype
 for 'intel_gvt_iterate_mmio_table'
Message-ID: <20220420070338.GA4417@lst.de>
References: <202204201327.wDSzH3pV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202204201327.wDSzH3pV-lkp@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think the stub for intel_gvt_iterate_mmio_table needs a static inline.
Can we get this fixed up?
