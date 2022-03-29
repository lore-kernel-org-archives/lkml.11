Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFCBC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 21:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiC2V2j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiC2V2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:28:32 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747F62335E9;
        Tue, 29 Mar 2022 14:26:47 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id e189so20314082oia.8;
        Tue, 29 Mar 2022 14:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mRUk/Z16L8Pkrou4H/BvsBwcGT5LseABEy44enEdci8=;
        b=65+0eIX8TlpkV2eT6bYhx+KJDh/sBWJ8lZIzFdGIN7C6puNnf6AKqGu27lESB7kEB4
         nvAwDb5qPWeQqV+SOUZyk4LKx9uyRkRituxkUBTyrUpOxAXndZ7jPA0N6qgjALcidsvE
         55oieAUEAE1nnNk16nUDJ3dpPuL6tckVUZh+DyzAR4N1xupgtGWfznxuk7Pc9pjAXSwh
         tulYkZUyXL1s+60qPSvOUHnxkAYdONO5hCqf7GqYEJXE7o3qSl5b6JqIaffhdmiEdYRe
         I0YfTbntHJFfV4WKOGORbmdHNZLQNnJVo0Fjz19sOeBRF1YFNik2j1HfRs8Ho5RqHdIa
         tqvg==
X-Gm-Message-State: AOAM533fXPHDHz1qYJYuVmjvSa40kNru4jOf8HIwGDSngGS8i7M8KOMx
        QxBZRTDQf7w8izT9wK0GgQ==
X-Google-Smtp-Source: ABdhPJxP0vjhdA7REtwegrkHKlgY97oyRSH1RDZNNuyl4ZBbY6WakBe7RjkOHxB9GgptLI4NcGVH1g==
X-Received: by 2002:a05:6808:f07:b0:2da:4916:578c with SMTP id m7-20020a0568080f0700b002da4916578cmr572061oiw.239.1648589206800;
        Tue, 29 Mar 2022 14:26:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a32-20020a056870a1a000b000d458b1469dsm9854110oaf.10.2022.03.29.14.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 14:26:46 -0700 (PDT)
Received: (nullmailer pid 1357565 invoked by uid 1000);
        Tue, 29 Mar 2022 21:26:45 -0000
Date:   Tue, 29 Mar 2022 16:26:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] dt-bindings: extcon: maxim,max77843: fix ports type
Message-ID: <YkN5lSmIijTlMLXs@robh.at.kernel.org>
References: <20220310073258.24060-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310073258.24060-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022 08:32:58 +0100, Krzysztof Kozlowski wrote:
> The "ports" property can contain multiple ports as name suggests, so it
> should be using "ports" type from device graphs.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: 9729cad0278b ("dt-bindings: extcon: maxim,max77843: Add MAX77843 bindings")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Hi Lee,
> 
> This is a fix for a commit in your next branch.
> ---
>  Documentation/devicetree/bindings/extcon/maxim,max77843.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
