Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3829C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Apr 2022 14:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237747AbiD0ObP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Apr 2022 10:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237710AbiD0ObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:31:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8555B0;
        Wed, 27 Apr 2022 07:28:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEBDE61DD4;
        Wed, 27 Apr 2022 14:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A78FC385A9;
        Wed, 27 Apr 2022 14:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651069680;
        bh=jg7isHeqWXUe3zjwvEzCpYqI8jozk7FW2/8Y/IJfTPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2apnaAN8F00Nb0/0lcis7BIXCkSWoWIE73bihLjuaOBevH1jREETlouT5o7hIjBx
         8ezccvuK1pn2aGyZbT0MZuePPqvBZbuMolbXOwLswPJtljZ63LLzws1yYM8RyoYrTK
         EVyyEBU+i3Avy4u2H2344lfF3L/8/dmjH0Cjg9HCB/lpUDjzYASj0bdWelFL2C6q3q
         9WC5Yue0KY29fGGF97qCaowKp6Ce8ogYeay+7ZCsyW2tGZMisoKI5tSWnwUeb7OwtJ
         6au8W3SAJ4dN1wPzDLEEDZwDYTgwhE9NgH5+eeEw7zSUAq7I9D3kd6OPaA2UnmW1F6
         4aF5BoWU5t1DQ==
Date:   Wed, 27 Apr 2022 19:57:53 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: mailbox: qcom-ipcc: add missing
 compatible for SM8450
Message-ID: <20220427142753.GB4161@thinkpad>
References: <20220426101837.16201-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101837.16201-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 12:18:36PM +0200, David Heidelberg wrote:
> Fill missing compatible already used in SM8450 DTS.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

> ---
>  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> index 866efb278813..c57dd423e98c 100644
> --- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
> @@ -27,6 +27,7 @@ properties:
>            - qcom,sm6350-ipcc
>            - qcom,sm8250-ipcc
>            - qcom,sm8350-ipcc
> +          - qcom,sm8450-ipcc
>            - qcom,sc7280-ipcc
>        - const: qcom,ipcc
>  
> -- 
> 2.35.1
> 
