Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D538DC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 11:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiCaLlw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 07:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiCaLlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 07:41:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FE727B1E;
        Thu, 31 Mar 2022 04:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3A63B81BE2;
        Thu, 31 Mar 2022 11:39:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3DF9C340ED;
        Thu, 31 Mar 2022 11:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648726797;
        bh=chTX46Ow2eQgl0OjiZhg3AwRDXcUJ7di937siRva6Uc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UR5XzPsvt5NZkUoPPrzW3NsawOqugmV1MRmm5uraBPMD0XsKr97Ee9h0+uoiWebIt
         RRWfzxof4tUd/6hiyWMx5daNW62XwC4DAVWOl/Bn7Ei7kNEtsnDq6xdXMcRIgjE+qr
         Niyq9kD7P6sPh0UOJY/pMI5fakTflcraimJEOf0M=
Date:   Thu, 31 Mar 2022 13:39:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>, Won Chung <wonchung@google.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] sound/hda: Add NULL check to component match callback
 function
Message-ID: <YkWTBwAB1HrxcUR3@kroah.com>
References: <20220330211913.2068108-1-wonchung@google.com>
 <s5hzgl6eg48.wl-tiwai@suse.de>
 <CAOvb9yiO_n48JPZ3f0+y-fQ_YoOmuWF5c692Jt5_SKbxdA4yAw@mail.gmail.com>
 <s5hr16ieb8o.wl-tiwai@suse.de>
 <YkVzl4NEzwDAp/Zq@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkVzl4NEzwDAp/Zq@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 12:25:43PM +0300, Heikki Krogerus wrote:
> On Thu, Mar 31, 2022 at 11:12:55AM +0200, Takashi Iwai wrote:
> > > > > -     if (!strcmp(dev->driver->name, "i915") &&
> > > > > +     if (dev->driver && !strcmp(dev->driver->name, "i915") &&
> > > >
> > > > Can NULL dev->driver be really seen?  I thought the components are
> > > > added by the drivers, hence they ought to have the driver field set.
> > > > But there can be corner cases I overlooked.
> > > >
> > > >
> > > > thanks,
> > > >
> > > > Takashi
> > > 
> > > Hi Takashi,
> > > 
> > > When I try using component_add in a different driver (usb4 in my
> > > case), I think dev->driver here is NULL because the i915 drivers do
> > > not have their component master fully bound when this new component is
> > > registered. When I test it, it seems to be causing a crash.
> > 
> > Hm, from where component_add*() is called?  Basically dev->driver must
> > be already set before the corresponding driver gets bound at
> > __driver_probe_deviec().  So, if the device is added to component from
> > the corresponding driver's probe, dev->driver must be non-NULL.
> 
> The code that declares a device as component does not have to be the
> driver of that device.
> 
> In our case the components are USB ports, and they are devices that
> are actually never bind to any drivers: drivers/usb/core/port.c

Why is a USB device being passed to this code that assumes it is looking
for a PCI device with a specific driver name?  As I mentioned on the
mei patch, triggering off of a name is really a bad idea, as is assuming
the device type without any assurance it is such a device (there's a
reason we didn't provide device type identification in the driver core,
don't abuse that please...)

thanks,

greg k-h
