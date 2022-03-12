Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2682C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 11:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiCLLZJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Mar 2022 06:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiCLLZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 06:25:05 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5B06315;
        Sat, 12 Mar 2022 03:24:00 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id g20so13862607edw.6;
        Sat, 12 Mar 2022 03:24:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OSf1OwJ7magl6qu7qroFSGgkU8xwtM3u7m6pE+i/ZuY=;
        b=2xDVGXcqM84Oy2dPsCXRgpHFDXfHFA51svmuCdavaplV+1RWfzOE7EwL0olvHrAwko
         HZdsLttzAnXcMcPs227jZvVuY652iSdcGKE72mRvZ+1b85TPSYogrUE+f6v2jsls5MFM
         wLEm7m+d95DAXpCglj+HxpvfyTzbVGO8WZQ43CblzgPrpHfB0pJIzvEQt4zXxA2qtgdj
         ylp+TKxA7H0evIDr5UgI7cuKFUr2fmCgDH8H5JMqp3Ifuo5OXFudjRVig8VmmQwQufjg
         uj+EVisZZvnrP24TUouo04CiiBDr6OjmwfSerKenBi89ZIOP19XpiBcqFv15fDbNUqXL
         EiWA==
X-Gm-Message-State: AOAM531KEzM03z8c1bUqwV/AmqT8FK6jTs/g1/xS3HU86ihb4WR3//ka
        /nodgT1KAQ3CelH1xnhjS7c=
X-Google-Smtp-Source: ABdhPJwNOq5DkxOgDmvFW1pYBkpqCGq0vx2MY/WBchfflM8IP0pOMftZ8a2mga9NeAkMM5ra2LlHpQ==
X-Received: by 2002:a05:6402:11ce:b0:418:633b:ed95 with SMTP id j14-20020a05640211ce00b00418633bed95mr2058091edw.0.1647084239107;
        Sat, 12 Mar 2022 03:23:59 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id v2-20020a17090606c200b006a728f4a9bcsm4210406ejb.148.2022.03.12.03.23.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 03:23:58 -0800 (PST)
Message-ID: <c80eed69-088b-cfaa-a041-cdd6d5fe160c@kernel.org>
Date:   Sat, 12 Mar 2022 12:23:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] ASoC: dt-bindings: Fix patternProperties with fixed
 strings
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220311234802.417610-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220311234802.417610-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2022 00:48, Rob Herring wrote:
> The simple-audio-card and renesas,rsnd bindings used 'patternProperties'
> with fixed strings to work-around a dtschema meta-schema limitation. This
> is now fixed and the schemas can be fixed to use 'properties' instead.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/sound/renesas,rsnd.yaml          | 16 ++++---
>  .../bindings/sound/simple-card.yaml           | 42 +++++++++----------
>  2 files changed, 28 insertions(+), 30 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
