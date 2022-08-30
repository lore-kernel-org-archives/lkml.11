Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AB5ECAAD4
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 12:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiH3Myh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiH3Mx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:53:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D51132845;
        Tue, 30 Aug 2022 05:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6725C616B5;
        Tue, 30 Aug 2022 12:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6550FC433D7;
        Tue, 30 Aug 2022 12:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661864027;
        bh=qQ+Ls2PqvI0VuxPbDMq27sZY6OGPoQuUGYChfjWAHP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHaEIXCZ3BglGoarg69NTxqto+v+mvRSqBAdukUaNJUx/ioYDQtQGBPZoa6lSYhuS
         RpD7W76zc2HIhflJJx5Sg6zYZzOlfIQphHsHKS3oHGprtbS0ma/Ezw07Ozh9/iGFz7
         ooE1EJUAQW6bu37/SmkG/VsTSk8BeH5LqKps+mJI=
Date:   Tue, 30 Aug 2022 14:53:44 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linyu Yuan <quic_linyyuan@quicinc.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION 5.19] NULL dereference by ucsi_acpi driver
Message-ID: <Yw4IWHuUcUuJRbph@kroah.com>
References: <87r11cmbx0.wl-tiwai@suse.de>
 <YwEqtGB2WldUeiEN@kroah.com>
 <09f1204c-1256-e737-b769-be899870c946@quicinc.com>
 <Yw4H6rbVcu7Aaaa/@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yw4H6rbVcu7Aaaa/@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 02:51:54PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Aug 22, 2022 at 10:44:26AM +0800, Linyu Yuan wrote:
> > 
> > On 8/21/2022 2:40 AM, Greg Kroah-Hartman wrote:
> > > On Fri, Aug 19, 2022 at 06:32:43PM +0200, Takashi Iwai wrote:
> > > > Hi,
> > > > 
> > > > we've got multiple reports about 5.19 kernel starting crashing after
> > > > some time, and this turned out to be triggered by ucsi_acpi driver.
> > > > The details are found in:
> > > >    https://bugzilla.suse.com/show_bug.cgi?id=1202386
> > > > 
> > > > The culprit seems to be the commit 87d0e2f41b8c
> > > >      usb: typec: ucsi: add a common function ucsi_unregister_connectors()
> > > Adding Heikki to the thread...
> > > 
> > > > This commit looks as if it were a harmless cleanup, but this failed in
> > > > a subtle way.  Namely, in the error scenario, the driver gets an error
> > > > at ucsi_register_altmodes(), and goes to the error handling to release
> > > > the resources.  Through this refactoring, the release part was unified
> > > > to a funciton ucsi_unregister_connectors().  And there, it has a NULL
> > > > check of con->wq, and it bails out the loop if it's NULL.
> > > > Meanwhile, ucsi_register_port() itself still calls destroy_workqueue()
> > > > and clear con->wq at its error path.  This ended up in the leftover
> > > > power supply device with the uninitialized / cleared device.
> > > > 
> > > > It was confirmed that the problem could be avoided by a simple
> > > > revert.
> > > I'll be glad to revert this now, unless Heikki thinks:
> > > 
> > > > I guess another fix could be removing the part clearing con->wq, i.e.
> > > > 
> > > > --- a/drivers/usb/typec/ucsi/ucsi.c
> > > > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > > > @@ -1192,11 +1192,6 @@ static int ucsi_register_port(struct ucsi *ucsi, int index)
> > > >   out_unlock:
> > > >   	mutex_unlock(&con->lock);
> > > > -	if (ret && con->wq) {
> > > > -		destroy_workqueue(con->wq);
> > > > -		con->wq = NULL;
> > > > -	}
> > > > -
> > > >   	return ret;
> > > >   }
> > > > 
> > > > ... but it's totally untested and I'm not entirely sure whether it's
> > > > better.
> > 
> > this part is original code, yes, but when I make the change you mentioned,
> > 
> > as in the function ucsi_unregister_connectors(),  just use con->wq to
> > represent which connector initialized previous,
> > 
> > indeed if we clear it in ucsi_register_port(), something will left unclear.
> > 
> > please send a patch to fix it.
> > 
> > I think your change is good.
> 
> Ok, can someone send me a patch to apply to the tree for this?

Oh nevermind, I already have the revert in my tree, sorry for the noise.

greg k-h
