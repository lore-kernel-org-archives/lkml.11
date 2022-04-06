Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDC8C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 13:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiDFN31 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 09:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbiDFN2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:28:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF31107F8;
        Tue,  5 Apr 2022 19:15:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 796ECB81FB7;
        Wed,  6 Apr 2022 02:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DADC385A0;
        Wed,  6 Apr 2022 02:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649211310;
        bh=2q0MEfiv8/KfVoQ1a/O2AiaUZczGrGkW49etIDJ3rXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cfrf6gdAfOomT2fjbWyUYFn+K+RnjvTDHP6gLTtYiaYCleRHFgAsE3tdSSHMLIMih
         gI8+F0Hwy2UWH5Ujl9ZUPgrJmEgIXt5x0IH57M/aFKH7oQutNLjaOrXTyD+hjfTrLW
         ms9msjfZb0ECU6H2d3DD1w2tgyQXqQ+xdyY+QYBvowkfEmJuQptiQp3mKFiLBTq2Ep
         FHc1umrBbTzKG0+zAZpppNPZF+QtRQ+RM/aEspOlKIHQRvRZmUC5hBtRdm8W7iMk1r
         lDv8rIXdpY9z/4ZWmTOfSYND5tDOQB2tbHFyF5vKcFoYcTTpUVkGGcgPmzcOWElCGY
         WMSPJCGJzWvBg==
Date:   Wed, 6 Apr 2022 10:15:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 3/8] ARM: dts: imx6qdl-vicut1/vicutgo: Add
 backlight_led node
Message-ID: <20220406021503.GI129381@dragon>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
 <20220221095312.3692669-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221095312.3692669-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:07AM +0100, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> backlight_led is the dimmable backlight for the rubber border on the case. It
> is also used to highlight the power- and some other buttons.
> 
> MX6QDL_PAD_SD4_DAT1__PWM3_OUT is also assigned as output for pwm3. Since
> we need pwm3 for the backlight, we're forced to disable user space hardware
> revision detection. The bootloader will have to supply this information
> (i.e. through device tree).
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
