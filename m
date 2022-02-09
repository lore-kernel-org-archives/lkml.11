Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A33C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbiBIEKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347329AbiBIDlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:41:52 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02801C06174F;
        Tue,  8 Feb 2022 19:41:51 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id q8so1240236oiw.7;
        Tue, 08 Feb 2022 19:41:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2uBLFZ0bop4GNjuX3AfN0OvA74Zgje4mCs2rxqz1als=;
        b=31aXIjLctDNLZLLgskwTD599B16SnHWgl/woimUvCZbB379m0VV0qvRWWM2hY9OYRu
         uY7mECobfNoqzcyWM21dSbWMdSwdouvX2oqgHJj6Bs18l5X3R0ei7HH7OFCmaWqZZz2w
         F+x983yhOjwfbqJR8GNi116/BWEu0fVHEIg5SBTGwjjedh+NimwGDue4KYHrfqebyIpJ
         UWlztDvNkSNI+Nly0I2f3pvl0YO7IIwm0VjeZxmPrQbcM2vFlym2GsELVvjiiK3VWDge
         +oQjajApK2g/4dkXyLeyR5Z5nSmLnxS9m8VknHdXBW0lfQy5jF5+qDBzo3U+4YTW6ZIQ
         yqUw==
X-Gm-Message-State: AOAM5326gJnxsVeYexnsaWxCUPazYzqkFM/Q2i7oZHWMzdocAGvdPXtk
        irxzIijr2ZLEjKGx7m+LDA==
X-Google-Smtp-Source: ABdhPJxHuCzQRSdgQbD/dpAHOEDefFhYMR9jsE8gC31ttWua2aUvf702XmQ5GzjfR7N8wqiNIbUWxg==
X-Received: by 2002:a05:6808:1598:: with SMTP id t24mr478637oiw.50.1644378110345;
        Tue, 08 Feb 2022 19:41:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o1sm6591379oik.0.2022.02.08.19.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 19:41:49 -0800 (PST)
Received: (nullmailer pid 3600805 invoked by uid 1000);
        Wed, 09 Feb 2022 03:41:48 -0000
Date:   Tue, 8 Feb 2022 21:41:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Greg KH <greg@kroah.com>, Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Oliver Neukum <oneukum@suse.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/4] dt-bindings: net: add schema for ASIX
 USB Ethernet controllers
Message-ID: <YgM3/OHpGaIy+b/c@robh.at.kernel.org>
References: <20220127104905.899341-1-o.rempel@pengutronix.de>
 <20220127104905.899341-2-o.rempel@pengutronix.de>
 <YfJ7JXrqEEybRLCi@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfJ7JXrqEEybRLCi@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:59:49AM +0100, Greg KH wrote:
> On Thu, Jan 27, 2022 at 11:49:02AM +0100, Oleksij Rempel wrote:
> > Create initial schema for ASIX USB Ethernet controllers and import all
> > currently supported USB IDs form drivers/net/usb/asix_devices.c
> 
> Again, you are setting yourself to play a game you are always going to
> loose and be behind on.  This is not acceptable, sorry.

I would suggest adding just the IDs you need. There probably aren't many 
which are hardwired. And if they aren't hardwired, what are they doing 
in DT?

Rob
