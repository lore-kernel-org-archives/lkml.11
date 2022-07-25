Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8322DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 23:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237441AbiGYXd5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 19:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiGYXdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:33:54 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D6B26AF9;
        Mon, 25 Jul 2022 16:33:53 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-10d83692d5aso16791628fac.1;
        Mon, 25 Jul 2022 16:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KkLhNlQIA442mAFMLRl9TvrN+jhf4sjCHKPfdWKMsyc=;
        b=gvsheoexsdtxOGlc1Ukh/YyiZuC3J97y4sXZ9n1EyEGAZMLHSo5uzWFujW0WF9uL/K
         etK+7Dhtj9Bn/7TaYbgu9KE7VgpZgl5zimotzrw7t42Q3CiHqSKTWDRhcVI/aDrKuW6n
         aCcccBTufQHOsV43zvjxmc0I8IifXQ+UDXJWefLrl+pnHbi7uOIYH1VX31MWub43/Y9m
         /ZpfXmjOOaJgP5QnRw+z8YZ8fm1d7ieK/4TdXctGdikH1gydqQJH5D/oKVttvhlJ7Uof
         M0+d0RvO+Ch9l5i26cpZdTPT7wD9IG819hnv8v4Pxb62yqvAbeyN5kEQGX/WLNUACXrI
         SSww==
X-Gm-Message-State: AJIora9he9VEIGWWZtUf7L1PwEE1WCZraSf8Dkf7eqLPnq4YDL0wksDf
        cf6ke8Xrazg2KlaEOo48mw==
X-Google-Smtp-Source: AGRyM1vDjAj9b/AAZtMINpd77bbnwU7eigj7GQ3astAXeGxYeIqiKr+TDVJ3DvFn+JGhsHSlVWYQUQ==
X-Received: by 2002:a05:6870:61cc:b0:10d:8a9e:4ebc with SMTP id b12-20020a05687061cc00b0010d8a9e4ebcmr14270694oah.155.1658792032961;
        Mon, 25 Jul 2022 16:33:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b8-20020a056830310800b0061ca5495cc2sm5553067ots.30.2022.07.25.16.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 16:33:52 -0700 (PDT)
Received: (nullmailer pid 2965916 invoked by uid 1000);
        Mon, 25 Jul 2022 23:33:50 -0000
Date:   Mon, 25 Jul 2022 17:33:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        angelogioacchino.delregno@collabora.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: pinctrl: mt8186: Add and use
 drive-strength-microamp
Message-ID: <20220725233350.GA2965857-robh@kernel.org>
References: <20220725110702.11362-1-allen-kh.cheng@mediatek.com>
 <20220725110702.11362-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725110702.11362-3-allen-kh.cheng@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2022 19:07:02 +0800, Allen-KH Cheng wrote:
> Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
> PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
> drive-strength-microamp instead of mediatek,drive-strength-adv.
> 
> Similarly to the mt8192 and mt8195, there's no user of property
> 'mediatek,drive-strength-adv', hence removing it is safe.
> 
> Fixes: 338e953f1bd1 ("dt-bindings: pinctrl: mt8186: add pinctrl file and binding document")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/pinctrl/pinctrl-mt8186.yaml      | 29 ++-----------------
>  1 file changed, 3 insertions(+), 26 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
