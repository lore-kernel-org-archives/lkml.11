Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE39C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 May 2022 14:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiEIOS7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 May 2022 10:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbiEIOS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 10:18:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 48E082B275E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 07:15:02 -0700 (PDT)
Received: (qmail 124832 invoked by uid 1000); 9 May 2022 10:15:01 -0400
Date:   Mon, 9 May 2022 10:15:01 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        USB mailing list <linux-usb@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH 4/4] USB: gadget: Add a new bus for gadgets
Message-ID: <Ynkh5eKtfxU+AyZX@rowland.harvard.edu>
References: <YmSc29YZvxgT5fEJ@rowland.harvard.edu>
 <YmSo6fU1FlNq8cOZ@rowland.harvard.edu>
 <YmSpKpnWR8WWEk/p@rowland.harvard.edu>
 <YmSpdxaDNeC2BBOf@rowland.harvard.edu>
 <alpine.DEB.2.22.394.2205031209030.681336@ramsan.of.borg>
 <YnFCEn45XwDWM/9Y@rowland.harvard.edu>
 <CAMuHMdVDK0W0T3=+2c1E6wtwy5JTUemTGYyj3PFuVUhK++AzrA@mail.gmail.com>
 <YnFO0Qr8RY7peFCg@rowland.harvard.edu>
 <YnaR8LaaPTdLTiok@rowland.harvard.edu>
 <CAMuHMdUpOiHHMktPk_-NauDW2ufvGThnkFU7Pok376pM6OEyYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUpOiHHMktPk_-NauDW2ufvGThnkFU7Pok376pM6OEyYw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:46:25AM +0200, Geert Uytterhoeven wrote:
> > Geert:
> >
> > Can you test the patch below?  It ought to fix the problem (although it
> 
> Thanks!
> 
> root@h3-salvator-xs:~# ls -l /sys/bus/gadget/devices/
> total 0
> lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.0 ->
> ../../../devices/platform/soc/e659c000.usb/gadget.0
> lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.1 ->
> ../../../devices/platform/soc/ee020000.usb/gadget.1
> lrwxrwxrwx 1 root root 0 Feb 14  2019 gadget.2 ->
> ../../../devices/platform/soc/e6590000.usb/gadget.2
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

> > might end up causing other problems down the line...)
> 
> Can you please elaborate? I'm not too familiar with UBS gadgets.

I was concerned about the fact that changing the name of a file, 
directory, or symbolic link in sysfs means changing a user API, and so 
it might cause some existing programs to fail.  That would be a 
regression.

Perhaps the best way to work around the problem is to leave the name set 
to "gadget" if the ID number is 0, while adding the ID number on to the 
name if the value is > 0.  What do you think?

Alan Stern
