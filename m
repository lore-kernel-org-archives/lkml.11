Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9FEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 15:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbiEKPRk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbiEKPRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 11:17:36 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0CB20EE07;
        Wed, 11 May 2022 08:17:35 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id v66so3090786oib.3;
        Wed, 11 May 2022 08:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dpNz+LwyfT9jjhoJa/sP1irt+XTKs3LHfBiFKQv6gts=;
        b=iA1vUxtw7h/s60TLDCevXxswTFo+jiikB3YFh9+5Z0AkGX/xggRv0Tdp+AVd8ONw54
         eT62j2wV4vFieBqUJkSRTdCb6rHpmKoUnOyE58ULSZYlh7exLbMotDpgxel/y+3ivAyN
         0Cztn4EaEUykfRJMHoDpYDgrjoUoXt9Dkl5nHL+acXj2J7ZNRAnlqH5mNEDofvlrKvjZ
         AB8bB7w8kcw7sqlL182a0P4Wtj3jjRVJ4KMjKrukDomNd0jchiCkZbSO/KzEVVOvL1u2
         aHn3rvbYMaLzsZi+rwdaQPe792F0TYCllsqWt9Ik8wKJgpJnRVtCS5WmAlp6b5LgvgLD
         x7MA==
X-Gm-Message-State: AOAM530a81pthimlD4nPLuCgz42faAslz/oVQuGStcBQ0rlgv2Ou6lwl
        OvGjBMgdDZd9+QeQbY1sH4EaIxqJag==
X-Google-Smtp-Source: ABdhPJySwMiBeMQ6yXtbQUnyyCcnwB1XuD7UhAgD6UU+usUZdQxvCqjQ7Xgz3SrtyJhV1lmc8zq67Q==
X-Received: by 2002:a05:6808:1b07:b0:328:ab46:623f with SMTP id bx7-20020a0568081b0700b00328ab46623fmr2629768oib.152.1652282254672;
        Wed, 11 May 2022 08:17:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q3-20020aca4303000000b00325cda1ff8fsm840345oia.14.2022.05.11.08.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 08:17:34 -0700 (PDT)
Received: (nullmailer pid 329835 invoked by uid 1000);
        Wed, 11 May 2022 15:17:33 -0000
Date:   Wed, 11 May 2022 10:17:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Subject: Re: [PATCH v4] dt-bindings: nvmem: convert mtk-efuse.txt to YAML
 schema
Message-ID: <20220511151733.GA313710-robh@kernel.org>
References: <20220509014521.10248-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509014521.10248-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:45:21AM +0800, Chunfeng Yun wrote:
> Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4: fix duplicated unit-address in example;
>     drop reviewed-by Rob, due to changes;
> 
> v3: add reviewed-by Rob
> 
> v2:
>    1. remove description of subnodes which is covered by nvmem.yaml suggested by Rob
>    2. change the example which is commoner than mt8173's

I'm assuming this will be resent with all the changes from the other 
conversion posted[1].

Rob

[1] https://lore.kernel.org/all/73b1feab3ecb20fef0339b322a61d63146b5790a.camel@mediatek.com/
