Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C63ECAAA1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 21:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiHYVC6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240501AbiHYVCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:02:55 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE0E27CEC;
        Thu, 25 Aug 2022 14:02:54 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id q39-20020a056830442700b0063889adc0ddso14766474otv.1;
        Thu, 25 Aug 2022 14:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=zlDgSVi6ybm28ADf/l4jQxot81q6KSDv8EU/4KXm+fU=;
        b=uvz1NVeiZG6mXoPFHHOdiuHmMKISfR9QWNh4zUw+9cvUjuBM9GKmoCQZAu9u6cA/y+
         89QniYnc1QYxdcyejmsUY/0aIJwsc/ZuHPtw1mgBHtGwLL44TBFbBUndmF18SO+XUUXh
         jAC+YrA+VgB+pQp2eICaITh6GevSr6GDRPPZ6eT3exE+OYVCrfZMgpmu1bLQG+RLVZOL
         s3lTqjoIKn/D04NhSgn7f24Cm3zdqp4F5W24W1TA/6vFxrzmjTzDQclmQhwLDryC/ia/
         wSyTb1WiphCCbAlGo4Hxyh/JB0dJofLgxtbTD6etTW2RKdA/vzNRKax6JBF6SCRD6lHX
         ahqA==
X-Gm-Message-State: ACgBeo0vT+kdfAW+Jr8NVjGVrsGBLiMW9Br1/9fuYXHP73xjy2E39p4t
        V4XsfWpHG27laRL4DklqaA==
X-Google-Smtp-Source: AA6agR6Vlp9ebEknuUxzZiq3qwYENpFauxFBuzd6t2b++gnkgaGivXI0o6LrZdEEH5fh0PFr5laTyg==
X-Received: by 2002:a9d:748a:0:b0:637:1cf2:c8c4 with SMTP id t10-20020a9d748a000000b006371cf2c8c4mr338370otk.274.1661461373789;
        Thu, 25 Aug 2022 14:02:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t5-20020a4ab585000000b00448aff53822sm142942ooo.40.2022.08.25.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 14:02:53 -0700 (PDT)
Received: (nullmailer pid 1682027 invoked by uid 1000);
        Thu, 25 Aug 2022 21:02:52 -0000
Date:   Thu, 25 Aug 2022 16:02:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/4] dt-bindings: nvmem: Allow bit offsets greater than a
 byte
Message-ID: <20220825210252.GA1671168-robh@kernel.org>
References: <20220814173656.11856-1-samuel@sholland.org>
 <20220814173656.11856-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220814173656.11856-4-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2022 at 12:36:54PM -0500, Samuel Holland wrote:
> Some NVMEM devices contain cells which do not start at a multiple of the
> device's stride. However, the "reg" property of a cell must be aligned
> to its provider device's stride.

How is a DT author supposed to know this? 

I would lean toward it's the OS's problem to deal with (your option 1 I 
guess). I worry that one client could expect it one way and another 
client the other. Or folks making DT changes to 'fix' things.

> 
> These cells can be represented in the DT using the "bits" property if
> that property allows offsets up to the full stride. 63 is chosen
> assuming that NVMEM devices will not have strides larger than 8 bytes.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/nvmem/nvmem.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/nvmem.yaml b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> index 3bb349c634cb..4f440ab6a13c 100644
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -53,7 +53,7 @@ patternProperties:
>          $ref: /schemas/types.yaml#/definitions/uint32-array
>          items:
>            - minimum: 0
> -            maximum: 7
> +            maximum: 63
>              description:
>                Offset in bit within the address range specified by reg.
>            - minimum: 1
> -- 
> 2.35.1
> 
> 
