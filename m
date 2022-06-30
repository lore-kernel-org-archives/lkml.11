Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE99C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 18:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbiF3S4u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236556AbiF3S4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 14:56:49 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C68135DDA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:56:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z41so111426ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 11:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZaHJb6uQXqLFrmehnQAQlZbXIcxcwyw769AM2BSKwQ4=;
        b=d/Md1t9QKsUuVjUHG+yzPLl1iqq7kMM6zSi/+jDYTWBhogXWLSvqgx7YxgPro3Sg4j
         4+dPQBsUpUR2JVH1TziYcZqnUYSZyeOzQ8v/OpR8YAU5VAl4p9kAF3lOpm70o9rShPhI
         h9oSlrt+DXh1YrZt0sS/Z10NVsIRy3pRB9gRILlLnPqGDQn70oxL6Biok0deZuI8seB6
         vtenMRVx4GW7L9zBGQWvjr5kLlwfC1u5EpQVMAQHFN+L/mqH+L3yNy/E/R5IESwzPkbW
         tDPU5PbjbjEGK59mCrCq0o3LqxUiM4M197zg7iDDwRaShK/IYwlw8XEqiRSwI5JyFIvZ
         TFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZaHJb6uQXqLFrmehnQAQlZbXIcxcwyw769AM2BSKwQ4=;
        b=WKKyco0lftE7flzanzki3+PE5VH9XhH7G01xp7W6iu7Zav79D/w/rfUTGXmDjr3ZaD
         6vUqF4UW8FFvC8RIpYzIp5v/Sy4Ehi7rB6DWaLJtbQYU/taWGLcMtHUdjFv0C5ZnYhD+
         ilEzRigT5PyCZ8dtxrJQJufsxa+nZIdHuvIOHiQCtvF9hbK9q//aCkUTHtG0jGQb/HGD
         wOnkt3fRhsxUSf2frFStuJE27MLtpEaLwa5CKe4NP3pKqalo45m18/sdS3F/cHHmyb+n
         GvnsgfeY7th+itq8RJk6ZcXij0DzJrXaS4Zcfmw2p3yaXAAoyajEXCHp9l9mIqaBWoNi
         PDAw==
X-Gm-Message-State: AJIora9ylvi9X/O3VqJ3I1wmv76c9JGRvup4Dtgg8ZFS8sSJggGu+l2p
        zq55qrHUSfAWW3zt7h1PXOuotw==
X-Google-Smtp-Source: AGRyM1uALB+KUyfyyVrA6ZSju62jqiOknLc16wWd610tfXEzZ+SU60KLb9DxwKikAM+s37hXAkhcfg==
X-Received: by 2002:a50:eb45:0:b0:437:7686:6048 with SMTP id z5-20020a50eb45000000b0043776866048mr13977485edp.264.1656615406671;
        Thu, 30 Jun 2022 11:56:46 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id a18-20020aa7cf12000000b0043503d2fa35sm13788710edy.87.2022.06.30.11.56.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 11:56:46 -0700 (PDT)
Message-ID: <1654112f-839f-1de2-0f00-fbf501824d6d@linaro.org>
Date:   Thu, 30 Jun 2022 20:56:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count
Content-Language: en-US
To:     Kris Bahnsen <kris@embeddedTS.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mark Featherston <mark@embeddedTS.com>
References: <20220630182746.3813-1-kris@embeddedTS.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220630182746.3813-1-kris@embeddedTS.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/06/2022 20:27, Kris Bahnsen wrote:
> Device-tree incorrectly used "ngpio" which caused the driver to
> fallback to 32 ngpios.
> 
> This platform has 62 GPIO registers.
> 
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> ---


Ah and one more - for some reason you did not send it to maintainers, so
patch will be most likely ignored. Please use scripts/get_maintainer.pl
to CC relevant people.

Best regards,
Krzysztof
