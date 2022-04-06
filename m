Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062D0C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 09:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiDFJkj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 05:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1585398AbiDFJgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:36:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CF42713BF;
        Tue,  5 Apr 2022 19:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9136B80E2C;
        Wed,  6 Apr 2022 02:14:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B35C385A0;
        Wed,  6 Apr 2022 02:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649211255;
        bh=XdBZej03OeBo+18/e4QPeg0/pTn8quJVETWrS97Y3p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHVGKhLClKU8O/mFZSXbm7xTBh3CmgQY4VZWWiSDOcxogHlQAywMkXPb7i34nRtSl
         FBJIOKGDhcLJImcv8RdqY7bPWDNDctLrida+bdHOutqMoXs57lAj3x0VaNWREmZX2S
         W6NtPit5fHKwr34To8KVGQSUPvERqurU6CcVc7UkabiJgY1dBoexQ54mhWMml693HH
         oNI17MN5uQHYJv9+WzCdcOBKo+Buw8zPm9/Mq1OlZUr+qM2A4vysK5z3amP/2RKcnv
         bSkyoLd260aHUDwpHQOKNOR0Punw6nnxXpMbqxOMDZkrZ30ZH2K3hXCxlRypo+oyBu
         TiHXG/0yi4unA==
Date:   Wed, 6 Apr 2022 10:14:07 +0800
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
Subject: Re: [PATCH v1 1/8] ARM: dts: imx6qdl-vicut1/vicutgo: Set default
 backlight brightness to maximum
Message-ID: <20220406021407.GG129381@dragon>
References: <20220221095312.3692669-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221095312.3692669-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 10:53:05AM +0100, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Recover default behavior of the device and set maximal brightness
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>

Applied, thanks!
