Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E563C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 12:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbiDFMa4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiDFMaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:30:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B5B6452;
        Wed,  6 Apr 2022 01:23:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F036B82135;
        Wed,  6 Apr 2022 08:23:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E86C385A3;
        Wed,  6 Apr 2022 08:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649233384;
        bh=sq3H6Y68IxCy6XDLwf9nPN3WruxOabxFCXyYvvYXp2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WBx6WHDPkc7INkMbmlwQv7NxKLn5fQBLTF69gBKXT70LBdDQ+QTfyhWjclLKb5vin
         I941vWtgSohplbx37nEhQ1rfw8L9LVp+t8XxUKvwnxlp61ycPa1V0Rerd43RVGZ9aT
         RHgTRUL5fgXkGhq75jGUGHr1hsYVTsTuYYREZMhI=
Date:   Wed, 6 Apr 2022 10:23:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        slade@sladewatkins.com, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10 000/599] 5.10.110-rc1 review
Message-ID: <Yk1N5Vg+YrGxrfVo@kroah.com>
References: <20220405070258.802373272@linuxfoundation.org>
 <20220406010749.GA1133386@roeck-us.net>
 <20220406023025.GA1926389@roeck-us.net>
 <20220405225212.061852f9@gandalf.local.home>
 <20220405230812.2feca4ed@gandalf.local.home>
 <20220405232413.6b38e966@gandalf.local.home>
 <Yk1LMYzEOv7vmEHR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk1LMYzEOv7vmEHR@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 10:11:29AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 05, 2022 at 11:24:13PM -0400, Steven Rostedt wrote:
> > On Tue, 5 Apr 2022 23:08:12 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > Here's a thought, if you decide to backport a patch to stable, and you see
> > > that there's another commit with a "Fixes" tag to the automatically
> > > selected commit. DO NOT BACKPORT IF THE FIXES PATCH FAILS TO GO BACK TOO!
> > 
> > Seriously. This should be the case for *all* backported patches, not just
> > the AUTOSEL ones.
> > 
> > Otherwise you are backporting a commit to "stable" that is KNOWN TO BE
> > BROKEN!
> 
> My scripts usually do catch this, let me go see what went wrong...

Ok, my fault, my scripts _did_ catch this, but I ignored it as it was
filled with other noise.  I've now queued this commit up.

thanks for catching this and sorry for missing it the first time around.

greg k-h
