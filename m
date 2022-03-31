Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F31C2C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 17:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiCaRse (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 13:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCaRsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:48:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370E81FDFE0;
        Thu, 31 Mar 2022 10:46:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD9D2B82056;
        Thu, 31 Mar 2022 17:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39304C340ED;
        Thu, 31 Mar 2022 17:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648748802;
        bh=tbZNsTw1UdXaSnmTzwns9zjKEqYiDWFXOd0YkKvX4ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W5gEZK5aC7XSZFERUEoa3UN1s9DyE9pg3SJdspREW6NKtJ5BW5ZYc+Gl4RJhVcFKb
         oQM65BMZHl0le8/MvUXZeAzQQfZqkR6vPQGn7kjul6vSq/JsXicnLs3xWkwnCfdlxG
         S9us6QEhyUe/R2bbo9k7WV6o9h63tKXnjVBYO1L8=
Date:   Thu, 31 Mar 2022 19:46:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@google.com>
Cc:     Won Chung <wonchung@google.com>, Takashi Iwai <tiwai@suse.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] sound/hda: Add NULL check to component match callback
 function
Message-ID: <YkXo/8fEHmKxDM2S@kroah.com>
References: <s5hmth6eaiz.wl-tiwai@suse.de>
 <YkV1rsq1SeTNd8Ud@kuha.fi.intel.com>
 <s5hk0cae9pw.wl-tiwai@suse.de>
 <s5h7d8adzdl.wl-tiwai@suse.de>
 <s5hzgl6ciho.wl-tiwai@suse.de>
 <YkXJr2KhSzHJHxRF@google.com>
 <YkXY730wWhgJkRUy@kroah.com>
 <CAOvb9yiHXAWMn2_GcOnx5FYzfbp-2TmtN-OH90r31OqgbXQ3yQ@mail.gmail.com>
 <YkXiSEyfl9vkIG2w@kroah.com>
 <YkXmBQ5TJ4JNnuQG@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkXmBQ5TJ4JNnuQG@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 10:33:57AM -0700, Benson Leung wrote:
> Hi Greg,
> 
> On Thu, Mar 31, 2022 at 07:18:00PM +0200, Greg KH wrote:
> > On Thu, Mar 31, 2022 at 09:58:43AM -0700, Won Chung wrote:
> > > > So is this actually triggering on 5.17 right now?  Or is it due to some
> > > > other not-applied changes you are testing at the moment?
> > > >
> > > > confused,
> > > >
> > > > greg k-h
> > > 
> > > Hi Greg,
> > > 
> > > I believe it is not causing an issue in 5.17 at the moment. It is
> > > triggered when we try to apply new changes and test it locally.
> > > (registering a component for usb4_port)
> > 
> > Then why would it ever be needed to be backported to a stable kernel?
> > 
> > Please be more careful.
> > 
> > greg k-h
> 
> Sorry about that. I gave Won bad advice to cc stable. You're right, it will
> only be relevant when a future patch lands in usb4.

It isn't even relevant now, please only worry about this when you have
your patches ready for submission that causes this breakage.

thanks,

greg k-h
