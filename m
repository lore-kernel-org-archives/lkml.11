Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44078C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 16:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiDFQEa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237123AbiDFQCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:02:23 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEE7147AC7;
        Wed,  6 Apr 2022 06:33:50 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E414124000D;
        Wed,  6 Apr 2022 13:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649252029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VZSNvYxkXiI/qyt3Ay1/TRdTEkEBSR7Ri5rYdZsNpJg=;
        b=GnVoS3ntG9TD90Pj1QbyeCJNCqbLE3j84RFT8YpwsBp2LiW0njGPShVG0jQg3FhPaPuCE+
        EILKKtlxrpvoHxDd21noWHF0QD9piuDxcGf0t3nfMepTqrCZdM4nyr4c+E+CrVBaATKwgc
        JMsYFJt+LMlagQVqdqU33fT/CzSnEaqhG5yBMsEmhyLybc9C1vCv7WXh0d08VZfymFgBUT
        NOI4adGUAINE12QXOw6IqQ2iuCqVTPVJiyHJN9Pu3AOYUbJvwJweTRLP+QNaZkO0aAWPuL
        46sJDwmjU6ghkoMqn9+kfsn08ukZ0uDMQrPVmxf/WnSQ5lACH1f2LjkXfG8kVA==
Date:   Wed, 6 Apr 2022 15:33:46 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <Yk2WulTcdtwlMGrj@mail.local>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
 <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
 <20220405092434.6e424ed4@fixe.home>
 <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
 <20220405175120.23fc6b2a@fixe.home>
 <CAL_JsqLdBcAw1KPnrATHqEngRWkx6moxDODH1xV67EKAufc6_w@mail.gmail.com>
 <20220406094019.670a2956@fixe.home>
 <Yk2TVAfPVh9a1tUR@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk2TVAfPVh9a1tUR@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2022 08:19:16-0500, Rob Herring wrote:
> > > > > I've told the Xilinx folks the same thing, but I would separate this
> > > > > into 2 parts. First is just h/w work in a DT based system. Second is
> > > > > creating a base tree an overlay can be applied to. The first part should
> > > > > be pretty straightforward. We already have PCI bus bindings. The only
> > > > > tricky part is getting address translation working from leaf device thru
> > > > > the PCI bus to host bus, but support for that should all be in place
> > > > > (given we support ISA buses off of PCI bus). The second part will
> > > > > require generating PCI DT nodes at runtime. That may be needed for both
> > > > > DT and ACPI systems as we don't always describe all the PCI hierarchy
> > > > > in DT.  
> > > >
> > > > But then, if the driver generate the nodes, it will most probably
> > > > have to describe the nodes by hardcoding them right ?  
> > > 
> > > No, the kernel already maintains its own tree of devices. You just
> > > need to use that to generate the tree. That's really not much more
> > > than nodes with a 'reg' property encoding the device and function
> > > numbers.
> > 
> > Just to clarified a point, my PCI device exposes multiple peripherals
> > behind one single PCI function.
> 
> Right. I would expect your PCI device DT node to have a 'simple-bus' 
> child node with all those peripherals. And maybe there's other nodes 
> like fixed-clocks, etc.
> 
> > To be sure I understood what you are suggesting, you propose to create
> > a DT node from the PCI driver that has been probed dynamically
> > matching this same PCI device with a 'reg' property. I also think
> > this would requires to generate some 'pci-ranges' to remap the
> > downstream devices that are described in the DTBO, finally, load the
> > overlay to be apply under this newly created node. Is that right ?
> 
> Right. You'll need to take the BAR address(es) for the device and stick 
> those into 'ranges' to translate offsets to BAR+offset.
> 

Last time I tried that, this was not working well because it means that
the ranges property of the device depends on the host machine...

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
