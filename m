Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED3AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 16:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242846AbiBWQfg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbiBWQfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 11:35:25 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5E382532F6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 08:34:57 -0800 (PST)
Received: (qmail 1012990 invoked by uid 1000); 23 Feb 2022 11:34:56 -0500
Date:   Wed, 23 Feb 2022 11:34:56 -0500
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        syzbot <syzbot+348b571beb5eeb70a582@syzkaller.appspotmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "balbi@kernel.org" <balbi@kernel.org>
Subject: Re: [syzbot] KASAN: use-after-free Read in dev_uevent
Message-ID: <YhZiMHHjrBw8am5g@rowland.harvard.edu>
References: <0000000000005a991a05a86970bb@google.com>
 <00000000000033314805d8765175@google.com>
 <PH0PR11MB58805E3C4CF7D4C41D49BFCFDA3C9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <YhYafwiwUV2Sbn5t@kroah.com>
 <YhZG3GJb8G7oL7l7@rowland.harvard.edu>
 <YhZaDGeIIvpILdCk@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhZaDGeIIvpILdCk@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 05:00:12PM +0100, gregkh@linuxfoundation.org wrote:
> On Wed, Feb 23, 2022 at 09:38:20AM -0500, stern@rowland.harvard.edu wrote:
> > Which bus locks are you referring to?  I'm not aware of any locks that 
> > synchronize dev_uevent() with anything (in particular, with driver 
> > unbinding).
> 
> The locks in the driver core that handle the binding and unbinding of
> drivers to devices.
> 
> > And as far as I know, usb_gadget_remove_driver() doesn't play any odd 
> > tricks with pointers.
> 
> Ah, I never noticed that this is doing a "fake" bus and does the
> bind/unbind itself outside of the driver core.  It should just be a
> normal bus type and have the core do the work for it, but oh well.
> 
> And there is a lock that should serialize all of this already, so it's
> odd that this is able to be triggered at all.

I guess at a minimum the UDC core should hold the device lock when it 
registers, unregisters, binds, or unbinds UDC and gadget devices.  
Would that be enough to fix the problem?  I really don't understand how 
sysfs file access gets synchronized with device removal.

> Unless the device is being removed at the same time it was manually
> unbound from the driver?  If so, then this really should be fixed up to
> use the driver core logic instead...

Device removal does of course trigger unbinding, but they always take 
place in the same thread so it isn't an issue.

Probably part of the reason people don't want to use the driver core 
here is so that they can specify which UDC a gadget driver should bind 
to.  The driver core would always bind each new gadget to the first 
registered gadget driver.

When Dave Brownell originally wrote the gadget subsystem, I believe he 
didn't bother to integrate it with the driver core because it was a 
"bus" with only a single device and a single driver.  The ability to 
have multiple UDCs in the system was added later.

Alan Stern
