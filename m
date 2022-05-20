Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B80C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 18:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351633AbiETSVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 14:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352730AbiETSV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:21:27 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79937338A5;
        Fri, 20 May 2022 11:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1653070700;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MaJX4dK0P5th0rZhmYmkDkUC5bQw4gZcWPFsntkqna0=;
    b=clWdFrltBcCuNGcn5OZRufe9h0Wz1sbiCW42THUq0zdGsTZJhL9Ll7XLhDczL/Rq5b
    EqOy6JuItQv/jgo1Vrfsly74nGKok/Z8hl8yERVSN0wtt2HAv8yvXt8edgAv4wu/Oi4d
    l27Y7aaVoclGJa0BqQJk6BP7skbzTfR/RRzLNCh4r+rUl6BcyV09qfDcHdC+p9ERJzFa
    SoqOeNU3dRARYDBF45Ky7uB0uCSYDUdFf83aTiobNtQ4nGkkDpEYFWIWGn7W5GF0PBol
    GnR9siFnWXeDc9mJBpfArElVu1PlVXk+Q0n966ZiJVlNIE4kxzvdjPUy6TIcmRh6IMbP
    1Lng==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLUrK85lg=="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy4KIIKHeZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 20 May 2022 20:18:20 +0200 (CEST)
Date:   Fri, 20 May 2022 20:18:19 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] dt-bindings: arm: qcom: add missing MSM8916 board
 compatibles
Message-ID: <YofbXYbASdPtITMl@gerhold.net>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:32:48PM +0200, Krzysztof Kozlowski wrote:
> Document several board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 88759f8a3049..71d857dcf6b6 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -160,8 +160,14 @@ properties:
>        - items:
>            - enum:
>                - alcatel,idol347
> +              - asus,z00l
> +              - huawei,g7
> +              - longcheer,l8910
>                - samsung,a3u-eur
>                - samsung,a5u-eur
> +              - samsung,j5
> +              - samsung,serranove
> +              - wingtech,wt88047
>            - const: qcom,msm8916
>  
>        - items:
> -- 
> 2.32.0
> 
