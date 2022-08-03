Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AB5C19F2B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 21:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237819AbiHCVuO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHCVuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 17:50:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F852EA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 14:50:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE78615C6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 21:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D1AC433C1;
        Wed,  3 Aug 2022 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659563409;
        bh=BrvBHvTeL+xYbCEHOv5XtcAfbghOoBwnDllC6Zku4ac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQUSJ5C/ZXkaqfUWtXHS8klUkGgUuyJSQXw6/UVA9VnVtj5BABuC27VkpbafcVLwA
         Rwq3+KpfYcjTGPxVW72XC6bm+Hs0cBlpSsR0GYzBVf76CeApznq0mIC7wH71/gyoJq
         b9IDbUonfZaKYQO9GLyvTWa2suud4t7iS2163CW760MUaL4u121NiBbFYLpw84vUyf
         qwyc8KKmcAD0I27z34GaExmsCRZtNodcQq8+3H3+1vn7BTqhGvVMURuJsxMVgmbfS3
         H5K+y6AdVuT7staCL4MC5dm+M9QG3SzcmZzTKibT89grQxIfnj1ZwBvBx0XINmehq7
         JOZNhL2DePcFQ==
Date:   Wed, 3 Aug 2022 21:49:50 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniil Lunev <dlunev@chromium.org>
Cc:     Zdenek Kabelac <zdenek.kabelac@gmail.com>,
        Brian Geffon <bgeffon@google.com>,
        Mike Snitzer <snitzer@kernel.org>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH 1/1] dm: add message command to disallow
 device open
Message-ID: <YurtfvdeYh0kLd+8@gmail.com>
References: <YtB45Lte5UhlEE6y@redhat.com>
 <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
 <alpine.LRH.2.02.2207150528170.5197@file01.intranet.prod.int.rdu2.redhat.com>
 <cca5b463-a860-de8d-b7e4-a8d30aef2ff2@gmail.com>
 <CAONX=-fJHgfGkwR5A1MT+8FHckueehOsUS_LyHkjrgp4Y+vOgw@mail.gmail.com>
 <CAONX=-ft=ewFDui4jmd2fvcNr2EJc90=ZNOueDdp6HaPZmvObQ@mail.gmail.com>
 <Yun4LH+StcuBXRtO@sol.localdomain>
 <CAONX=-esLr5bGUks_a8wQBky37NnCawh2eOMemYg32HcPA7pmA@mail.gmail.com>
 <Yuq9jhxb+WgO55KJ@gmail.com>
 <CAONX=-dCrJabyvt2S24kEJi38Pbuzj_4kvugoF_75PWV69bNJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAONX=-dCrJabyvt2S24kEJi38Pbuzj_4kvugoF_75PWV69bNJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 06:44:53AM +1000, Daniil Lunev wrote:
> > Have you also considered unlinking the device node (/dev/dm-$idx) from the
> > filesystem after it has been set up for swap?
> Yes, the node can be re-linked with mknod, thus is not a suitable solution.

I thought you were trying to defend against path traversal attacks, not
arbitrary code execution?  If your threat model includes arbitrary code
execution by root, you really need to be using SELinux.

- Eric
