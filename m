Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2AAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 16:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245554AbiEPQDN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbiEPQDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:03:10 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9C131911;
        Mon, 16 May 2022 09:03:09 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so10347513oty.3;
        Mon, 16 May 2022 09:03:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yo1mI8/R7Wy9riO53UED6LxgLrSXbz5A0ENaW2C9bpU=;
        b=MKTtVoGogHMQon9jukIl76qU759lgz29F+LbwS6qCMJlfTFFkXt2mEkIZhEYEQ7fqr
         2dDAnbCHM7gO3aU/Gk/VxrMU6hvQwShmlTvwTiIoFNsZAv2VUMRhA4EM3wsQraE1ZrB4
         UmCL8OJaThKk0+ntnhlnPQ0fBXvqMJMx8CuMlJWhsRkyhXduk2AgP7RNw8L2eUqkPa77
         yOMExsKyToq+GSIAjad3QwxuoAxYtvGxcDbG1BpZMVTxleH4w96rk+M32HQ5qcisSVHB
         3Kpap3HNYYQd8BHhOfGCQ3s89n8xDw5GExLeSsNNCbuXkVSFKRbwiuwF95bxh8wbgR2Z
         SKtA==
X-Gm-Message-State: AOAM530GOd3HvMR83Z5vKrgZlh95FQDDsrN2qSGp/0Gi/RreYKBnzd8a
        XvtDV+5cTu8dA9TCQwboRw==
X-Google-Smtp-Source: ABdhPJyZnvv3MvtJ0BpFTLVD4WxJ+CJ0091/m0FsrkT5PDbPjdHQaNeoSy79FCWg/C3J1d8uUv1Vyg==
X-Received: by 2002:a05:6830:12c9:b0:606:4482:74a0 with SMTP id a9-20020a05683012c900b00606448274a0mr6234159otq.17.1652716989012;
        Mon, 16 May 2022 09:03:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q5-20020a4aa885000000b0035eb4e5a6b6sm4288330oom.12.2022.05.16.09.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:03:08 -0700 (PDT)
Received: (nullmailer pid 2732699 invoked by uid 1000);
        Mon, 16 May 2022 16:03:07 -0000
Date:   Mon, 16 May 2022 11:03:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     martin.botka@somainline.org, linux-mediatek@lists.infradead.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        paul.bouchara@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        will@kernel.org, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com, ~postmarketos/upstreaming@lists.sr.ht,
        joro@8bytes.org, phone-devel@vger.kernel.org,
        devicetree@vger.kernel.org, marijn.suijten@somainline.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: Add bindings for MT6795 M4U
Message-ID: <20220516160307.GA2732645-robh@kernel.org>
References: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
 <20220513151411.395744-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513151411.395744-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 17:14:10 +0200, AngeloGioacchino Del Regno wrote:
> Add bindings for the MediaTek Helio X10 (MT6795) IOMMU/M4U.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |  3 +
>  include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
>  2 files changed, 99 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h
> 

Acked-by: Rob Herring <robh@kernel.org>
