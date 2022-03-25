Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC491C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 16:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359524AbiCYQXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245440AbiCYQXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:23:45 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9D5D76E7;
        Fri, 25 Mar 2022 09:22:10 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id z92so9809654ede.13;
        Fri, 25 Mar 2022 09:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=25Sv76S3nsIXclHnSSNKGZRwYOFE+JeCmB/X5ru3160=;
        b=cLkuJiAdophYt9/XhrRs1UyF50GwzLtMLwCdbpvRl0sAgfgLtHCw593Esu8fTI4+58
         3UVuLmBGyRvju966qK+TKqlBq740pk2jganHyhtrlDt34q9XVNsDwLH8fazuUoFBtv0Z
         ODa3NppGfEwFivV4jbv0Y54/dKw0Y+vMzd+8m5Dc3GRuxi2DEJmsXLGUGPIXcQeZXZUL
         w+w1mTEqwEjuV4Gr3sHQdEZJXCSbl4BTU8Ps7hfr39GH+gjXUp+M9OPvGDt/IW0VXRV6
         nwV9l+2PqM/zaI3ybshRMZ5G0/vQjw04wFdq47s8my1+di4Zl5Ui9dH7eviMeePm7xGZ
         DCEA==
X-Gm-Message-State: AOAM532vwHGa2ep56Nblaw2lRMQLdcO1+QQdiHCpejRS/0OAlJKGGWTw
        pQ6kGH6ruFKcrMMm5n62+d4=
X-Google-Smtp-Source: ABdhPJzlWhOcwaAePVg/IepGLB+F80voFv4n8ELMntFLxO0cDY4gE9dISPGaxZrLtJxAP9NILWAwBw==
X-Received: by 2002:a50:fe81:0:b0:419:16a5:d265 with SMTP id d1-20020a50fe81000000b0041916a5d265mr14211658edt.4.1648225329129;
        Fri, 25 Mar 2022 09:22:09 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id c14-20020a170906340e00b006ce98f2581asm2449507ejb.205.2022.03.25.09.22.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 09:22:08 -0700 (PDT)
Message-ID: <ebca0e5d-cc24-af1c-5308-8544682984ec@kernel.org>
Date:   Fri, 25 Mar 2022 17:22:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/3] dt-bindings: mtd: ti,elm: Add support for AM64 ELM
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        robh+dt@kernel.org
Cc:     richard@nod.at, vigneshr@ti.com, kishon@ti.com, nm@ti.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220325123707.22020-1-rogerq@kernel.org>
 <20220325123707.22020-3-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220325123707.22020-3-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/2022 13:37, Roger Quadros wrote:
> TI's AM64 SoC has the Error Locator Module. Add compatible and
> related properties to support ELM on AM64 SoC.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  .../devicetree/bindings/mtd/ti,elm.yaml       | 28 ++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/ti,elm.yaml b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> index e36452b742c0..967c87f32c71 100644
> --- a/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> +++ b/Documentation/devicetree/bindings/mtd/ti,elm.yaml
> @@ -16,7 +16,10 @@ description:
>  
>  properties:
>    compatible:
> -    const: ti,am3352-elm
> +    items:

Why do the items appeared again?

Make it an enum in first patch, without items, with one entry. Now in
patch #2 you add one more compatible.


Best regards,
Krzysztof
