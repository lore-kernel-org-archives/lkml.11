Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55607C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 23:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbiCGXJj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 18:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241414AbiCGXJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:09:37 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147239F;
        Mon,  7 Mar 2022 15:08:42 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso19811334oop.13;
        Mon, 07 Mar 2022 15:08:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fkg7oi8ypJp3+djSvTk7y0jfuF9EzsvhVs0LqzzSRMk=;
        b=A72qr8HdPKgkL3qlk4HgGyif0WWBiSHq428vqbvQ7P0S58unMyo3MxJzWlg//fZJ2Z
         Qn1DIrgGxZ2t3k2vXqv/sCJIq/GZRil+YiocWZb52yicHndAMtpiGuDRx0mOnw1yIDAL
         K0h9e5Fn5sbphbUBwZAmK2Ta51NawdDLrbdVhsx2nj09ezEy+8VUVZp8In4jQY8rJyik
         zKVx2z8zHby2jyiQQispwip6JRoRPoqoUj1YgEjV/3PC7P0Qy+4cBVKAKTx7fGwbCRr8
         Pc81uqZlu5qYtKXor3tc77OKpAl3hJT+ppYvtMBKtbVIa6XUUhKX7nLxBDsdCR10JEOS
         W1EQ==
X-Gm-Message-State: AOAM532gEfmyeXs1ayfQy+yqd4cn/CuxvEzlo/qVu54kcKjsYje2Vf2D
        AU2eOqDL5z8kVB4nNx1I7Q==
X-Google-Smtp-Source: ABdhPJxGpHsR4FAyDmAlZgdhkDLM1uLBQdtWFxkHCiAQqC2M/strClCm8Qk47svh8X/NY+FmjRMLfQ==
X-Received: by 2002:a05:6870:e88d:b0:da:6cdf:60f1 with SMTP id q13-20020a056870e88d00b000da6cdf60f1mr728425oan.285.1646694521354;
        Mon, 07 Mar 2022 15:08:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j25-20020a4ad199000000b003171dfeb5bfsm6144226oor.15.2022.03.07.15.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:08:40 -0800 (PST)
Received: (nullmailer pid 3431519 invoked by uid 1000);
        Mon, 07 Mar 2022 23:08:39 -0000
Date:   Mon, 7 Mar 2022 17:08:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        daniel@ffwll.ch, robh+dt@kernel.org, fparent@baylibre.com,
        hsinyi@chromium.org, linux-mediatek@lists.infradead.org,
        jassisinghbrar@gmail.com, linux-arm-kernel@lists.infradead.org,
        p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        yongqiang.niu@mediatek.com, dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        airlied@linux.ie, matthias.bgg@gmail.com
Subject: Re: [RESEND V6 2/5] dt-bindings: display: mediatek: revise enum to
 const
Message-ID: <YiaQdyqSvw0Xz6Pv@robh.at.kernel.org>
References: <20220303065725.23384-1-rex-bc.chen@mediatek.com>
 <20220303065725.23384-3-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303065725.23384-3-rex-bc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Mar 2022 14:57:22 +0800, Rex-BC Chen wrote:
> There won't be more than 1 fallback for these bindings, so we modify
> them to use const instead of enum.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml  | 3 +--
>  .../bindings/display/mediatek/mediatek,ccorr.yaml           | 3 +--
>  .../bindings/display/mediatek/mediatek,color.yaml           | 6 ++----
>  .../bindings/display/mediatek/mediatek,dither.yaml          | 3 +--
>  .../bindings/display/mediatek/mediatek,gamma.yaml           | 3 +--
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml  | 6 ++----
>  .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml | 6 ++----
>  7 files changed, 10 insertions(+), 20 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
