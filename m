Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA08C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 22:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiGYWY5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiGYWYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:24:55 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8300A25580;
        Mon, 25 Jul 2022 15:24:54 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id l188so3518379oia.4;
        Mon, 25 Jul 2022 15:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4lnMpoZb+qHkuYn7ZnPpjURPzGmFuQzUhlPQ6dAnI2E=;
        b=EOVOdzHI7UGarn/oNbqz0aZNobHLlnCobVGx9AiIgN69kGqRqc4+bPPgVLz746sV0P
         6vjsolQqsxf9HcmngEvmFr19GeuDevuLhJA6VkiV8i9GAYxUdMTopzxmoXAPds2k0ADl
         cvcXKDh4xNc7C0mJxolwl2cRRNqNJA3/+NIgDf4ZBge94vdX1LjVDR0Ubgz5HDFRvaHP
         uZy/aIW1XZO1doN25+tsERnAaxpv67viMUyZ/oRg7Fs1Dgqcps6bENsJBevOEYxS8vtk
         jgna0Tt8nUTxbpxTbPxXPD+vbMAUpN8R36QXCUgOs90E5J5csMWHhJoSkJ9/mAuQmyT1
         2Wdw==
X-Gm-Message-State: AJIora/WoWJVe8GMz+PrzHwe+OvBp47omYyjYaOq+tIvRVLrq2cfVZgL
        Z9vYWwCfIOk2I9oRXv+ExA==
X-Google-Smtp-Source: AGRyM1vAofLtAEFQzPOgCv9X/fCj3FwcSwZCkPVppTY/bmRdoY/U3iOTun0xg2e24/o3pIP7hHNcIg==
X-Received: by 2002:a54:458b:0:b0:33a:74a7:4271 with SMTP id z11-20020a54458b000000b0033a74a74271mr6389250oib.287.1658787893762;
        Mon, 25 Jul 2022 15:24:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l6-20020a05687040c600b0010c5005d427sm6639754oal.33.2022.07.25.15.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:24:53 -0700 (PDT)
Received: (nullmailer pid 2853362 invoked by uid 1000);
        Mon, 25 Jul 2022 22:24:51 -0000
Date:   Mon, 25 Jul 2022 16:24:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Lee Jones <lee.jones@linaro.org>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org, iommu@lists.linux.dev
Subject: Re: [PATCH v3 05/21] dt-bindings: power: mediatek: Update maintainer
 list
Message-ID: <20220725222451.GA2853305-robh@kernel.org>
References: <20220720123023.13500-1-tinghan.shen@mediatek.com>
 <20220720123023.13500-6-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220720123023.13500-6-tinghan.shen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 20:30:07 +0800, Tinghan Shen wrote:
> Update the maintainer list of power controller binding.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../devicetree/bindings/power/mediatek,power-controller.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
