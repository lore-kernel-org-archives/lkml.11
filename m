Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBFCC433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 16:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244110AbiCGQVP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiCGQVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:21:12 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429754C414
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 08:20:18 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id p8so14281110pfh.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 08:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=+wV1FY8U0FWB4VAPUiegJjEIq4RD3FNiqaa9wr6HZiU=;
        b=HHxBwJWvb+zcfYI6s9N+7pQZWwRNUv3GxQ6D78pso72TORyjd7Eoi7G9ZoGfaTtuvT
         +YGxjcgJNHZWubIdOEwRzBEmMlMeCxU6xnn1f9XqzuOOKCKZEE3tpPK3j+ID10hUCguZ
         mHOATnIR8CkGYTCe6H27Px6VUPMR5+JMrlpyHxw6vMj1MNjuazGNc5Y0F/PmAqBvVlTI
         Kv4UnmBTAxOAH+YXealbXzJMmAmoTZKL+68os0S0/EPJle5tuR0W5FsA7Nfgcc2pexey
         IDSK+9jDYCZdtn5MbsEssOwC2ebqPhbqCYaGzp158jtWQVu2VuUfq++MJyoHi2rzXy3d
         zzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=+wV1FY8U0FWB4VAPUiegJjEIq4RD3FNiqaa9wr6HZiU=;
        b=dXicTlr/Dc+GRS2xcostFTaheiQvIsQa9uIJiMMhwG7mxY2CYNXYKmj7oO7/ebixa2
         Yn3QPKFj0on7Bv/q1Ft1HvL+85kKBM8/S9axiygAnan07ejIQ94NOvrRbm9gAnFAzx3x
         WdaPIFeWAVnOUE94mqMixxfdss6cH/h9zzahi1earf1atlAmxYx+hyfr+TpECmnrJ2ap
         ahHaU0MtLHnxPxqD+0cxJQI54uFudL1ZqRV9x17RRNPcn3jguliIvKpOIKrwunBBRgDU
         fGb32GrOiOQFgpunrY6pt9DnTiGL7DUHLLxiVMxgvaab9fKu13rGRbRY7B+/4Iq2UHsC
         w52Q==
X-Gm-Message-State: AOAM532nRB0jjtQTXhNqjA2mZiQXVqBYjNr/SpUSWmRIfzX+wZ3Eq4it
        pJsY6ujGG1kzGVc6cNIlQJalhAXwm6Z1yKNbOE98rg==
X-Google-Smtp-Source: ABdhPJx/V3uLVWBI8/E8KCOJyzUgUR2RjgCZBR6Hgu1VcR0R4QgDq/3T8EiSucOBT+/CPouLZFgIw7Ts/R5qlhZ+a60=
X-Received: by 2002:a05:6a00:24c5:b0:4d1:65bf:1fe0 with SMTP id
 d5-20020a056a0024c500b004d165bf1fe0mr13441313pfv.0.1646670017759; Mon, 07 Mar
 2022 08:20:17 -0800 (PST)
MIME-Version: 1.0
References: <20220307154558.2505734-1-robert.foss@linaro.org> <20220307154558.2505734-3-robert.foss@linaro.org>
In-Reply-To: <20220307154558.2505734-3-robert.foss@linaro.org>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 7 Mar 2022 17:20:06 +0100
Message-ID: <CAG3jFytGV3NNfkEPqx_rZX9O9aZjTjzo2tpeSK8mFimOrYt9zw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] Revert "arm64: dts: mt8183: jacuzzi: Fix bus
 properties in anx's DSI endpoint"
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        matthias.bgg@gmail.com, robert.foss@linaro.org,
        xji@analogixsemi.com, hsinyi@chromium.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Robert Foss <robert.foss@linaro.org>

On Mon, 7 Mar 2022 at 16:46, Robert Foss <robert.foss@linaro.org> wrote:
>
> This reverts commit 32568ae37596b529628ac09b875f4874e614f63f.
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> index e8f133dc96b95..8f7bf33f607da 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi.dtsi
> @@ -171,8 +171,6 @@ port@0 {
>
>                         anx7625_in: endpoint {
>                                 remote-endpoint = <&dsi_out>;
> -                               bus-type = <5>;
> -                               data-lanes = <0 1 2 3>;
>                         };
>                 };
>
> --
> 2.32.0
>
