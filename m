Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88324C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 19:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241953AbiECTdI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 15:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241934AbiECTdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:33:05 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB492ED6C;
        Tue,  3 May 2022 12:29:33 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l16so11961506oil.6;
        Tue, 03 May 2022 12:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N6FBWOVMzK5yNDB3jrOFO2jTg3V4GRtMSkZ1a8GNUMQ=;
        b=fUeXEpjZo/P9Uv31ODlUMIGHXVeAlf4azp+TTjVusct4pXQfxJJTFxwXxF2CoPW5rN
         olYf+9ZD12qrhWxNoW01v33ciYfdXAtXVz7W1+0kn4DUZ0rXdK+1Kzgc7djBzCpoIT8w
         1uxmsN0A00k+oPxJlqgFPkvDLp8o1TLf+l/Hxd73Y0Upj0G7HyJRI/tQjSvdKrPRsqvs
         gFFDXDVesfMw8ISklnemqad3z462+BEfyLv9hjmaENIPDuwcl6B39stdI0NHKIG1M6WU
         MRf6DE7YWQwjGcjVY7o7mlV8+e1XU3Z8bo2nzwpIT+LBWU9SjzXpM5SUqq4MYlxz5km0
         X7pg==
X-Gm-Message-State: AOAM5334RDr4me+ODFso3okLhSk8ZXEeKxvcWv+TX80MScPmZJ4HO0fs
        s8qusZ/o7dbVaIzdU/S1nA==
X-Google-Smtp-Source: ABdhPJwHStHNylKAW5q1CVdmc/nFF0J7q1+CmHjl7uJiGrks+Q8zBnDcOHfO7bLb+qwWjN1Rxd07PQ==
X-Received: by 2002:a05:6808:1a1d:b0:325:c812:496b with SMTP id bk29-20020a0568081a1d00b00325c812496bmr2515687oib.106.1651606172384;
        Tue, 03 May 2022 12:29:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p203-20020acaf1d4000000b00325cda1ffacsm3617063oih.43.2022.05.03.12.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:29:32 -0700 (PDT)
Received: (nullmailer pid 4088847 invoked by uid 1000);
        Tue, 03 May 2022 19:29:31 -0000
Date:   Tue, 3 May 2022 14:29:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        broonie@kernel.org, julianbraha@gmail.com, robh+dt@kernel.org,
        trevor.wu@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, aaronyu@google.com,
        angelogioacchino.delregno@collabora.com, tzungbi@google.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org
Subject: Re: [v4 14/18] dt-bindings: mediatek: mt8186: add audio afe document
Message-ID: <YnGCmwNRZst+W5nb@robh.at.kernel.org>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <20220428093355.16172-15-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428093355.16172-15-jiaxin.yu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 17:33:51 +0800, Jiaxin Yu wrote:
> Add mt8186 audio afe document.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/sound/mt8186-afe-pcm.yaml        | 175 ++++++++++++++++++
>  1 file changed, 175 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-afe-pcm.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
