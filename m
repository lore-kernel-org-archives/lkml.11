Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F70CC32793
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 14:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239228AbiHXOiH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 10:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbiHXOiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 10:38:03 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 806F171722
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 07:38:01 -0700 (PDT)
Received: (qmail 380905 invoked by uid 1000); 24 Aug 2022 10:38:00 -0400
Date:   Wed, 24 Aug 2022 10:38:00 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: ehci: Prevent possible modulo by zero
Message-ID: <YwY3yHB/Ia+cPa1L@rowland.harvard.edu>
References: <20220823182758.13401-1-khalid.masum.92@gmail.com>
 <20220823182758.13401-2-khalid.masum.92@gmail.com>
 <YwU2vp0FSR5dS/FX@rowland.harvard.edu>
 <CAABMjtH7q2evZ4R7FGC8m3a716ec9+e8+KdmrvnqB4_r6rF2Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAABMjtH7q2evZ4R7FGC8m3a716ec9+e8+KdmrvnqB4_r6rF2Jg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 05:15:47PM +0600, Khalid Masum wrote:
> On Wed, Aug 24, 2022 at 2:21 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> >         if (!ep) {
> >                 usb_free_urb(urb);
> >                 return NULL;
> >         }
> >
> > Neither of these patches is needed.
> >
> > Alan Stern
> 
> Thanks, I got you.

In fact, Coverity wasn't completely wrong; there is a possible bug here.  
However the suggested fix is not the right approach.

The usb_maxpacket() routine does a two-step computation.  First, it 
looks up the endpoint number in the pipe to get a usb_host_endpoint 
pointer, and then it uses the pointer to get the maxpacket value.  
Coverity complained that the lookup in the first step can fail, and that 
is in fact true: If there is an interface or configuration change before 
usb_maxpacket() is called, the endpoint number table can change and the 
lookup may fail.

But it turns out the first step isn't needed here at all, since the 
endpoint pointer is already stored in the URB (by the code in 
usb_submit_urb() that I pointed out earlier).  So an appropriate way to 
fix the problem is to carry out just the second step:

-	maxpacket = usb_maxpacket(urb->dev, urb->pipe);
+	maxpacket = usb_endpoint_maxp(&urb->ep->desc);

This holds for both of your patches.

Alan Stern
