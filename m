Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24049C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 19:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbiFXTkH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 15:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiFXTkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:40:05 -0400
Received: from mailrelay3-1.pub.mailoutpod1-cph3.one.com (mailrelay3-1.pub.mailoutpod1-cph3.one.com [46.30.210.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0279C823BC
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=tb/2Dzr0y82HxvxdXbUrZlICLXG09leCUh4rUujWTew=;
        b=aamk3NGnyFLGuUV7zNrNuY2sut2/w9FUjuk+Y3fxli7PYfosW9Xjo3ZAxCo2YidR5o7wp3oVNcRSj
         LBbEnpif7o2zGEuy6bv/GrLyAXdZ61TVOzxVcHGrPwRcHL5NK8FLSIsfOvjsplm9DzT4RZx8MDzVBK
         PZwkAito8nufmJjk6YT16xGMos0XYPVQuve1c65uNS9gptT2+MSZQU3J+vqLr+RVKhakMO9YStVnth
         Q09Mdw7rxYqIZqRxwgNPpU6FuEUx3x1Usi6cfpuH/qN9NkWBuWsveknfrzPFzX0FIMcuYUf5qAcP2+
         48e6H3l3QY+OET4SUftvuwWZNg8IaFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=tb/2Dzr0y82HxvxdXbUrZlICLXG09leCUh4rUujWTew=;
        b=XujhgoFv1EbT5vPXPuUikFZmXejWuleWrHpcUx7a/XOViOqjzILy0JcIlNI304dGQrvhP6fNfm6gH
         sDuaYHYDg==
X-HalOne-Cookie: 85d8e3b2b13cf959bb177e8137e5e1ee09d0b1e4
X-HalOne-ID: 70bf7d90-f3f5-11ec-be7c-d0431ea8bb03
Received: from mailproxy1.cst.dirpod3-cph3.one.com (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        by mailrelay3.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id 70bf7d90-f3f5-11ec-be7c-d0431ea8bb03;
        Fri, 24 Jun 2022 19:40:02 +0000 (UTC)
Date:   Fri, 24 Jun 2022 21:40:01 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] drm/panel: panel-dsi-cm: Use backlight helpers
Message-ID: <YrYTEcfYYdxsxdHQ@ravnborg.org>
References: <20220616172316.1355133-3-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616172316.1355133-3-steve@sk2.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 07:23:14PM +0200, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
> 
> Instead of setting the power state by manually updating fields in
> struct backlight_properties, use backlight_enable() and
> backlight_disable(). These also call backlight_update_status() so the
> separate call is no longer needed.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: dri-devel@lists.freedesktop.org
Thanks, applied to drm-misc (drm-misc-next)

	Sam
