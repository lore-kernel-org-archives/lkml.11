Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89873C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 23:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbiC2X2Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 19:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240294AbiC2X2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:28:11 -0400
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3C5186F8F;
        Tue, 29 Mar 2022 16:26:28 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-df02f7e2c9so7973021fac.10;
        Tue, 29 Mar 2022 16:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9dQ+bezz/6dhDDZZP1dvguzSfUxAuO4wbhe6dLzF9cw=;
        b=bMo/E9KL9htpUy56+2NZ84p5hPuzYkYRlIfIX3H0j3ivgANglXLq+0fSDrWF/2aG2N
         XOLkf91zr2skFyoBI6Wmq+zzB2ZSmmYS/gF66T6QqZ1wPUGRjLjO0wlKRStXY1Q2DD8J
         oz2ipbb1ZDIiePTcpSRstCkhJENVqC0nSi+A4REm3w11ebX2IkL4aqeWWV/BRTGCmUVi
         Bu96g7AZFvzxYwVYkPMIYSeSqEWSSc5vM63QLLDs0qwkFFHUw6rhd0VMlNuyVE8bRunK
         5uqH5phXZvxru8eGtpPQbEkFBL5j1eiUCViCCIiQtf3A8OAHtisAUenLnSuiN8qFS0qb
         +LaQ==
X-Gm-Message-State: AOAM531UdmyUMcj7o0UgO8u0SPDpwwJau7FKKqaIielF+Bs7g9jUniSb
        1p2K0wh7XCiz3KdzhYc+zQ==
X-Google-Smtp-Source: ABdhPJweG2i2gLummAi4XhOWKR3K5fxDVcfWf9ib6emSjAUJsc9ZLfSK4XVKqDUx/MKj6Sxdr8q6uQ==
X-Received: by 2002:a05:6870:128c:b0:ce:c0c9:5ba with SMTP id 12-20020a056870128c00b000cec0c905bamr896932oal.12.1648596387515;
        Tue, 29 Mar 2022 16:26:27 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h186-20020acab7c3000000b002ef5106248asm9784338oif.45.2022.03.29.16.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 16:26:26 -0700 (PDT)
Received: (nullmailer pid 1552557 invoked by uid 1000);
        Tue, 29 Mar 2022 23:26:25 -0000
Date:   Tue, 29 Mar 2022 18:26:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, yc.hung@mediatek.com,
        tiwai@suse.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, aaronyu@google.com,
        alsa-devel@alsa-project.org, tzungbi@google.com,
        miles.chen@mediatek.com, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com
Subject: Re: [PATCH v4 3/6] ASoC: dt-bindings: mediatek: mt8195: merge mt8195
 machine yaml
Message-ID: <YkOVocF+H1Up3usx@robh.at.kernel.org>
References: <20220324053851.27350-1-trevor.wu@mediatek.com>
 <20220324053851.27350-4-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324053851.27350-4-trevor.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2022 13:38:48 +0800, Trevor Wu wrote:
> Because the same binding components can be shared by all codecs
> combinations, we only reserve one binding file for mt8195 machine driver
> and rename to a generic name.
> 
> We use compatible string to separate different codec combination instead
> of creating a new binding file for new codec combination.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../sound/mt8195-mt6359-rt1011-rt5682.yaml    | 51 -------------------
>  ...-rt1019-rt5682.yaml => mt8195-mt6359.yaml} |  8 +--
>  2 files changed, 5 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
>  rename Documentation/devicetree/bindings/sound/{mt8195-mt6359-rt1019-rt5682.yaml => mt8195-mt6359.yaml} (87%)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
