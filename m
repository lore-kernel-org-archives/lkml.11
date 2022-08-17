Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B3AC28B2B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 13:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiHQNse (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 09:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHQNsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:48:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E448E32A96;
        Wed, 17 Aug 2022 06:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D60C661435;
        Wed, 17 Aug 2022 13:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6715C433C1;
        Wed, 17 Aug 2022 13:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660744108;
        bh=oY072z80Whl/TUmfEqOyp7S4ZsatcvmMePOWmEYF/S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CcDgHmLIV4tCGEyoJrzSBdurHpYWl9R6XeREsD6lPC0w71gTtjgqU1vGAl+jGsSzt
         0KXdk07balqqyaUc7wrZ3apURgh2lqjAAi8CcfJ7Njp4HljGNcdKYBIF83KKHhq/gX
         UD4RdhsxHsb/2YtbtEFNOttwJEb4Quor0tOTcF9Wa7/eO7nefXJE4e6pE7PalqFN8c
         kLiErlxkEJ9lZL1a/+GzYyiasaok7R/OJRMxcRxXXjVmwJRSdD8beiETSpxCUedA54
         DGmhZtfETu6jo6G6LzHgA1RTRltifmC0eYRMUjZxs3QPviZZPDsiXDBh+Be+kwZ8rJ
         RThzudAdbiD6A==
Date:   Wed, 17 Aug 2022 14:48:22 +0100
From:   Will Deacon <will@kernel.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     stefanha@redhat.com, jasowang@redhat.com,
        torvalds@linux-foundation.org, ascull@google.com, maz@kernel.org,
        keirf@google.com, jiyong@google.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        crosvm-dev@chromium.org
Subject: Re: IOTLB support for vhost/vsock breaks crosvm on Android
Message-ID: <20220817134821.GA12615@willie-the-truck>
References: <20220805181105.GA29848@willie-the-truck>
 <20220807042408-mutt-send-email-mst@kernel.org>
 <20220808101850.GA31984@willie-the-truck>
 <20220808083958-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808083958-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 08:45:48AM -0400, Michael S. Tsirkin wrote:
> > > Also yes, I think it's a good idea to change crosvm anyway.  While the
> > > work around I describe might make sense upstream I don't think it's a
> > > reasonable thing to do in stable kernels.
> > > I think I'll prepare a patch documenting the legal vhost features
> > > as a 1st step even though crosvm is rust so it's not importing
> > > the header directly, right?
> > 
> > Documentation is a good idea regardless, so thanks for that. Even though
> > crosvm has its own bindings for the vhost ioctl()s, the documentation
> > can be reference or duplicated once it's available in the kernel headers.
> > 
> So for crosvm change, I will post the documentation change and
> you guys can discuss?

FYI, the crosvm patch is merged here:

https://github.com/google/crosvm/commit/4e7d00be2e135b0a2d964320ea4276e5d896f426

Will
