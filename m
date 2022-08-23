Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41ACC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 18:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbiHWSeT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiHWSdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:33:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5B1C59EE
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B920AB81E97
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 16:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D07B8C433D6;
        Tue, 23 Aug 2022 16:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661273783;
        bh=ykYOL7gSGZDNnRRgDev5HSCvPkulm8hwq0MTZUqdvIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8KLKrAasaWWsnbIU2WmG9qwRPo+0fdQ1cWag0aWOWkdTePkE+I/+70Jxg8jqrQHa
         q+R11I8FRN0VR9U1v/VNlVKXoRULKw2h0fE30JxNzb/7RIojEIlbVRXWWuyr0Mflaq
         pxGJn6Rxcz4KPqy++T5a5bdi6vaZe54T86i5Y794AA6JWPMXgv+6rRoLxJ6UxASQhh
         CeyPXIluvSbgHw7+EEI7d6gVm4w/jEh9zFd/sCB3cFi2S0oEBIv1CBFGySs5oFGOxC
         ZdY+i6TclHBMqnKUFKY5O7oLzwE2RpF4xIuP5I0T7h74SF1+6pyTtL4+vXe+EkXJUY
         bOl/Fe5GFDEVA==
Date:   Tue, 23 Aug 2022 22:26:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH v3 linux-next] soundwire: intel: Remove unnecessary TODO
Message-ID: <YwUGsucV4DMU5ZXp@matsya>
References: <20220817074859.4759-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817074859.4759-1-khalid.masum.92@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-22, 13:48, Khalid Masum wrote:
> The capabilities enabled for multi-link are required as part of the
> programming sequences, even when a stream uses a single link we still
> use the syncArm/syncGo sequences. Therefore the TODO is no longer
> necessary.

Applied, thanks

-- 
~Vinod
