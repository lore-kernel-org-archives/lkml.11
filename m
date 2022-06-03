Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDE4C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 18:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243820AbiFCS2D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347083AbiFCS1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 14:27:46 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC51D5AA41;
        Fri,  3 Jun 2022 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1654279610;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=W0zLWbkTHHDH0iI0Y3QB9pk4VW+9pPQV3k8LcemuFF4=;
    b=pYJS6YCHpweybvsrVNZNXAsxkI5rzK4/zWclFd7weZ1Qnc/lPxo41Ty8ah4CMiEnOI
    ZaPHFjKRNZ4oVB8CiYRc9XjC57ylnB2bYRrb6iKZsqu76UlB8bmEMFHEVs3+z34YHYl5
    wvBtLcVMooMejLMjIGV1fW1TsinV6qGUatpYgYOaoYgvRD0rJTFI/btn0dV1AcpsCINp
    nqhaBNya5zv3lbRF+0fAcEv5tqLowMkkC+y42Dze0EMuwnqZVT5staAMha6d8V3FxEdT
    2AR6tBpKY5dZW5FbMgAj5aobTvtfhFCAQa48UcXu8NSx8U/HzhfAdky1u7F9FBrwwliO
    3LiA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrKw7/aY="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.45.0 AUTH)
    with ESMTPSA id 9056edy53I6nwkU
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 3 Jun 2022 20:06:49 +0200 (CEST)
Date:   Fri, 3 Jun 2022 20:06:39 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Alexander Martinz <amartinz@shiftphones.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: nxp,tfa989x: Add tfa9890 support
Message-ID: <YppNaL5r5EN3SUsU@gerhold.net>
References: <20220602164504.261361-1-amartinz@shiftphones.com>
 <20220602164504.261361-2-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602164504.261361-2-amartinz@shiftphones.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2022 at 06:45:04PM +0200, Alexander Martinz wrote:
> Document TFA9890 binding for tfa989x.
> 
> Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>

The dt-bindings patch should usually come first in the patch series.
Anyway, no need to resend just for that IMO:

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> index b9b1dba40856..7f2e68ff6d34 100644
> --- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> +++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> @@ -15,6 +15,7 @@ allOf:
>  properties:
>    compatible:
>      enum:
> +      - nxp,tfa9890
>        - nxp,tfa9895
>        - nxp,tfa9897
>  
> -- 
> 2.36.1
> 
