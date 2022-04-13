Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5E8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Apr 2022 15:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236655AbiDMPtK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiDMPtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:49:08 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034D66579E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 08:46:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3E90868BEB; Wed, 13 Apr 2022 17:46:42 +0200 (CEST)
Date:   Wed, 13 Apr 2022 17:46:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Wang, Zhi A" <zhi.a.wang@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: refactor the i915 GVT support and move to the modern mdev API
 v3
Message-ID: <20220413154642.GA28095@lst.de>
References: <20220411141403.86980-1-hch@lst.de> <82c13d8e-1cb4-2873-86e9-16fd38e15b27@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82c13d8e-1cb4-2873-86e9-16fd38e15b27@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 01:47:05PM +0000, Wang, Zhi A wrote:
> > the GVT code in the i915 is a bit of a mess right now due to strange
> > abstractions and lots of indirect calls.  This series refactors various
> > bits to clean that up.  The main user visible change is that almost all
> > of the GVT code moves out of the main i915 driver and into the kvmgt
> > module.
> 
> Hi Christoph:
> 
> Do you want me to merge the GVT-g patches in this series? Or you want them to get merged from your side?

The two option here are drm tree via gvt and i915 trees or the vfio
tree, neither of which really is my tree.

We already have a fair bit of vfio changes at the tail end of the series,
and Jason has some more that should sit on top of it, and I have some
more that I haven't sent yet.

So if we could get the MMIO table and Makefile cleanups into a topic
branch that we could pull into the vfio tree and merge it through that
that would seem easiest to me, assuming that is ok with the i915, drm
and vfio maintainers.
