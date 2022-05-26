Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5763C4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 02:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237814AbiEZCQq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 22:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346119AbiEZCQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:16:43 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB02BC6F9;
        Wed, 25 May 2022 19:16:42 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so205763otq.1;
        Wed, 25 May 2022 19:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=knN8WauJtLSOGA1g5HxlsYMwa8+Cv8xFXfQBVnNl60o=;
        b=Miwcey6nIx88kgUqDOjwqKI5C6FscklKnthAH23+JFh/XWO9WXF65Jx6rlsXCIXQmo
         XThDcIrE2Cgt4brLPKbHEGiDJaChs1OI+ZIlkvs1W5xYsIy26hvDqDxMd6AW1vPKMnuB
         /Ruzh8eOIVfvTOaVLhCNiQue8GnsNz2o80UDcH2OnsIRl+smj1sM3e5ByvliEyjqgSGz
         cNlQ5zjgLpZsw9UuB4ZUsTY+1zMxaWtLRbRufXBkJ3Lqj61alg65FzdVHu7fRfLXTzUk
         QPypJkbVQYz/3ZnjGnRIvHzBijYVnM98ef7m4V0iB8eV4e+dyLPHcFCz87x+L4iC9YNt
         vt0Q==
X-Gm-Message-State: AOAM532h3eV94bOygl+deH6FAE8BhyHf1yDKLJkG+QGf2e3/dqsFNP6F
        hH2p2+fk4qwMW4swG1C3/kcDgGvMXw==
X-Google-Smtp-Source: ABdhPJy3NJSfUzrqK7Qy/xtDqM7/QR6QuGwf5zgTir6ifNVbQ/8CB9Qjz1o4Pm8QWsu33IFqIhJw9g==
X-Received: by 2002:a05:6830:40c5:b0:60b:39c0:750b with SMTP id h5-20020a05683040c500b0060b39c0750bmr1438217otu.97.1653531401899;
        Wed, 25 May 2022 19:16:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k7-20020a056870818700b000f1fe6125e4sm184824oae.40.2022.05.25.19.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:16:41 -0700 (PDT)
Received: (nullmailer pid 2927770 invoked by uid 1000);
        Thu, 26 May 2022 02:16:40 -0000
Date:   Wed, 25 May 2022 21:16:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: arm: qcom: switch maintainer to Bjorn
Message-ID: <20220526021640.GA2927712-robh@kernel.org>
References: <20220520124018.367004-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520124018.367004-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 14:40:18 +0200, Krzysztof Kozlowski wrote:
> Emails to Stephen bounce since long time ("Recipient address rejected:
> undeliverable address: No such user here."), so change maintainer to
> Qualcomm platform maintainer.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Although Stephen uses his @kernel.org account but the address is still
> not updated, so I guess these files are abandoned. Otherwise if they are
> not abandoned, please update the email address.
> 
> It would be nice if folks from CodeAurora updated their addresses,
> because these bounces happen since some time and are annoying.
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
