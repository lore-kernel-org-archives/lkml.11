Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66350C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 16:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiEJQTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 12:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiEJQTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:19:35 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30281270CBD;
        Tue, 10 May 2022 09:15:38 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-ee1e7362caso14748853fac.10;
        Tue, 10 May 2022 09:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=n14QA1P7oePz3evcHmzcIhg/DgJOsOv+Y1omuVu5O5E=;
        b=0F6xzxz5Z6jgFTgao/GE5lNOY/kGzqklG0Y8rWyr1TmcyHB215JGWQiPVlYZ/cVrDD
         iarAUSbB/FU1otkTZdSNAbpomwIv9Xu4Dmakk6+Q3acfMkZYUCRwCefCuynJDwzr0BMH
         X7PuhRJXWJOucRyc3PXCa0LgtwXQOWyVIdkfEr29ScuJehADFN4Vclz2zjSEjKIe93If
         AL88nWIl9IDF6M5YgVtzTkVpI/f9u7ZxO9Zll6OuYnQlZ96l2gr1m4EBhwYcYUCy1rMB
         noBHIs8VbdULAd/8qH7/g8+wQjWrPoYeFbXkz+kGa5PFiVfoZW7Q1Ry06ygS/g64CNxY
         i73g==
X-Gm-Message-State: AOAM532WfvqQGSGTLj8jVP4pm5oaXr1CHeeYuLCrMp3aNzAFt30Ei8p8
        rnnZryCegL7HKBguneZJtw==
X-Google-Smtp-Source: ABdhPJxNS+UjPDxklWYP51TqZo2548RbxbsF6xlX21sdxq74zE7u6VaG+tkilA/diznI1DPUxmaTTA==
X-Received: by 2002:a05:6870:898f:b0:e2:c13a:44d9 with SMTP id f15-20020a056870898f00b000e2c13a44d9mr469850oaq.170.1652199337418;
        Tue, 10 May 2022 09:15:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r11-20020a9d7ccb000000b005b2353c5f4fsm5926580otn.0.2022.05.10.09.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:15:36 -0700 (PDT)
Received: (nullmailer pid 2122351 invoked by uid 1000);
        Tue, 10 May 2022 16:15:35 -0000
Date:   Tue, 10 May 2022 11:15:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Luca Weiss <luca@z3ntu.xyz>,
        Maxim Kutnij <gtk3@inbox.ru>, linux-kernel@vger.kernel.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: Re: [PATCH v2 01/16] dt-bindings: arm64: dts: mediatek: Add
 mt8192-asurada-spherion
Message-ID: <YnqPp6KbZpSdvCN5@robh.at.kernel.org>
References: <20220505194550.3094656-1-nfraprado@collabora.com>
 <20220505194550.3094656-2-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220505194550.3094656-2-nfraprado@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 May 2022 15:45:35 -0400, Nícolas F. R. A. Prado wrote:
> Add binding for the Google Spherion board, which is used for Acer
> Chromebook 514 (CB514-2H).
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Added this patch
> 
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
