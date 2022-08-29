Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98488ECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 19:54:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiH2Tyj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 15:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiH2Ty0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 15:54:26 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D7282F80;
        Mon, 29 Aug 2022 12:54:23 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-11f34610d4aso965777fac.9;
        Mon, 29 Aug 2022 12:54:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=FDO6mvs94K52JYIMZxbs0lZDk/WquPW4Hgwv9VXSGMg=;
        b=fOF/M4aRAt9HwG0Y3GdoSEm+WC2KSdBtvnXFx9xCMAqROoKOCtbqHDf5tKbu1Lv/I+
         p5f7In7kG57ZQLCIs+4aoGC6jYehRvJvhgYadFVBaE6P0kFoVSQMivXhjg1ioGNZ/GBj
         +b3FCaNMlUACE1F/bzEx/dKxG8ccC3W7vGChyZVKGfbg8yM1lPxPHwAvcxjqxsEpx6mg
         9eKhYS3UUXPR6KEv3b0waWLbFPI2dOZWERQkImA6xwa9INoD32F2EBZPLaKk6Nbw/Z+X
         WDJcOo2O0o78zhsLvkbFReB4UIpb1DNyAgQlZxi948q7LN/tgwUctma09wkin0SWHP8T
         yFyw==
X-Gm-Message-State: ACgBeo2nSPdlJ8aYrBqz6ANY9DjqwpYpSaRBKEgiQgRkY2OYQI1/lt6x
        TrP9VyKTxM/pZSSWAe7LZVgz4lUF0A==
X-Google-Smtp-Source: AA6agR4NB5kCvwS6fB95YVhSlLV5jzI1vFgUAoZgXMvMsApZ70uAHlfBh4J1LbCmGqHqo+IHbVTXGQ==
X-Received: by 2002:a05:6870:b01e:b0:11d:fbe9:90e7 with SMTP id y30-20020a056870b01e00b0011dfbe990e7mr8430315oae.32.1661802861893;
        Mon, 29 Aug 2022 12:54:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l2-20020a544102000000b00343459324besm5142691oic.49.2022.08.29.12.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 12:54:21 -0700 (PDT)
Received: (nullmailer pid 2308571 invoked by uid 1000);
        Mon, 29 Aug 2022 19:54:21 -0000
Date:   Mon, 29 Aug 2022 14:54:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] dt-bindings: mfd: syscon: drop ref from reg-io-width
Message-ID: <20220829195421.GA2308508-robh@kernel.org>
References: <20220823101021.387034-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823101021.387034-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 13:10:21 +0300, Krzysztof Kozlowski wrote:
> reg-io-width is a standard property, so no need for defining its type
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
