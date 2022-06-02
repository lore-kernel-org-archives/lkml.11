Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26FFCCA47B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 13:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiFBNgC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235411AbiFBNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:35:58 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD456FD3F;
        Thu,  2 Jun 2022 06:35:57 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id h188so6566972oia.2;
        Thu, 02 Jun 2022 06:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1e7vrj+7vWIZv19NYkOjmP4n2WgkFN1YBD1LvqayGbs=;
        b=t6W+A/KeDjgXHETpOiRX+TTmVBajjB4TCbnd+RoszJk3ktCSkH8cbWrO3oPF8fjx74
         azCoYkfKud/+t9xeeZV1ALUE83MRubQzffhqWkqT86yP/NUJQ9FGqgwYXHlnEERsI0ut
         /vqZQ5ri4g3+AnJbXjcDXIHSJNg2CP7nYII2o+8kCSWLG7GS1TidYp50c9AoFFMCynM3
         no9usot8RErXWIaCNodoTyowUtMsx5eB3iefS28JtGq5/Q0XeqttoAoJE0GetGR7aTp5
         92GTaiNai3+jPzdUAv8e4OrIy2AGGH8ANKQ1zCxXO8HFBcib8SSoIQBXavhFwn0+Nbtv
         x8rA==
X-Gm-Message-State: AOAM530JodLmgTfpfXxMehkJS5+cnR0IIq6+14cn6Sp8jt5yJ9HbiGlq
        6L86UTCVLoT0HDcWmHCa3g==
X-Google-Smtp-Source: ABdhPJw6a8FuQ9JaLsqEzJHEmn2bKk+7WmqtRJ9dxbKbk2AHD0Zmxl5oga/5I8UwAGxardvLDEfNEg==
X-Received: by 2002:a05:6808:bd1:b0:32e:431c:2c4f with SMTP id o17-20020a0568080bd100b0032e431c2c4fmr737749oik.269.1654176956472;
        Thu, 02 Jun 2022 06:35:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l16-20020a056820031000b0040ed6225457sm2196143ooe.47.2022.06.02.06.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:35:56 -0700 (PDT)
Received: (nullmailer pid 2162006 invoked by uid 1000);
        Thu, 02 Jun 2022 13:35:55 -0000
Date:   Thu, 2 Jun 2022 08:35:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     robh+dt@kernel.org, broonie@kernel.org, trevor.wu@mediatek.com,
        tzungbi@google.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, julianbraha@gmail.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        matthias.bgg@gmail.com, aaronyu@google.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
Subject: Re: [PATCH v5 20/20] dt-bindings: mediatek: mt8186: add
 mt8186-mt6366-rt1019-rt5682s document
Message-ID: <20220602133555.GA2161972-robh@kernel.org>
References: <20220523132858.22166-1-jiaxin.yu@mediatek.com>
 <20220523132858.22166-21-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523132858.22166-21-jiaxin.yu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2022 21:28:58 +0800, Jiaxin Yu wrote:
> Add document for mt8186 board with mt6366, rt1019 and rt5682s.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8186-mt6366-rt1019-rt5682s.yaml   | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-rt1019-rt5682s.yaml
> 

Acked-by: Rob Herring <robh@kernel.org>
