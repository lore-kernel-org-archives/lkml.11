Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9ED9CCA47B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 13:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240772AbiFHNpm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 09:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbiFHNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:45:20 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E727147C;
        Wed,  8 Jun 2022 06:45:18 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id a10so18837505ioe.9;
        Wed, 08 Jun 2022 06:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=W8KqLdaB/w/YGRDGH2n8sRCUDF1uSkNdTgkHzNsZwJc=;
        b=PRvtrznCHDjBBYawS1y7nMdXGBMUaoigWEfLHuPLtrvTGBb4NCWctykMiPIM0+5Upt
         Tc/6sTjwf6+7cyur536c2CLemZwIYcOeT5J2MlNGAsute1b3NmkaiWd0L6JE7i//N8cZ
         2yWsWN1nGkVDD42cjmA18xK6MXVSevHqbUGEeky4L2Cz0dMVnWzXaylg/isstXKG0QCo
         HuMjp3JeW4ke3tz2N8LXx0GIDLsOXwdlYm3enTBjwuJHIaI31XXJk63yxNaUQ4qyRhVv
         e2jTLTvjzDkpxhL/xdJa7Yl6YghOFR/kwxYjZcn3ckIe3LDriO8+xAiHDoG5sqZa/hUl
         uRZA==
X-Gm-Message-State: AOAM531cryscuTupYhPWc7ULaIUUPX6H1BGEt2S0lPKmiOyD04Fd4B1e
        xThm0sIdHy8ttSBI2b0EZw==
X-Google-Smtp-Source: ABdhPJx5s0ccjVbdJZaMMM/QC0HXDyokEKnHKgCKaaXwNUwaytQlXG9SpY/n8lgwAAdFIB6/yFyxcQ==
X-Received: by 2002:a02:8609:0:b0:330:e92c:2cc4 with SMTP id e9-20020a028609000000b00330e92c2cc4mr19375084jai.95.1654695917923;
        Wed, 08 Jun 2022 06:45:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id cx4-20020a056638490400b0033126faae3asm8080774jab.116.2022.06.08.06.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 06:45:17 -0700 (PDT)
Received: (nullmailer pid 1272086 invoked by uid 1000);
        Wed, 08 Jun 2022 13:45:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, nancy.lin@mediatek.com,
        devicetree@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        airlied@linux.ie,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org, p.zabel@pengutronix.de,
        linux-mediatek@lists.infradead.org, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com
In-Reply-To: <20220608043852.4980-4-rex-bc.chen@mediatek.com>
References: <20220608043852.4980-1-rex-bc.chen@mediatek.com> <20220608043852.4980-4-rex-bc.chen@mediatek.com>
Subject: Re: [RESEND v5 3/3] dt-bindings: mediatek: add ethdr definition for mt8195
Date:   Wed, 08 Jun 2022 07:45:07 -0600
Message-Id: <1654695907.376302.1272085.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jun 2022 12:38:52 +0800, Bo-Chen Chen wrote:
> From: "Nancy.Lin" <nancy.lin@mediatek.com>
> 
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,ethdr.yaml      | 188 ++++++++++++++++++
>  1 file changed, 188 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.example.dts:71.40-41 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

