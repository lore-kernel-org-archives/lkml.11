Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39895C32796
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 17:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240338AbiHXR6h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiHXR63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:58:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB2D4D83C;
        Wed, 24 Aug 2022 10:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6433D6171C;
        Wed, 24 Aug 2022 17:58:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D78CC433D6;
        Wed, 24 Aug 2022 17:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661363903;
        bh=SF9MpmKrkhm4N4zj5pYtfBiBQo+XAO7tLY54KFyZaZ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knXzyhff/X1fMETmOqnyx+uSvMoClzsz0FJyci3gSw+AAZE/IbE5pUdIJj5pvOevU
         5MzbH9fnqM9+aadyO6VKxsORR4ulb9CdysEhOYOGUU3dG2Yxwxi30pdS33VyHLK34q
         fPYs30AmZcsRNGeQ6Tw0imewmt3Qw6AUiRJRBhRE=
Date:   Wed, 24 Aug 2022 19:58:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steve French <smfrench@gmail.com>
Cc:     Stable <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: "Fixes:" vs. "Cc: stable ..."
Message-ID: <YwZmu1ZTbjVqIY/C@kroah.com>
References: <CAH2r5muO1OkOV0jjJo89Zpvj43u_X95smuujg66-emQFgSXfgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muO1OkOV0jjJo89Zpvj43u_X95smuujg66-emQFgSXfgQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 12:14:12PM -0500, Steve French wrote:
> Do changesets that already included the "Fixes:" tag in the commit
> description also need to include the "Cc: stable@vger.kernel.org" in
> order to be included in stable?

As per the documentation:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

You should be putting cc: stable@... on the patch.

But as not all maintainers do, we have to dig through those with Fixes:
in order to actually catch all bugfixes :(

So please, use cc: stable.

thanks,

greg k-h
