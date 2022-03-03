Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A6BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 13:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233827AbiCCNnv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 08:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiCCNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:43:49 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25718A7B9;
        Thu,  3 Mar 2022 05:43:04 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id k2so4813763oia.2;
        Thu, 03 Mar 2022 05:43:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVjIFvRGxmCNMTbSrBbokaQaBUIKi3VHJCUkgaVuEhc=;
        b=lsASdvl8mQGrqlK7LDnbus6bLFbfUkYTZbnvQkk9jeuAr5VK7beEwIO1QfLMgrRT8L
         L7FOOsJdZcmSnK++aaFrL5fcpXhLoLhwH6xgL3gWCW312mUaSGQrZlRELpIKxfW2a785
         sxGVcb0lpG+P9mNIx/gWukL7VcZK2sZqMtkCRbedSqp4YqGYn51K4PB4d0egV3Ea0Arl
         +6nzjxIFzzTeMohBNqW23zJdfEOrfWYXkHmL/qMBXn84RT1OrWw46CUl/NiDJ2V8Mj7g
         zl5O4XE65bqFG1cysPunCSXBZA12j/7CBvAdaN/kOgHg0H8a/+rNlMngIQGM7Bt4Wir2
         MfNQ==
X-Gm-Message-State: AOAM532Bf8Nz1ycgZbeJnHQCo4oLfFHTXFT7vKgab7UG9ZRMphiS2Dfh
        h4kKofFg+ynM7vsca+TEqQ==
X-Google-Smtp-Source: ABdhPJyerRkHKmBETO/iPjPoX2HnozFhTqwx0qSfhqj4YNiGOkshnbjByp8JMzHFIJUHKbBPBFFypA==
X-Received: by 2002:a54:4e9a:0:b0:2d5:3e7c:7ff6 with SMTP id c26-20020a544e9a000000b002d53e7c7ff6mr4594562oiy.24.1646314983421;
        Thu, 03 Mar 2022 05:43:03 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n23-20020a056870559700b000d47e9dabf0sm1166362oao.0.2022.03.03.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:43:02 -0800 (PST)
Received: (nullmailer pid 1492131 invoked by uid 1000);
        Thu, 03 Mar 2022 13:43:01 -0000
Date:   Thu, 3 Mar 2022 07:43:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        Liang Chen <cl@rock-chips.com>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: usb: add rk3568 compatible to
 rockchip,dwc3
Message-ID: <YiDF5WVoR3c0Eevt@robh.at.kernel.org>
References: <20220225131602.2283499-1-michael.riesch@wolfvision.net>
 <20220225131602.2283499-3-michael.riesch@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225131602.2283499-3-michael.riesch@wolfvision.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 14:16:00 +0100, Michael Riesch wrote:
> Add the compatible for the Rockchip RK3568 variant.
> 
> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
