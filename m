Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC29C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 20:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiBIU6K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 15:58:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiBIU6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:58:08 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3415DC03FEEE;
        Wed,  9 Feb 2022 12:58:11 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id r27so3833609oiw.4;
        Wed, 09 Feb 2022 12:58:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yJbJ1YJncw7GR81NBwWGi/0xmX4tLs/aU6JSWmE8Y50=;
        b=jBgYKQvnBDunC3BAQ4ta+9Zp52xhsQFbcDDXTMJjqMT6WLNyBOu7uqxV4h1g8im1yC
         8wjBQJXQheZUmF/FiYwKFqpkrAkqqdbv+C4aPtNAXpQuYy8uwJEoBndhEG6z8WMh34eW
         pO8TdhXIalixQBIq6roWt7ZatPRIgm9Bp+VVPIqlB0pf0zQrIahx+8IAtc1BzcYny/Ei
         gI9Y/hZYWJiwhAT99PmLaleEg1+9Gl632mpm9TwiGui7I1SHG+ejDeMrThXcm/4EDxXW
         VMkb7dl9ntBeHELWBp1Gl5sluUswhl+uhrO8fRm8/z0ya9vnvnsMS98dSRSltu1sAvtW
         B6cw==
X-Gm-Message-State: AOAM531mZT/7gyLa6vnjS4HnW3wj2n5ngliRiGPCqryKDWkNOIuJKb//
        UdhyxMi+6wFedqcgmTgA4g==
X-Google-Smtp-Source: ABdhPJy4whN1YYgUQxomCEjxG6vJxuxOYFro1PwIbxbRZKFts+Ytkv8xvy29NkqgrVlSMEwIWA1KFQ==
X-Received: by 2002:aca:1001:: with SMTP id 1mr1865078oiq.82.1644440290551;
        Wed, 09 Feb 2022 12:58:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 4sm7390761oon.21.2022.02.09.12.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:58:09 -0800 (PST)
Received: (nullmailer pid 897131 invoked by uid 1000);
        Wed, 09 Feb 2022 20:58:09 -0000
Date:   Wed, 9 Feb 2022 14:58:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Jonathan Bakker <xc-racer2@live.ca>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/6] ASoC: dt-bindings: samsung,aries-wm8994: require
 sound-dai property
Message-ID: <YgQq4fFnNUU/NL1z@robh.at.kernel.org>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
 <20220129122357.45545-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129122357.45545-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 13:23:52 +0100, Krzysztof Kozlowski wrote:
> The cpu and codec nodes must provide sound-dai property.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/sound/samsung,aries-wm8994.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
