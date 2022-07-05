Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7436EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 20:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiGEUax (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 16:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiGEUar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:30:47 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641EC1C903;
        Tue,  5 Jul 2022 13:30:37 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id y18so12240539iof.2;
        Tue, 05 Jul 2022 13:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CxSIBZ2jt/pLFazAIwW59noEAO34Ns2wBgEVpI7Mfqw=;
        b=HgIR/lvtmkxeW4CmThwtaOjDMUzdVFYIKwBz048XsrzAFoPIE3nuO6gOKzu91KDywH
         zWxvSIML/jPZIrJGjnGGVCr/QMmSF/RtN5afMJDWeBOekUjyDPTHRrJHhVTmkdC06KWL
         LAjUJErHjElUi/VJIs6fv+4PCCfkipKsZhclEIscuDcjImSM2owRgm6x4ObsUkjBypWA
         gBUU7iUD6ZWWKUMLdpPmRF83eV/AHcC5FqrM6r+a9oMfBaDFEyZ+75GibbMDBSntFHr9
         9pt3ryIvrhUYgO5aCRAR4+aIDXsZQKViLbTvStD+OTNY5DpqqiD7+2p3DSGY7qLmVL7B
         lKoA==
X-Gm-Message-State: AJIora9heaNwHSNPfeh+7tK0o3FD/H9K5C0YF0V/7a+CNb8XTT+G8cmb
        44Kutl0Lqw7hBQuR/Aey/w==
X-Google-Smtp-Source: AGRyM1sE+zZ5ACiYVTRNPKT1VCnFOrF8wpzg7YmCt1PaLASTZMzUxCyInyFvTe6hDgajT/k+H4YxSg==
X-Received: by 2002:a05:6638:22d3:b0:33c:a25e:e3ca with SMTP id j19-20020a05663822d300b0033ca25ee3camr22616206jat.191.1657053037104;
        Tue, 05 Jul 2022 13:30:37 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m7-20020a0566022e8700b0067885c5fd94sm3051749iow.29.2022.07.05.13.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 13:30:36 -0700 (PDT)
Received: (nullmailer pid 2573162 invoked by uid 1000);
        Tue, 05 Jul 2022 20:30:34 -0000
Date:   Tue, 5 Jul 2022 14:30:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] dt-bindings: usb: generic-ohci: Add Allwinner D1
 compatible
Message-ID: <20220705203034.GA2573110-robh@kernel.org>
References: <20220702195249.54160-1-samuel@sholland.org>
 <20220702195249.54160-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702195249.54160-4-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Jul 2022 14:52:49 -0500, Samuel Holland wrote:
> The Allwinner D1 contains USB controllers which claim to be compatible
> with the OHCI specification version 1.0a.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
