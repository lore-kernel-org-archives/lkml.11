Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C1E8C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 13:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbiERNqi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 09:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbiERNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:46:15 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43524178545;
        Wed, 18 May 2022 06:46:14 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id m25so2703243oih.2;
        Wed, 18 May 2022 06:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=8zKhwIJo0gXsAIWGyUaFPT+x1Z1JcWrSNyRipuSmgqs=;
        b=XAYaYQo0XENnCRuTqedzjgHnvmrnMP3qHTiIfD3MQXm9Zw0tPMj7IPP2mSoGz88C4m
         OvyAk9oeNtR0YfisR9SMXbBoUUCrGvRUVhpRVrI4uS+JaiDuy0hEpP7xWKSBj8teY8ah
         PYb+LzdfZ35BZ7eZJuYRrnv1FB57fVTGeMKsyiQclYcZNN2MjMHnm6nIrPXJYv71BTiu
         B6S6h0Z8kK+8MQc11xg+OEDcTG3GzsAdq+CziqaRh3JGAutLuM/NFQqPuxhpnoy0rcTu
         rQ014a4usHBPlDEHawN+CQAq/YZ+CIOWlKTUB8UwM9hm2KzPEHp7Z7GXwLkbDZLqI4WU
         dpCQ==
X-Gm-Message-State: AOAM533BWhFC6xf3l4U/lbVz5nckYD/hp4OuX0q7eCofNGVh9MBho1dq
        QBwRiRIqCiRGWVEK8bwYqw==
X-Google-Smtp-Source: ABdhPJyDA0UeGAJChEEw2/YIUdPOq9UuLN/6prgGz2LmxT7diCMuhTs+SznglSjuWfgpvESbht/lYg==
X-Received: by 2002:a05:6808:1287:b0:326:d23f:f251 with SMTP id a7-20020a056808128700b00326d23ff251mr16746oiw.155.1652881573534;
        Wed, 18 May 2022 06:46:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i3-20020a9d53c3000000b0060603221239sm776619oth.9.2022.05.18.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 06:46:12 -0700 (PDT)
Received: (nullmailer pid 3186179 invoked by uid 1000);
        Wed, 18 May 2022 13:46:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     marijn.suijten@somainline.org, jason-jh.lin@mediatek.com,
        konrad.dybcio@somainline.org, linux-kernel@vger.kernel.org,
        paul.bouchara@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        phone-devel@vger.kernel.org, y.oudjana@protonmail.com,
        chun-jie.chen@mediatek.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, ~postmarketos/upstreaming@lists.sr.ht,
        matthias.bgg@gmail.com, rex-bc.chen@mediatek.com,
        mturquette@baylibre.com, kernel@collabora.com,
        linux-clk@vger.kernel.org, tinghan.shen@mediatek.com,
        sam.shih@mediatek.com, robh+dt@kernel.org, fparent@baylibre.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        miles.chen@mediatek.com, ck.hu@mediatek.com, ikjn@chromium.org,
        wenst@chromium.org, linux-arm-kernel@lists.infradead.org,
        martin.botka@somainline.org, weiyi.lu@mediatek.com,
        bgolaszewski@baylibre.com
In-Reply-To: <20220518111652.223727-5-angelogioacchino.delregno@collabora.com>
References: <20220518111652.223727-1-angelogioacchino.delregno@collabora.com> <20220518111652.223727-5-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 4/7] dt-bindings: clock: mediatek: Add clock driver bindings for MT6795
Date:   Wed, 18 May 2022 08:46:11 -0500
Message-Id: <1652881571.539429.3186178.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 13:16:49 +0200, AngeloGioacchino Del Regno wrote:
> Add the bindings for the clock drivers of the MediaTek Helio X10
> MT6795 SoC.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/clock/mediatek,mt6795-clock.yaml | 66 +++++++++++++++++
>  .../clock/mediatek,mt6795-sys-clock.yaml      | 74 +++++++++++++++++++
>  2 files changed, 140 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.example.dts:35.13-21 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:364: Documentation/devicetree/bindings/clock/mediatek,mt6795-sys-clock.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1401: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

