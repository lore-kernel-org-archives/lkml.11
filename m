Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59102C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 22:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353894AbiETWUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 18:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350459AbiETWUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 18:20:14 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3144D1A074A;
        Fri, 20 May 2022 15:20:14 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-f1d2ea701dso11814110fac.10;
        Fri, 20 May 2022 15:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M8rmRCmN4GlSEfCUYx10TspLN6s4IxFkT9OjnFWex24=;
        b=5boocA2mCB1cSq1Fpmx9VxwwIe0xnvR80yV98UyDcw8D6bVl+pP5yAmk6txNKEBTBW
         SYRE2gUnRmgpiAC5l/EnKY3wHrbx+5VM0vzLCFta21rde2i1XcPbHRqxUfbGVZDT+qQy
         AEk3dEhqTp2Psvrloq0J7i9G3CTcPIhmL2yAMa7Sp3drCa9zN6+aG6TCjTa7yfmaIyxY
         JU+9V73mbM9DryGDpdbcMENxAZR8tEMQq4Wg9yCDzlVquRKxz9b7+KRjqgVqW8mEwhrF
         DkN/StQ8gozPRhcXekhAcf1zDDIdxsPlgXK5VTkz5gGDMyKCSRPtKRzQ4sii5zIoRrKQ
         9BGQ==
X-Gm-Message-State: AOAM531AQC23YhyhA1WU+0Y4W0svQVDNM/PMrXof9r/yXlPuMoRk1UMt
        gHXuCDdVmPwjTrODbMZkcQ==
X-Google-Smtp-Source: ABdhPJwJjQIXPU0/UMu0hOETcS+SXwtTymvjCnqffWHXLumHewxkv7m+SwigscCX2nOUGYR5V10jnQ==
X-Received: by 2002:a05:6870:d109:b0:f1:ab23:9e with SMTP id e9-20020a056870d10900b000f1ab23009emr7621547oac.187.1653085213482;
        Fri, 20 May 2022 15:20:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 184-20020aca05c1000000b0032698578409sm1572229oif.38.2022.05.20.15.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 15:20:12 -0700 (PDT)
Received: (nullmailer pid 354579 invoked by uid 1000);
        Fri, 20 May 2022 22:20:11 -0000
Date:   Fri, 20 May 2022 17:20:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     konrad.dybcio@somainline.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, will@kernel.org,
        joro@8bytes.org, linux-mediatek@lists.infradead.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, yong.wu@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, paul.bouchara@somainline.org,
        matthias.bgg@gmail.com, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mediatek: Add bindings for MT6795 M4U
Message-ID: <20220520222011.GA354543-robh@kernel.org>
References: <20220518101849.46804-1-angelogioacchino.delregno@collabora.com>
 <20220518101849.46804-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518101849.46804-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 12:18:48 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  4 +
>  include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
>  2 files changed, 100 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h
> 

Acked-by: Rob Herring <robh@kernel.org>
