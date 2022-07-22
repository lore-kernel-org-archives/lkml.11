Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBEC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 15:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbiGVPEG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 11:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiGVPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:04:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9590A6FA07
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:04:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 24F9268AFE; Fri, 22 Jul 2022 17:03:59 +0200 (CEST)
Date:   Fri, 22 Jul 2022 17:03:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robert Beckett <bob.beckett@collabora.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, kernel@collabora.com,
        Christoph Hellwig <hch@lst.de>,
        Thomas Hellstrom <thomas.hellstrom@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915: stop using swiotlb
Message-ID: <20220722150358.GA7152@lst.de>
References: <20220722145920.1513509-1-bob.beckett@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722145920.1513509-1-bob.beckett@collabora.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	return max_t(size_t, UINT_MAX, dma_max_mapping_size(dev));

Shouldn't this be a min?
