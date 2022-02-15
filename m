Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C2CC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 22:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbiBOWcr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 17:32:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbiBOWcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:32:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF559FB42
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 14:32:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id 775CD1F44DC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644964352;
        bh=qG9SVvMjlyz4qoL+19w6ELJjlO669Za8jz7+TJy+kt8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kxjgBS55i5eKGUrYZHuVMmSeaaOnUvH++tqFW41kGog7o9dHnReY/PYeP4zwiQER2
         QZHvYJOyvg4YyYuwcnJtJVifWEXS/u0fqrikPt2lnTMuyW2FGlJeel4ZP3Pg/AIngS
         7Drpx+Y1yfOAmScLs747gxCDTqvH5D60TytlpM6nvh5zIFw9wKCKrjsDxGS6CRmQyV
         hXV6iiUZmJA+1wl2xRCAfhX/qxjr6gdjv+c0mzTKw70JrRdfltKbWe0uDG6TJlIq0C
         ShWJqqnYkAxDc2SMM+cbhnMXZpGHnXu/9W6XE51SkG0SzQrZYEBNA96h69IoRdjoGk
         285SVnwOf75sQ==
Date:   Tue, 15 Feb 2022 17:32:24 -0500
From:   Alyssa Rosenzweig <alyssa@collabora.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] drm/panfrost: Dynamically allocate pm_domains
Message-ID: <Ygwp+LDliCnbkMZQ@maud>
References: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
 <CAL_JsqKdb0_N252hR=iv3Lpi6T9+iCRBwzBQhS7UQGFNhM5k=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKdb0_N252hR=iv3Lpi6T9+iCRBwzBQhS7UQGFNhM5k=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd do the oneliner changing it to 5 and be done with it. That being
> said, we have plenty of examples of doing this both ways, so whatever
> makes people happy.

Excellent, that's the patch I wrote originally :-)

Dropping this patch, unless Angelo (or someone else) strongly objects.
