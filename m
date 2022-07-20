Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F336C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 22:49:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiGTWtT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 18:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 18:49:18 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B636F32EC4;
        Wed, 20 Jul 2022 15:49:17 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id q14so73212iod.3;
        Wed, 20 Jul 2022 15:49:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Kne3ZNgeLT1f/LI3wtqENGzTHVn0oWYxRaVlZ2auCpo=;
        b=mbL/7IM3RglwamlXaTggsJw2ZmbuiT8/Ad+0H4s36A/B8IMzHoCRyvWdujbybQL9Kj
         YDoWb8Q/CgGX7QnJmXuAb5ktt36Ao2XT9XjR1itSrMNDd0p6BIZU+a7TCGdrvojUzMeu
         XHFSxT0bxtKqoxf84BcYFZKZCdMy7nQRJR71rmqmjZh1FH0Z1mRYQ4wVX7JPwttOB2kf
         Uc0igSwWLiwrWYqVynPSeJI1/KeEr0KIC7FCw3Cg3fA3z+RzXHGdiFVcJ42Qqcq2vV1g
         c+LG6yIHW5KNz0vtQtQsnBEpVa4VWR3zHw4qDWpmYVD/UtoX1B0VwlVsNfzf9bE/YnYq
         nxxA==
X-Gm-Message-State: AJIora8NWBS+j/H/bsgE6B/hdKbuerlkEzdkuE4R+LhDYHF3jwQbPC4u
        hsHvutMgZ8W1muBo/996Ww==
X-Google-Smtp-Source: AGRyM1tVf/GhbqBgzUMiz354hmxIIQ+B78u5A0okJWF7fwbEPOjsEQAohGHKk/c4ARY9rqawYZjkqA==
X-Received: by 2002:a05:6638:1654:b0:341:59e0:9958 with SMTP id a20-20020a056638165400b0034159e09958mr12673519jat.224.1658357356970;
        Wed, 20 Jul 2022 15:49:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id z12-20020a92d6cc000000b002dd0bfd2467sm122626ilp.11.2022.07.20.15.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 15:49:16 -0700 (PDT)
Received: (nullmailer pid 4124766 invoked by uid 1000);
        Wed, 20 Jul 2022 22:49:15 -0000
Date:   Wed, 20 Jul 2022 16:49:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jimmy Chen <u7702045@gmail.com>
Cc:     devicetree@vger.kernel.org, Jimmy Chen <jimmy.chen@moxa.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v4 2/2] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Message-ID: <20220720224915.GA4124708-robh@kernel.org>
References: <20220719030718.28826-1-jimmy.chen@moxa.com>
 <20220719030718.28826-2-jimmy.chen@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719030718.28826-2-jimmy.chen@moxa.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 11:07:16 +0800, Jimmy Chen wrote:
> Add DT compatible string for Moxa UC8210/8220 i.MX7D board.
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
