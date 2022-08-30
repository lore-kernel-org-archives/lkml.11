Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A58ECAAA1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 09:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiH3JYQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbiH3JXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 05:23:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1AA26D4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:23:45 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j14so4334336lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=P3jHDFf6ZF+eC8L7gPkS3nO/hYBt1WKKSDQdwcqbM1g=;
        b=ro7d5377lQTowObZV1r5vVfKkJrhWz3A2GZD1czofP56rGrxWgIkvq/uDSV/wfiX8o
         wC1r5NrB8aG89lxXz7q8/wFkSqWyaLgn0PAM+y9znsmg+f+IeV/ZaHwy7LRLWB/z+Xaz
         RLl2KnYdbjNELU8jqx89db3PTYyKp8j/lzKW1fv+Dk4Jrb3mkSM8ti5AWHwYQRGwXRRU
         HDr1I0GTI8/DTnNIo9A1TZ4XwgHW98XuJZnPYvrAyxbpmD86JtBcg9mBz+aFF6W2cC7w
         lEaPFlms3BH5KoEJ6V2129cwHbHd+kteFPE0ht7gXMGMdDs3MAIG8R0e0jb3oPlEoGrX
         Axtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=P3jHDFf6ZF+eC8L7gPkS3nO/hYBt1WKKSDQdwcqbM1g=;
        b=5Fy7+mSkh/5lOu6t5xfcaNvefTWenjivIFRaLfv4o+D/M93JAHdUEi9i3Cp5Zjs5wv
         dlU+z/amT7shX5mlcb4vuS9FZZokWuVyHWYZqSMZ5Pmr1oLZobB9HB1hZvwwC+zEyQve
         P333/Y+GkPBI/S4JOxcCutDxtidCg9CDWdf/T615dbOFFQ6+dBeYfarNAf+7hKy9J6/F
         NybmHL+shzVfl7jlKroOIBpcoRtcl16ki/JIojg7LmalpMznN1UcCdIMw05xril64oP/
         MTIQywjESvaNG30UJWwkXShm/iaGMMI+YiYKXuoMg42PR3vxZ49gOf/UmdL58cQJXM+m
         NMjQ==
X-Gm-Message-State: ACgBeo3DjrwQOsWpeTx4T6w2b22FfY+YunYMJNJPKMOvjXq2yVM2AEId
        86exjvcOwQMVuQuZVwNm1eNNZA==
X-Google-Smtp-Source: AA6agR6coigoibJ+B2ksKkaYEzr/2jSNslM78cgAgVd2xOmffVB501Xp5K5bVDHQxYg/RB+HGi2ehA==
X-Received: by 2002:a05:6512:32c9:b0:492:f53d:9c1 with SMTP id f9-20020a05651232c900b00492f53d09c1mr7151142lfg.127.1661851424008;
        Tue, 30 Aug 2022 02:23:44 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id c19-20020a056512325300b0048cdf54a44dsm1544581lfr.266.2022.08.30.02.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 02:23:43 -0700 (PDT)
Message-ID: <e455ebd7-7949-47d6-5f9b-9869dfdd601d@linaro.org>
Date:   Tue, 30 Aug 2022 12:23:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: display: bridge: renesas,dw-hdmi: Fix
 'unevaluatedProperties' warnings
Content-Language: en-US
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
References: <20220829215816.6206-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220829215816.6206-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 00:58, Lad Prabhakar wrote:
> With 'unevaluatedProperties' support implemented, there's a number of
> warnings when running dtbs_check:
> 
> arch/arm64/boot/dts/renesas/r8a774b1-hihope-rzg2n-rev2-ex-idk-1110wr.dtb: hdmi@fead0000: Unevaluated properties are not allowed ('resets' was unexpected)
> 	From schema: Documentation/devicetree/bindings/display/bridge/renesas,dw-hdmi.yaml
> 
> The main problem is that SoC DTSI's are including resets property, whereas
> the renesas,dw-hdmi.yaml has 'unevaluatedProperties: false'. So just add
> optional resets property to the binding.

This is not main problem. I already commented on two of your similar
patches, so same applies here. Please describe real problem.

Best regards,
Krzysztof
