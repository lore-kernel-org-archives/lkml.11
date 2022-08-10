Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEFCC00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 18:37:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbiHJShQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 14:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiHJShE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 14:37:04 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF4D8FD4E
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:36:46 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w14so14967626plp.9
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=z73/wP9z665YsaV/uDYD+wi6MjcJk/XyGVgycD2feRY=;
        b=GCesbzgRbUeNcglykgQOzG+Q2EGPGkSq1JQG9RGFGHXpvf/Xub+RfbVhbB4Onwq59z
         lfAW+gLONLo9sprR3soPhZr076B7uZ+VxQ2kB/ZyHNi5NsuVhGSY5yrzT6GS9OJcJSv3
         NUYsxm0PRK+/jrK5SPJ8u5WFQfetM7KeATnCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=z73/wP9z665YsaV/uDYD+wi6MjcJk/XyGVgycD2feRY=;
        b=TQol1cxJKuBF3EUNoCIktGz0icJg2/eZPO8x6dYiP8ODx14QeNMUPWpib6fDLGd1xZ
         qkeL4eDuGCXj3oRdBPAxwFJ3q7jr7m2gYsOVVxrWL2RgHEtcpygeotXX32Ou7PqJmpfH
         J/InU6aaYdYfawgcLUFpLjBKOGjERdLVtWMd+FKUO5sQ4kDziVVBvOkphBINR/aGR33z
         tRTN9RGl96e3k5LptwR/sksaMWOnIbHUwkpg/AqPtcP7wQoFpGNw7fhT1CzzRBpPoJEe
         d+jFx8dUJauCzRZO4NAo6O2DlhityND8dy60K01zT9pS0UDiMgav0MR4CGcfsRkfhVIN
         Rs3g==
X-Gm-Message-State: ACgBeo2aL5cEsHUUX0G5k2Ogb2PS4f3dz4l0rWlxs4ohJa3UxnStLrlN
        2r/Zc3jdiyazAMdC5DLDpyzo7A==
X-Google-Smtp-Source: AA6agR6CqEED+d1nIP977dwhdcJatfkdkn8f/WnJslQTl/9kRO5X2uQslJIZAvUqqjXMmKvJtwTn7A==
X-Received: by 2002:a17:902:cf0c:b0:16f:9023:e07b with SMTP id i12-20020a170902cf0c00b0016f9023e07bmr25466298plg.143.1660156605778;
        Wed, 10 Aug 2022 11:36:45 -0700 (PDT)
Received: from chromium.org (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902d2c200b0016db774e702sm13413462plc.93.2022.08.10.11.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 11:36:45 -0700 (PDT)
Date:   Wed, 10 Aug 2022 18:36:43 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] dt-bindings: chrome: google,cros-ec-type: restrict
 allowed properties
Message-ID: <YvP6u8SRHswA1Iva@chromium.org>
References: <20220810143613.482724-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810143613.482724-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Aug 10 17:36, Krzysztof Kozlowski wrote:
> Describe exactly what properties are allowed in Google Chrome OS EC Type
> C port, so the schema can properly validate the DTS.  Existing DTS
> defines always connectors with unit addresses, not a sole "connector"
> child.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Micro-nit: the tag in the commit message is missing a trailing "c" in
"cros-ec-typec". Other than that,

Acked-by: Prashant Malani <pmalani@chromium.org>
