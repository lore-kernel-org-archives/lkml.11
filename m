Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9ADC433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 21:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbiCIV5H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238496AbiCIV5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:57:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D9F11E3C5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 13:56:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7CD461B47
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 21:56:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0329EC340E8;
        Wed,  9 Mar 2022 21:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646862963;
        bh=IS54PgFpU8xs3vpDbc6IUoRHStNZV8CcU58i4EZlsVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=daT+BLOSXTPt6p40LYsGmlkC5D5hlK9QR2vfX0I8RorWfsak9UI8OQq/Eux1WtMUA
         dsCsM5BE4Ajk/I7zh1DpvLLW58HcueVHxGe+g+n7JulbijagV3XBUrVnoK7HBGl9az
         /cHwXs2B+34a+94z1kNINeScA0AICuVobXF9y1QoYBAuAlN9ea1tsTZ3FfdgIjXJs4
         EwTwp/bskdD7kuSPSL6eRaCKNGN5F/c2xXR6FE3G1/3oolSxdDf68hW5OY5tJmAJKN
         VtgmC8J1+8mkSG3G41tu403QZGHUxvgr4unlb6L+QsKJSDJgoGDpWeoASl7E+EFzFD
         VwGcS2Vgapttw==
Date:   Wed, 9 Mar 2022 13:56:01 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] f2fs: don't pass a bio to f2fs_target_device
Message-ID: <YikiceholHfw3Vql@google.com>
References: <20220228124123.856027-1-hch@lst.de>
 <20220228124123.856027-2-hch@lst.de>
 <32114417-fd17-9412-28da-10f0ff09530d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32114417-fd17-9412-28da-10f0ff09530d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01, Chao Yu wrote:
> On 2022/2/28 20:41, Christoph Hellwig wrote:
> > Set the bdev at bio allocation time by changing the f2fs_target_device
> > calling conventions, so that no bio needs to be passed in.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Acked-by: Jaegeuk Kim <jaegeuk@kernel.org>

> 
> Thanks,
