Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F4AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 09:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbiBXJKc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbiBXJKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:10:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A581A129B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:09:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ECA9CB82423
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F24DC340EB;
        Thu, 24 Feb 2022 09:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645693741;
        bh=ovs427pMOWMmMtKStbeMl7Fcfp8pHLXcxD25G2EQDc4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTyaiuqSJLA9U32CQVbpr1fTeGmWVBj/u00Ech+iNpV0M7ZwWZRld44aPKbnRadsK
         gFL492Edj0WViptuQyXcFhsK38tFm07TBpe8LBdng63SljTvtnyoBXc23futu11hGi
         coAe+/QwQFvcKPi0HxDplYgW7EOCmvJkIUd6shvI=
Date:   Thu, 24 Feb 2022 10:08:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] driver core: Refactor device unbind/probe fail
 clean-ups
Message-ID: <YhdLKuv3D/tQ9ia8@kroah.com>
References: <20220223225257.1681968-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223225257.1681968-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 04:52:55PM -0600, Rob Herring wrote:
> The same sequences of device clean-up code are duplicated 3 times.
> Changes to this code are prone to missing one of the copies. This
> series refactors the code into 2 common functions as there's some slight
> differences in the intermediate steps.
> 
> Rob
> 
> Rob Herring (2):
>   driver core: Refactor multiple copies of device cleanup
>   driver core: Refactor sysfs and drv/bus remove hooks
> 
>  drivers/base/dd.c | 80 ++++++++++++++++++-----------------------------
>  1 file changed, 30 insertions(+), 50 deletions(-)
> 
> -- 
> 2.32.0
> 

What branch/tree did you make these against?  They do not apply at all
to my "driver-core-next" branch of the driver-core.git tree on
git.kernel.org :(

thanks,

greg k-h
