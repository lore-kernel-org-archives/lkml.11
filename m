Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC24DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 14:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbiBIOZ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 09:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbiBIOZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:25:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F6C06157B;
        Wed,  9 Feb 2022 06:25:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7C9261A6A;
        Wed,  9 Feb 2022 14:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DD2C340ED;
        Wed,  9 Feb 2022 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644416722;
        bh=XcYfknGH6aLgHmHW+mshSs5mFup1XNoYNC3OsL5D9+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ySL1rb24TGoaoIHMHg8fSitpF5oMZWnRxXEnYLW+H/SQ7ZK5yuNhBvZRYyoM8LyQc
         NHXZo/hwYoklLV9SZzvsyMpIx5hNZ3g3whug9IkIMJcTSlnT9YAsbaNFw6ejE0xlFi
         JoR/zBKOI0SIbGON9Pt+7bEyjP2Wn8ls3v8pp1rI=
Date:   Wed, 9 Feb 2022 15:25:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com,
        cy_huang@richtek.com, will_lin@richtek.com, th_chuang@richtek.com,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Add Richtek RT1719 USBPD controller support
Message-ID: <YgPOz6pfpFcPmHms@kroah.com>
References: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644415355-24490-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 10:02:33PM +0800, cy_huang wrote:
> 3. Change MODULE_LICENSE from 'GPL v2' to 'GPL'.

Why?  Either is fine, any specific reason you changed this?

thanks,

greg k-h
