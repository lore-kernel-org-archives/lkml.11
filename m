Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202E9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 23:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347458AbiDSXOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 19:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242419AbiDSXOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 19:14:45 -0400
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E137A2CC9C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 16:12:00 -0700 (PDT)
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id D2514628D8;
        Tue, 19 Apr 2022 23:11:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id E75EA20032;
        Tue, 19 Apr 2022 23:11:58 +0000 (UTC)
Message-ID: <b95d9b1058eed13489adba0bccdeb600950eb153.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Broadcom internal lists aren't maintainers
From:   Joe Perches <joe@perches.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 19 Apr 2022 16:11:58 -0700
In-Reply-To: <db4b9db9-fa02-4b92-3b9a-bd866fa0e73e@gmail.com>
References: <04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com>
         <db4b9db9-fa02-4b92-3b9a-bd866fa0e73e@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: E75EA20032
X-Stat-Signature: 3qohbj6dmugxg616wghxzag8j3xi14ct
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+0vnqgv9ZKZCWP1crLDZIVdAwCkwIzn1A=
X-HE-Tag: 1650409918-560077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-04-19 at 12:00 -0700, Florian Fainelli wrote:
> On 4/12/2022 11:34 AM, Joe Perches wrote:
> > Convert the broadcom internal list M: and L: entries to R: as
> > exploder email addresses are neither maintainers nor mailing lists.
> > 
> > Reorder the entries as necessary.
[]
> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -3746,7 +3746,7 @@ F:	include/linux/platform_data/b53.h
> >   
> >   BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
> >   M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
> > -L:	bcm-kernel-feedback-list@broadcom.com
> > +R:	Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
> 
> There is not a "Broadcom Kernel Team", the description of R: appears to 
> require some kind of full name, hence the choice of L: instead of R:.

If you don't like "Broadcom Kernel Team", perhaps
"Broadcom Kernel Reviewers" might work for you.

I think it doesn't matter much.



