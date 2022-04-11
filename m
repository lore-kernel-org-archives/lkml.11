Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CABC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 06:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244999AbiDKGkp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 02:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244988AbiDKGkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 02:40:37 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48FB23143
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:38:23 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c6so1916913edn.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 23:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=2WmKSNoZ9cWKL6JDASWnjI9NvSq7+tORNGnSjM+acks=;
        b=ODfe/DkGj1RuBxSc5J0EXQFnY/vL7RySjU4xh9bzSJOuWwZ4VAsC9/m4/eaLQ6CJl9
         QyrdjToejG5d1Qb/An1jX6vmjM2PDYFSJ9r+/5+rBxbn27zdhA/UNDf4zatsjZb2NBUh
         AbnvBXsf3y7KxVV7kVCuECnSxjbsZrs2szLVjgo8CohvcUfKrDT83QYnDYXfXQyaqJlH
         E33P1hJJjjxMEloiqUY9gxOFUCSsABl4hT7x7CUdyDYHqJD4eG9lJegQSh04Fwur0G4B
         8KGgJu0DtZN1p/FreHJOKXR9EhlgXXQ/wvLc4s5uuw5HufDXrQhq46vZWpzlqJu60raR
         Vbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2WmKSNoZ9cWKL6JDASWnjI9NvSq7+tORNGnSjM+acks=;
        b=3IkMnShl4ISTpZCgk04qgeukBBKhlhfhVrkqXEnxXE5pKVfmXo1JZXTsJCr4/xC5RG
         FyJXk5rjv2hV8pESV3T0S/e+788DBLR1+H+tJHE8B+OQZNwRec+c5Te4IQe5Mq29Aaly
         /cMYXY5nJjirDDliyJDt9ihyXQ0MiIRZknjfuodotOVElxH1CMIZOAod8reg+gmckxJ6
         0M16Ox2AVQ24eRv2xXNoVbI1wlhH4O/6941GKzmXOawSU6R5zBcF+CCIvdAnpVPfj+YR
         8bLdkZkCkQBYDCiyTWvZRc6ur+YH0xjeqLeoIqMGn7rpfdw77oZSdEnckL4Ju4OL3zyH
         9+PA==
X-Gm-Message-State: AOAM533EHzMIp+MWbXX0JLQNMUSihO5n460XL9a/DLzkNmKlyK2j9fv4
        GcE/n0Y1H+oRXgvifA2g5tdXUA==
X-Google-Smtp-Source: ABdhPJzXMCIHpbGK3+ThRU7zl6dOmK1ntfsv7TgaQBc60TypCniiSSzMFXl5kMoMEEbKtARXkujolQ==
X-Received: by 2002:a05:6402:ca9:b0:41d:76b5:d17a with SMTP id cn9-20020a0564020ca900b0041d76b5d17amr6338713edb.259.1649659102201;
        Sun, 10 Apr 2022 23:38:22 -0700 (PDT)
Received: from [192.168.0.191] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id o18-20020a1709064f9200b006e7f229b332sm8337293eju.36.2022.04.10.23.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Apr 2022 23:38:21 -0700 (PDT)
Message-ID: <2693ad68-c31f-1151-88fd-0b18a4249bd3@linaro.org>
Date:   Mon, 11 Apr 2022 08:38:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 02/10] dt-bindings: display: Add D1 display engine
 compatibles
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220411043423.37333-1-samuel@sholland.org>
 <20220411043423.37333-3-samuel@sholland.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220411043423.37333-3-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 06:34, Samuel Holland wrote:
> Allwinner D1 contains a display engine 2.0. It features two mixers, a
> TCON TOP (with DSI and HDMI), one TCON LCD, and one TCON TV.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
