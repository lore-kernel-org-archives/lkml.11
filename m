Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75C3EC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 21:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347865AbiFEVaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347812AbiFEVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:30:19 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9973D4D62E;
        Sun,  5 Jun 2022 14:30:18 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id b11so9206524qvv.4;
        Sun, 05 Jun 2022 14:30:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uZI+EnU87dcWUfUFFhpN+OYPeQIExzhHGOWXPK3MC0A=;
        b=tYakV0VFERit+xwXQfPtNWLfIJsyNhXbP40iKGdCR8Qwctkb5MTp3bCkPDlfZyy5+W
         O5YVC9GIajnR7u6B1SGYwS3uAWqchOiUI39rNw1d2qZF86vcl3W4DtpItkIUAZJNe0de
         g94JKR1Ayj9jFooLlxi+5kd8xyumgHwhkG+ubVpOwhVyVq41pAYAzgTpx+J78yAteuGN
         w9owCGnmoOB37Mrfbz5KUEKTNW9Gn3KEamo4kdsD2E54fN2uc/lP8aSWn8cRLOXDrOBj
         JYOnEDyTPrBRcK6bYHrV9dhJA4lA7DVolM//9ACR8Cutk4/yL1Ne9c5rcuC+Jk9ptwqA
         A6uQ==
X-Gm-Message-State: AOAM53197GcEXQk4mPZwhs0rEGVWT6Mf8z0hp8F4u+P5MSw80J0rDCo9
        Di24ZZ8qBgpwv2wjgkZNjg==
X-Google-Smtp-Source: ABdhPJzBJkTjBX310kI+NxQF4vE8d9T0cn/1gPz4GQRd5Xd3gOwsRRPc85ot5wnlFJQqVP5chJMUBQ==
X-Received: by 2002:a05:6214:d48:b0:464:7c9a:4f39 with SMTP id 8-20020a0562140d4800b004647c9a4f39mr18104795qvr.124.1654464617714;
        Sun, 05 Jun 2022 14:30:17 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a15d500b0069fc13ce216sm9650760qkm.71.2022.06.05.14.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:30:17 -0700 (PDT)
Received: (nullmailer pid 3552526 invoked by uid 1000);
        Sun, 05 Jun 2022 21:30:14 -0000
Date:   Sun, 5 Jun 2022 16:30:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/7] dt-bindings: mfd: mt6397: add binding for MT6357
Message-ID: <20220605213014.GA3552446-robh@kernel.org>
References: <20220531124959.202787-1-fparent@baylibre.com>
 <20220531124959.202787-2-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531124959.202787-2-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 May 2022 14:49:53 +0200, Fabien Parent wrote:
> Add binding documentation for the MT6357 PMIC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
