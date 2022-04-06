Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DF1C433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 19:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiDFTyY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiDFTwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:52:34 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA0526E2;
        Wed,  6 Apr 2022 11:17:22 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id w127so3228812oig.10;
        Wed, 06 Apr 2022 11:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MayEhBfyDhKvTtYRbnpHfN8fDb0gYOKuCm1801l+aSg=;
        b=VGAGRVnvgPjXfNgjnjAgIgSt4kJXvJ+uqDEuk7Rnpbv0kREDBWiMjZpP3CLH0mjDdC
         QPFpTYdOZ+qg+BeVuEjcgfV8eu2rCKnhjC6zNSguXHB6AFH1lslzCfA7x9rIcfKSBbhQ
         MdPFWCmQXdJBsvR6oiNBaP2Sj7tkHBXcvfyMQuymHY5m6U6iUwGka9wp0dgQywsqveUL
         FqNnaPtDhAntWbw87vP+jKAqYitn2YB8PwG0mKJRew1YoIL+ZqplOjsepSKCx4YrIZ9B
         NkkNH32rzHJro5kQ9hoz5rpo6HgE/OoL+bxOGzpVNLSkLyybRj8r9HWol5QHiVhwWpLn
         3HSw==
X-Gm-Message-State: AOAM531r5FeG1E9aQVeb1kr/8JBIW8aUeMr9fvnwx+gtyBx3ZvrbKsXl
        IlpscXW+8uX1Z+IeUdr2jQ==
X-Google-Smtp-Source: ABdhPJxy3bh9/KPkCSf6ifTSrW4gM64+l1dMNrBuxJ40JaHtmZxwcwwiTLmfCvt/MvRvvJtX9McQlg==
X-Received: by 2002:a05:6808:1394:b0:2ec:ddb3:c82b with SMTP id c20-20020a056808139400b002ecddb3c82bmr4295778oiw.274.1649269041667;
        Wed, 06 Apr 2022 11:17:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 14-20020a056870134e00b000ddaf3927b1sm6915466oac.32.2022.04.06.11.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:17:21 -0700 (PDT)
Received: (nullmailer pid 2528148 invoked by uid 1000);
        Wed, 06 Apr 2022 18:17:20 -0000
Date:   Wed, 6 Apr 2022 13:17:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: regulator: uniphier: Use
 unevaluatedProperties
Message-ID: <Yk3ZMNu4kDs+jtSo@robh.at.kernel.org>
References: <1649145303-30221-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1649145303-30221-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649145303-30221-3-git-send-email-hayashi.kunihiko@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Apr 2022 16:55:03 +0900, Kunihiko Hayashi wrote:
> This refers common bindings, so this is preferred for
> unevaluatedProperties instead of additionalProperties.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/regulator/socionext,uniphier-regulator.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
