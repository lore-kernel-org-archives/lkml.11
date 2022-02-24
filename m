Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A358C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 19:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbiBXTQw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiBXTQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:16:46 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F5622C6C2;
        Thu, 24 Feb 2022 11:16:16 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id q5so4351398oij.6;
        Thu, 24 Feb 2022 11:16:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CIZ8l9ggHI+ksF9ySGra6oc3DHVzkCgMYu8j36TV9TY=;
        b=V1oPulW0uWMcspy/r6BqCt7k8/DIqWeMrZ6i4gF6Di9jeANNXqZW3dMBTEXVChxlET
         sG9WTxKweaP2tbClGbSbDd/gE74s8QdWievEbT01C4jQQmaAb6l8HN5bkeiR4nCb8UVA
         mSvPfRywBZPiu1Pa4GOP5O6jw6zfCMUB9UUoTf3nbHaKrs9it8+BmHTSZFI0pU8j8vvB
         01eXZdvgA1LZ1h1J5eUNDTDAGvmLqAqRuY/r8xp8H0k+HHPia/dgWvUJPIAeWwXCLsIK
         Zr4+ITj65WTjhFLTLlUdAf2xpugKqAtXk0FqkMXQBsyLVgxRrZF1GwdX07L7RYnauNez
         Je+w==
X-Gm-Message-State: AOAM533C8pvp7+kwD6fa8CMIYnPkf5Ji4i7UFsnVuc8jEX6ETR+hdjHv
        izdg+DqNF2y4zmrY0bLIoQ==
X-Google-Smtp-Source: ABdhPJwxUu9mkz92flMo29/vSvMvRas73bEu7/GHucHHjC7qW5h3B9JoZfONOkccBnWTGnjHJiY6/g==
X-Received: by 2002:aca:6083:0:b0:2cb:5570:7564 with SMTP id u125-20020aca6083000000b002cb55707564mr8499482oib.57.1645730175518;
        Thu, 24 Feb 2022 11:16:15 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 9-20020a9d0c09000000b005afabd759cfsm80036otr.65.2022.02.24.11.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:16:14 -0800 (PST)
Received: (nullmailer pid 3428805 invoked by uid 1000);
        Thu, 24 Feb 2022 19:16:13 -0000
Date:   Thu, 24 Feb 2022 13:16:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, p.zabel@pengutronix.de,
        hsinyi@chromium.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        yongqiang.niu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, fparent@baylibre.com, daniel@ffwll.ch,
        airlied@linux.ie, jassisinghbrar@gmail.com, chunkuang.hu@kernel.org
Subject: Re: [PATCH v4,1/5] dt-bindings: arm: mediatek: mmsys: add support
 for MT8186
Message-ID: <YhfZff2KIPdOm53H@robh.at.kernel.org>
References: <20220222052803.3570-1-rex-bc.chen@mediatek.com>
 <20220222052803.3570-2-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222052803.3570-2-rex-bc.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Feb 2022 13:27:59 +0800, Rex-BC Chen wrote:
> Add "mediatek,mt8186-mmsys" to binding document.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
