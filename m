Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E152C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 14:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344980AbiFEO2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 10:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344887AbiFEO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:28:44 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D923C1CB2F;
        Sun,  5 Jun 2022 07:28:42 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso9041115otp.8;
        Sun, 05 Jun 2022 07:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppfZiH//muwNFuiG23aw0f2kMiy+cCf6lgxkiAQKzHs=;
        b=qg1kPHlxesoErloO8GBYcGqDjXCr3ZXRUULY4R5xCNI+gmkACrb/Medcg86BKN961i
         Ue9q/J1YDQyOOeNS+Az8Kf3i2MrqRK9tCHfocdjxSLstSWMKfrU9QmtTOR6ngKGyOYCe
         JHfq0kKzJLzeGwNkj0mxNf/2/oRVw6NoOkJ8KZsaf+M53ivxpOyiZmGV1J/QO+q961Z/
         rZ4kqRElF+UCEzSS7iMBz8057lGgto7TJ0yZtZogfonynWw8ng7OUtgiPb75AZz7pPKl
         3nbha0tGIUEAhq7FrdExJrnl4JtbtqXUArJTNvOTuT3xHbnjsG2owevja3n9UOxjkVVh
         SSkA==
X-Gm-Message-State: AOAM533eIYyegXulMXxXeFQzX5kOUKAJs5V9IdKipJRMhzRcycSMkSze
        VQOV5+aMiiLlgIJkecUh6Q==
X-Google-Smtp-Source: ABdhPJyTHwzkICTNfhUoRL/ge6O0hBJvqfQfAOHdonGwTMIs5q8FpQFq+4ccYfIWoq446UNc1GaqZw==
X-Received: by 2002:a9d:768e:0:b0:60a:ed4f:2403 with SMTP id j14-20020a9d768e000000b0060aed4f2403mr8089866otl.237.1654439322177;
        Sun, 05 Jun 2022 07:28:42 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fed:bdd:4931:91d5:7dbb:83fc])
        by smtp.gmail.com with ESMTPSA id cd24-20020a056808319800b0032e7205619asm1665168oib.15.2022.06.05.07.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:28:41 -0700 (PDT)
Received: (nullmailer pid 3452449 invoked by uid 1000);
        Sun, 05 Jun 2022 14:28:25 -0000
Date:   Sun, 5 Jun 2022 09:28:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Add Nomadik MTU binding
Message-ID: <20220605142825.GA3452393-robh@kernel.org>
References: <20220526213621.373727-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526213621.373727-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2022 23:36:21 +0200, Linus Walleij wrote:
> The Nomadik MTU timer has been used in devicetrees forever
> but somehow we missed to add a binding for it. Fix it
> by simply adding it.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/timer/st,nomadik-mtu.yaml        | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
