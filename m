Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006E3C25B08
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 19:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbiHITDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 15:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245099AbiHITCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:02:55 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE7D2B250;
        Tue,  9 Aug 2022 11:37:27 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id r6so6984425ilc.12;
        Tue, 09 Aug 2022 11:37:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=p1zG50tbys0VZPxrDxOi0AKOdulYGynEm1N8ehSkAjc=;
        b=sWZ1u/ycY4p6g4Ne0ph+JHLp2aX1iYgK+fvQHuM+SzVAJMdkdTXfMpni+LrcdaZfsb
         44eU8XwfLHBsg7nId6lUEparO+Zk9STc4usNViKHQOABpddL47vU+EnJcHWaiQfC9Gmn
         Np1spb3RMbw+DS6W3YS7FVhK0caviiwIjeBzEqwTe1sVQHmAUCkP74kDjqHvf9ZWoOlg
         KCQZnJO6GM8NtOAbca0xh7CzHgpS3Jp0oKcGxcAhbtZv5S4jCqsxp5oUEO1l+Ln1hqlt
         eEHRUWXwzIKTwbVlGu8xX1ivjznQgF2t9bwhgrT+wK+OKT3Nc5WNW9AOoFuAJih28Gcz
         e9oQ==
X-Gm-Message-State: ACgBeo2DVwNStcgY9cgwb+ci4+mJdA8qcNfuab9/OgMMkzt1Tm8zuIN0
        wP6zptyTzSnPZF5N5/F6R8xfwi5W4g==
X-Google-Smtp-Source: AA6agR5ZnzgIeG/U81elDF8ly7zfS5wNx0qpukW37TAtB8c0f3T0cYufxFZ+ihA+ycvOJC14/yqQmQ==
X-Received: by 2002:a92:c247:0:b0:2de:497c:1068 with SMTP id k7-20020a92c247000000b002de497c1068mr11482146ilo.140.1660070246461;
        Tue, 09 Aug 2022 11:37:26 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s23-20020a0566022bd700b006849908ca7dsm1409961iov.36.2022.08.09.11.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 11:37:26 -0700 (PDT)
Received: (nullmailer pid 2163511 invoked by uid 1000);
        Tue, 09 Aug 2022 18:37:24 -0000
Date:   Tue, 9 Aug 2022 12:37:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc
 compatible after rename
Message-ID: <20220809183724.GA2163454-robh@kernel.org>
References: <20220804150935.121890-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804150935.121890-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Aug 2022 17:09:35 +0200, Krzysztof Kozlowski wrote:
> The Nuvia DC-SCM BMC board compatible was renamed iin commit
> 7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
> so adjust the bindings as well.
> 
> Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Use proper qcom compatible.
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
