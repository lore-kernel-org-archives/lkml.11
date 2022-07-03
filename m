Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C7CCCA473
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Jul 2022 19:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGCTBd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 15:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiGCTBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 15:01:31 -0400
Received: from mailrelay4-1.pub.mailoutpod1-cph3.one.com (mailrelay4-1.pub.mailoutpod1-cph3.one.com [46.30.210.185])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966C85F76
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=2ZFARzV89Y+zuzcFxn0gSS6YLDJI2j0rdkLanFmF5yY=;
        b=eqioB4rpXH0QoKiHKlPAxvqFS+D/BUinr3JU7uxhhh9+LjrL1GTFdp6jZStBuNm41Qrrvhab+Cu3t
         VI1U97Upb3wfrbpY3hM+W26blpWZxUGS7EUJX/uqRx69RHwwgdbclPfShxwfjOyaCtU1VjltV/VNpE
         u52YCWBEOv0LzUXcMC4rzwfMH7hTGtTZSW+iUYyWejyHasjOjbxkqTxk1/SB3lOGP/ZYtZT3yI4UpC
         v8HgjrT3IvuQExGPBQlyTYzYcU56CKUi/AdFQeeS+UKUvY15j8Vp7qx6zbApSSqL3Q+nn4bSbMPCfb
         ENA3xAycsf1XqU91DVqnE55xX8Jtsxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=2ZFARzV89Y+zuzcFxn0gSS6YLDJI2j0rdkLanFmF5yY=;
        b=Cx0a5B5/DD5o31yngzt4vl46kwrz9eGwoOOrAl4M3VJGXp3PtwfelpEWq9280dD3yZ3oDjVlNvcrU
         qrPIkQdBQ==
X-HalOne-Cookie: ccb8945555c39a4c9f786335d10fca6079fd2d00
X-HalOne-ID: 894cd626-fb02-11ec-8239-d0431ea8bb10
Received: from mailproxy1.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 894cd626-fb02-11ec-8239-d0431ea8bb10;
        Sun, 03 Jul 2022 19:01:25 +0000 (UTC)
Date:   Sun, 3 Jul 2022 21:01:24 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: add EDT ETML0700Y5DHA
 panel
Message-ID: <YsHnhBMObRy9txLp@ravnborg.org>
References: <20220530122407.918874-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530122407.918874-1-m.felsch@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Mon, May 30, 2022 at 02:24:06PM +0200, Marco Felsch wrote:
> Add binding for the Emerging Display Technology ETML0700Y5DHA panel.
> It is a 7" WSVGA (1024x600) TFT LCD panel with:
>  - LVDS data interface,
>  - backlight and
>  - capacitive touch.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

I have just pushed this and the second patch to drm-misc
(drm-misc-next).

	Sam
