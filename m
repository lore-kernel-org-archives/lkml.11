Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961DEECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 19:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH2TCu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 15:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2TCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:02:48 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA7B52E68
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:02:46 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id x5so6886786qtv.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 12:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=pIxGeluzGYEKzBZac878nAVYb/MGQD02kaqzGhI5soE=;
        b=grYLPBfbpBFgKFqkSlWko72q8lwjufsjsE/1/jVNSz8M51ZLimPU4INaXeTpCGwbqu
         fpARIQTikb4m+fTiEvbEdTOUsCbm87y6kmK0y/IzPpe+uumC/F4xqZdfNn2rlMbsyY/j
         2ZgKYd/EfMOVNwJaLRlFuQfRnSWEgfHVdHM7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=pIxGeluzGYEKzBZac878nAVYb/MGQD02kaqzGhI5soE=;
        b=RhqpTy8J2ZcrWSI6j4b0AzJgdGVDuI3x30udhU4yEP2xDe7/IGXWkCL71wOY0BiWlR
         pcKq9SzV0inuhE/UORj7JO+tbeg2HbRAr8JTUVopVT1yzoJUCYsjtaX5NafGB5WCBr/j
         IVffGNP3Rm5iUQeBK8ieJ9l6mDq3IhAlvuuu4YGucB2jEvZQmcDjo7Mz7fh0o8WymbBq
         MYTAilnLPKMvG4B8i5gabQUfnATluhYGCNcjYNVUizImPaXrcuf5STrmqzfy31PW+fJ7
         QkYy/clGgfKT12PhW+BXRHwbA2AgEg3r++/DN+bxMPXfHKx0o3gGIV57Lyg5BLDCbYx+
         ArKg==
X-Gm-Message-State: ACgBeo0nn12hX3K2shuP5Xeb/dYhS/Wp1cu3Cj8x4p5V9v6FUXJ2lZsx
        trcNfwGNbGYw2T8dXqbmmrzShA==
X-Google-Smtp-Source: AA6agR7cohvIoKMHY1SJ+uPe6QOIMSrdGY61QE9x43N6PZX9CYY3REZteRsH6f6P7prXXMGQNDmESg==
X-Received: by 2002:a05:622a:14cd:b0:344:6cfa:42f9 with SMTP id u13-20020a05622a14cd00b003446cfa42f9mr11639737qtx.147.1661799765067;
        Mon, 29 Aug 2022 12:02:45 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id t17-20020ac86a11000000b0031f287f58b4sm5405223qtr.51.2022.08.29.12.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:02:44 -0700 (PDT)
Date:   Mon, 29 Aug 2022 15:02:42 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lyude Paul <lyude@redhat.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Karol Herbst <kherbst@redhat.com>,
        Emma Anholt <emma@anholt.net>, Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        intel-gfx@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        dri-devel@lists.freedesktop.org, Dom Cobley <dom@raspberrypi.com>,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        linux-sunxi@lists.linux.dev,
        Mateusz Kwiatkowski <kfyatek+publicgit@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 01/41] drm/tests: Order Kunit tests in Makefile
Message-ID: <20220829190242.tk2hinttzzmzhnaj@meerkat.local>
References: <20220728-rpi-analog-tv-properties-v2-0-459522d653a7@cerno.tech>
 <20220728-rpi-analog-tv-properties-v2-1-459522d653a7@cerno.tech>
 <f6289e5d-98e3-1a0d-f514-136e2b7978c1@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6289e5d-98e3-1a0d-f514-136e2b7978c1@tronnes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:46:42PM +0200, Noralf Trønnes wrote:
> Something has gone wrong with this patchset, there are double line endings.

I noticed this, too, and I think the reason is because these patches were
generated with "b4 send -o", but actually sent using git-send-email. It's not
a use-case I've considered (or tested) and the breakage is because when b4
generates patches with "-o", they are written with CRLF line endings, which is
not something git-send-email expects.

Maxime, any reason you went this direction instead of just letting b4 send
these patches directly?

-K
