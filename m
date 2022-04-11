Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB91C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 16:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbiDKQxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbiDKQxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:53:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09E033E96
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:51:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5816468AFE; Mon, 11 Apr 2022 18:51:22 +0200 (CEST)
Date:   Mon, 11 Apr 2022 18:51:21 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/34] drm/i915/gvt: cleanup the Makefile
Message-ID: <20220411165121.GA26801@lst.de>
References: <20220411141403.86980-1-hch@lst.de> <20220411141403.86980-6-hch@lst.de> <20220411152508.GH2120790@nvidia.com> <87zgkrha7c.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgkrha7c.fsf@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 07:11:03PM +0300, Jani Nikula wrote:
> > Up to you but I usually sort these lists
> 
> Yeah, please do. Otherwise matches what I sent, so ack.

Let's just merge your 2 patch series ASAP and I'll rebase on top of
that.

What branch in drm-intel should I use as the base for the next version
btw?  Or does gvt go through yet another tree?
