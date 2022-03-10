Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5F0C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 23:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344656AbiCJX0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 18:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239276AbiCJX0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:26:46 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478561965D3;
        Thu, 10 Mar 2022 15:25:45 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so8654125ooa.10;
        Thu, 10 Mar 2022 15:25:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hnMk+HeuG2WdpJ1XdsdHKiHZ40w09is/u7uNCdvGXg4=;
        b=PMaHBs5rWs3zptyQMDEv/fxgTFNlrtO7VCUbkChxae5t/7X65dCCFQW9bzpVRsbzxY
         +TE72hLKXwJJnMIM9DLiRMeQsLRiJMFpACTw47hzxX0va74gF1IGI9mkBoAlGkiNbbDV
         p7GHhbgfJ+lggT+qf1556MG67Btdhlqh4beGJctDijZy0maeAUEJLQP1r2vDdjHPV4RJ
         uNx5w+QtpExkMFRWws9vZ+NHSX57ubp71/xrlILNdmFz1aL75xzBZo59f7e6O+vnF553
         JyaO/dYuVZSSFM+/8cXWGvAfIRMB67IwMYAjaiwhn+gn7GjJj8+JAoMglYxmF2ZVdax9
         bo/g==
X-Gm-Message-State: AOAM530jo+yKT4PyoH0fvyJ6TlzoORcj0o/EBZeBQm8MToIlhG+hB2bq
        UXMH3zdUaZthwc4DPvwI6yxT3JnEqQ==
X-Google-Smtp-Source: ABdhPJx27IsnM2iW5/8HZIJxqUjmFNCYcj1jV07/oOlrSZfUy+aScCvZZP9Kl8eLxVFrE7M69AUWrw==
X-Received: by 2002:a05:6870:32d5:b0:d2:c8c2:d8cd with SMTP id r21-20020a05687032d500b000d2c8c2d8cdmr10067242oac.86.1646954744639;
        Thu, 10 Mar 2022 15:25:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 45-20020a9d08b0000000b005b2387fefb2sm2873871otf.78.2022.03.10.15.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:25:44 -0800 (PST)
Received: (nullmailer pid 2292764 invoked by uid 1000);
        Thu, 10 Mar 2022 23:25:42 -0000
Date:   Thu, 10 Mar 2022 17:25:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] dt-bindings: extcon: maxim,max77843: fix ports type
Message-ID: <YiqI9vkjf8jM6/yB@robh.at.kernel.org>
References: <20220310073258.24060-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310073258.24060-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 08:32:58 +0100, Krzysztof Kozlowski wrote:
> The "ports" property can contain multiple ports as name suggests, so it
> should be using "ports" type from device graphs.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: 9729cad0278b ("dt-bindings: extcon: maxim,max77843: Add MAX77843 bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Hi Lee,
> 
> This is a fix for a commit in your next branch.
> ---
>  Documentation/devicetree/bindings/extcon/maxim,max77843.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
