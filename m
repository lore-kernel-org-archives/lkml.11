Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF1DC19F2B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Jul 2022 16:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbiGaQCp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Jul 2022 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiGaQCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:02:43 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F72BE0D;
        Sun, 31 Jul 2022 09:02:42 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id n138so6774686iod.4;
        Sun, 31 Jul 2022 09:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=1cJGXIDlYaNEYUvR2NRGrr9WocwvB3UiAWtCmIk18EA=;
        b=IgL6urhRwztjARTh6xbochk4sEesPkyKAGgU869z69Iig6B/un6oVoA4CH0g9q03sa
         CGcvlaxKQfDP5NyfqgydqnDCyBG1iFaLipamyAZFNH1kuaL4rf7iuzYPVg6UxgJNoBGG
         uLF0MGRYBYklSfDsSgCyPY15jQJKJxDI26HxLg901stb98gYfxTNAIogBu4oWkoxJyev
         GL80YJoZQoSm1NOFUTXQGYOChKM/V5OA0YwDIhUgBIyIUpEBHg8cH4OusGC8cVBtB/Q7
         d0bsen19/B5OY7BZVAQaNBsk+5cQzeqC8IxyACmKjV/Kq7nnZbX+2CeVGICilWNOZeVg
         o8pg==
X-Gm-Message-State: AJIora9rIhhvfNWYZ1+jhFOp1txh8EGi3XdxqIbDjNtap8PNIM5C3ofZ
        svNmIEE7J+0wcvvVXw5xsf66RUZZgw==
X-Google-Smtp-Source: AGRyM1sYNl3f2m8lc+L6zGIH26tQMfzr0kEk09cofcdtvYk92Axw48a86G07BJTzHcMr9cde/FMepg==
X-Received: by 2002:a05:6602:2ccb:b0:67c:3d7c:c896 with SMTP id j11-20020a0566022ccb00b0067c3d7cc896mr4263761iow.153.1659283361719;
        Sun, 31 Jul 2022 09:02:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b71-20020a0295cd000000b00339df77c491sm4265856jai.114.2022.07.31.09.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 09:02:41 -0700 (PDT)
Received: (nullmailer pid 3380583 invoked by uid 1000);
        Sun, 31 Jul 2022 16:02:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ban Tao <fengzheng923@gmail.com>
Cc:     jernej.skrabec@gmail.com, samuel@sholland.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com, linux-sunxi@lists.linux.dev,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        broonie@kernel.org, wens@csie.org
In-Reply-To: <1659271861-3481-1-git-send-email-fengzheng923@gmail.com>
References: <1659271861-3481-1-git-send-email-fengzheng923@gmail.com>
Subject: Re: [PATCH v7 2/2] ASoC: sun50i-dmic: dt-bindings: add DT bindings for DMIC controller
Date:   Sun, 31 Jul 2022 10:02:39 -0600
Message-Id: <1659283359.419677.3380582.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 05:51:01 -0700, Ban Tao wrote:
> DT binding documentation for this new ASoC driver.
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Maxime Ripard <maxime@cerno.tech>
> ---
> v1->v2:
> 1.Fix some build errors.
> 
> v2->v3:
> 1.Fix some build errors.
> 
> v3->v4:
> 1.None.
> 
> v4->v5:
> 1.Add interrupt.
> 2.Keep clock and reset index.
> 
> v5->v6:
> 1.None.
> 
> v6->v7:
> 1.None.
> ---
>  .../bindings/sound/allwinner,sun50i-h6-dmic.yaml   | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/allwinner,sun50i-h6-dmic.yaml:79:4: [error] no new line character at the end of file (new-line-at-end-of-file)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

