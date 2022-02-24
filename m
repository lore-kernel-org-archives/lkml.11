Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EEDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 09:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiBXJIU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbiBXJIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 04:08:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E6113AF9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 01:07:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39FFB60A5F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:07:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9B3C340F1;
        Thu, 24 Feb 2022 09:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645693663;
        bh=Ba3K+INmt5cfhireoxThid5W8f4jm5ojVyQ0VA52R8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OdhjtUsqtKBHg97ioAKHhB5JzJfaPm4YVZXxI9CATxq+gPRw+uVpgNc/9unttgVCy
         gJ3MQc/PfVnfz09lWz0x1yGQgbYZ4whbHEBJIlaVy9Q14A+rLzqvjHAi1f/FLhzwOF
         6U9Qe9OZzws+mFVHAfbhZeeVLEH0h8smL+jalzeE=
Date:   Thu, 24 Feb 2022 10:07:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] driver core: Refactor sysfs and drv/bus remove hooks
Message-ID: <YhdK3NtkC0sgkNgO@kroah.com>
References: <20220223225257.1681968-1-robh@kernel.org>
 <20220223225257.1681968-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223225257.1681968-3-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 04:52:57PM -0600, Rob Herring wrote:
> There are 3 copies of the same device sysfs cleanup and drv/bus remove()
> hooks used for probe failure, testing re-probing, and device unbinding.
> 
> Let's refactor the code to its own function.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Note that driver_sysfs_remove() remains a separate call because in
> __device_release_driver() it is called with a pm runtime get/put and
> before the unbind notifier. Browsing the history, it doesn't seem like
> there's any particular reason for this ordering. We also have other
> sysfs teardown done later. It would be more logical to do all the
> sysfs teardown at once. Thoughts?

I think it should be unified, so you can send a follow-on patch to do
that.

I'll go queue these changes up now, thanks for the cleanups!

greg k-h
