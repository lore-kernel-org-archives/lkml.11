Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE60EC4332F
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 15:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345589AbiEaPSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 11:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344803AbiEaPSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 11:18:08 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4463D633B2;
        Tue, 31 May 2022 08:18:07 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-e5e433d66dso18768924fac.5;
        Tue, 31 May 2022 08:18:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hw6HT0YhpU0Nzy8vat+zVfd+GtraoN/T8IMTFBgNYMw=;
        b=tfpoIRS1tMPtFNgOICSK7AYhNogSMAX3agLq5ALRg2t6691S2BkybUiLpqGv9CoCBQ
         NQ63ZUSj+Q8GkI5hAqca1Tgsl1463g78wDsGiOkvw7CZAM523LAM6X06DLztlUmBHXcz
         Q7jE9MfI/Tk/B/HZkXQJk6dwOXlg/H2iSXYfVm07iE9XqiD94jaqcTfjYt28eZWllvDE
         q6C9d4wW5AjkxkPZInEktBPw+QNCrV6b/aRldihBn4+NvCrRU/Kh8xuFMhBR4kvvGUzP
         2MVsI/A2icmInI1ZCVUtmD5mxwP7D/A23wmmqGqmH+1l752WQ2mL5cEx74pKRPDzh/lh
         4KKg==
X-Gm-Message-State: AOAM532YFK3Va58YsfA07XqwG7UQIAbaBPE7LRJDTLEdru8onxaP+qaD
        +5pQsXnzG9x7L0C2EBM16fY8q4X85Q==
X-Google-Smtp-Source: ABdhPJw6/muc28+MxomD6dKLajsUp3//40HWkOp4KAueSb0Cb/n2QUlgd7og+IQhsYKbhLoeM4vkrQ==
X-Received: by 2002:a05:6870:c583:b0:f2:e92f:e1c4 with SMTP id ba3-20020a056870c58300b000f2e92fe1c4mr11835783oab.48.1654010286550;
        Tue, 31 May 2022 08:18:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id la13-20020a056871410d00b000f33f8b7603sm2518321oab.17.2022.05.31.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 08:18:06 -0700 (PDT)
Received: (nullmailer pid 1781709 invoked by uid 1000);
        Tue, 31 May 2022 15:18:05 -0000
Date:   Tue, 31 May 2022 10:18:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: snps,dwc3: Add missing 'dma-coherent'
 property
Message-ID: <20220531151805.GD1742958-robh@kernel.org>
References: <20220526014118.2872057-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526014118.2872057-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 08:41:18PM -0500, Rob Herring wrote:
> The 'unevaluatedProperties' schema checks is not fully working and doesn't
> catch some cases where there's a $ref to another schema. A fix is pending,
> but results in new warnings in examples.
> 
> Some DWC3 implementations such as Xilinx are hooked up coherently and need
> to set the 'dma-coherent' property.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.
