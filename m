Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D090DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 15:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240937AbiESP0e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 11:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240982AbiESP0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:26:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9AC2FE78
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:26:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9186AB82291
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 15:26:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A5BC385AA;
        Thu, 19 May 2022 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652973965;
        bh=dDnUcNYZBVw4u08LEGNx6dxhis/Ia2b/IAkAEH7rhpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8cujE0ATdN96B6fxvhC7nfzmtTdUl37pV+/tyQaYLcxnZ5RXXrL+FuZyhGEDfaqJ
         rm42PKqFP8DntCCaJzQmEEx32ZNKvFaAXb+0l4d+UscWZacELDMPh2AkkyW8FeOTuC
         kuji9ZmBC/mWtRugXMHqJZkNKZtLzVhCGGWEUlEo=
Date:   Thu, 19 May 2022 17:24:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        kernel-team@fb.com
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own
 loglevel
Message-ID: <YoZhLTm3Rwi4pve4@kroah.com>
References: <YoUBh5BSsURDO71Z@chrisdown.name>
 <YoUR6RlzkCNG7BU0@kroah.com>
 <YoVM+KbdyJm8RSSr@chrisdown.name>
 <YoVO23+fvsNPnpKh@kroah.com>
 <YoVWpZKHD7aec0CJ@chrisdown.name>
 <YoXsAkUgzIjJR90W@kroah.com>
 <YoZQQwtG12Ypr2IC@chrisdown.name>
 <YoZVvA5FP4wFLSH9@kroah.com>
 <YoZdVCfK4T8Ts2oS@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoZdVCfK4T8Ts2oS@chrisdown.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 04:08:04PM +0100, Chris Down wrote:
> Greg Kroah-Hartman writes:
> > >  struct console {
> > >  	char	name[16];
> > >  	void	(*write)(struct console *, const char *, unsigned);
> > > @@ -179,9 +173,11 @@ struct console {
> > >  	void	*data;
> > >  	struct	 console *next;
> > >  	int	level;
> > > -	struct	device classdev;
> > > +	struct	device *classdev;
> > 
> > Ick, no, keep the real structure here.  It can properly handle the
> > reference counting for the object.  Just correctly clean up in the
> > release function, not anywhere else.
> 
> Sorry, I'm getting more and more confused about what you're asking me to do,
> and less and less clear on the rationale.
> 
> Can you please clarify what "correctly cleaning up" would mean for a
> non-pointer `struct device'?
> 
> Is your concern that...
> 
>     register_console(c)
>         device_initialize(c->d)
>         device_add(c->d)
>     unregister_console(c)
>         device_unregister(c->d)      console_classdev_release(c->d)
>     register_console(c)
>         device_initialize(c->d)  <-- classdev was not previously zeroed out
> 				     in console_classdev_release() and bad 				     things may happen
> 
> If that's not the point, I could really use some clarification about what
> "correctly cleaning up" means for a non-pointer `struct device' :-)

The problem is that your release() callback for your class HAS TO clean
up the memory for that object.  You can not have an empty function, or
just say "it will be handled elsewhere."  That is the LAST call that
will be made when the object is to be freed from memory, as that is when
the last reference count is dropped.  Anytime before then, you do not
know if it is safe to free the memory or not.

Does that help?

thanks,

greg k-h
