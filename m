Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD13C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 18:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346831AbiDGSXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 14:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiDGSXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:23:46 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93E230088;
        Thu,  7 Apr 2022 11:21:44 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id x8-20020a9d6288000000b005b22c373759so4460859otk.8;
        Thu, 07 Apr 2022 11:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2hNMT7KARfpwFjaUghpjAic4Rl2sTIlf2SxCKPU+sSI=;
        b=cG05VYEakiKczoVgoaGNpAch1xu0OPrUyUjUuEGfKVywvwlmcPK50R6V0FwxbtslIe
         bB+bynJGl64I59rZZtMSE9PwsIKOdH/6Zkd9L9OzHr9wZ7xr9oR2++BtJJcrd7PCCATX
         Pz3KTgPjiWTEt29fYdakVJl3HbSt12jJyReDSxR5xthnhRtGBIsRBfOdu2JNA7VS5Olf
         Aqy+MywWbpIDCj0lunTp8Z10J0RDlerFbzCn1hOecB1sXAdOHmDGeSTtGMheCQuDncsw
         E/NjyTMhIOE63AVzMmZGSn7e07g1uTsbNuScGYfohReDX5zgWA6H/O49UlmZNjJ9UTbs
         awCA==
X-Gm-Message-State: AOAM530y7iXaqalZ93h5BuLz1sKlTddZ7+ab76fia8sXE77V/XGF0Lup
        gMCiK+eZ/4zQkinRLzk6vA==
X-Google-Smtp-Source: ABdhPJz7RkdhTIn4wcJGlHStYCbpgCVoWUrpkBI47f4JnZAAF8rAz8/Ip0cnFGg+1peDAVDJlRQALA==
X-Received: by 2002:a9d:6f08:0:b0:5b2:26c4:22b2 with SMTP id n8-20020a9d6f08000000b005b226c422b2mr5404084otq.294.1649355704268;
        Thu, 07 Apr 2022 11:21:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f21-20020a056830205500b005cdb59d5d34sm8078898otp.81.2022.04.07.11.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 11:21:43 -0700 (PDT)
Received: (nullmailer pid 1732585 invoked by uid 1000);
        Thu, 07 Apr 2022 18:21:43 -0000
Date:   Thu, 7 Apr 2022 13:21:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Wei Xu <xuwei5@hisilicon.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: reset: Drop the hisilicon,hi6220-reset
 binding
Message-ID: <Yk8rt/udNN5fSmgu@robh.at.kernel.org>
References: <20220407145802.4060130-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407145802.4060130-1-p.zabel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 Apr 2022 16:58:02 +0200, Philipp Zabel wrote:
> The hisilicon,hi6220-sysctrl, hisilicon,hi6220-mediactrl, and
> hisilicon,hi6220-aoctrl controllers are already described in:
> 
>   Documentation/devicetree/bindings/arm/hisilicon/controller/sysctrl.yaml
>   Documentation/devicetree/bindings/arm/hisilicon/controller/hi6220-domain-ctrl.yaml
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../bindings/reset/hisilicon,hi6220-reset.txt | 37 -------------------
>  1 file changed, 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/reset/hisilicon,hi6220-reset.txt
> 

Applied, thanks!
