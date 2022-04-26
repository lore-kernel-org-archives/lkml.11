Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CC2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 18:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352661AbiDZSvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 14:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346077AbiDZSvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:51:22 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D22589CC0;
        Tue, 26 Apr 2022 11:48:14 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-e922e68b0fso9242943fac.1;
        Tue, 26 Apr 2022 11:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ttz5iN0TvNdjWEd4hEUb+jVX0qC+pWXJcgQnjnfIYWw=;
        b=YSTDuiS93rN9ZJGiwN/s0Jdi0P5DpTFQh69DWvdpf88W6Ykx29gx6F/0ETy354E4u3
         y2iLhMWR2gvHMb/pPfx5OSaKydatzPjkN7MI4yWkdOUnzIR/7PyDGblKda+qrcY83HU2
         qmf7xKIR6f7kkhu2xWHkGXFz5V85Wb/MJcxNjHqsN70N3OXDZOhfFHeGUzWimSFHRZVO
         95bTAjZeX7m8QSrNeZ7bJE+kxtAI7AD5K+Yn+3973RKhbHXg1wBbNWHxM3N21VsVcfGL
         SEANWjWlybrbck12UtiD9w0PDEjQ2hWmjvdvIglUi3nUxS8Irnc5sPh+GEXK7ya+oemT
         u5hw==
X-Gm-Message-State: AOAM532CMalelwAb5k+i6KR15Aq0clkFOP/5P+6p+75McsRFfApL06s3
        AKllDLASR7QvLTztxAEH3w==
X-Google-Smtp-Source: ABdhPJypHAPkwkyLPzMGSjlzD5vSYoYbqKCnWoCG0SmPVI7ccWto1ocJxBrpGkYFYFA5bRk8hXvL7w==
X-Received: by 2002:a05:6870:c5aa:b0:e5:8e03:d40f with SMTP id ba42-20020a056870c5aa00b000e58e03d40fmr10251405oab.264.1650998893902;
        Tue, 26 Apr 2022 11:48:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e18-20020a9d7312000000b006054dfa7eb6sm5128438otk.78.2022.04.26.11.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:48:13 -0700 (PDT)
Received: (nullmailer pid 2340564 invoked by uid 1000);
        Tue, 26 Apr 2022 18:48:12 -0000
Date:   Tue, 26 Apr 2022 13:48:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     linux-clk@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: arm: mediatek: infracfg: Convert to
 DT schema
Message-ID: <Ymg+bOwe3g2ngUHq@robh.at.kernel.org>
References: <20220424084647.76577-1-y.oudjana@protonmail.com>
 <20220424084647.76577-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220424084647.76577-4-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 12:46:47 +0400, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Convert infracfg bindings to DT schema format. Not all drivers
> currently implement resets, so #reset-cells is made a required
> property only for those that do. Using power-controller in the
> example node name makes #power-domain-cells required causing
> a dt_binding_check error. To solve this, the node is renamed to
> syscon@10001000.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../arm/mediatek/mediatek,infracfg.txt        | 42 ----------
>  .../arm/mediatek/mediatek,infracfg.yaml       | 81 +++++++++++++++++++
>  2 files changed, 81 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
> 

Applied, thanks!
