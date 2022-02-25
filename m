Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D5EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbiBYQ25 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 11:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiBYQ2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:28:55 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B612112B74F;
        Fri, 25 Feb 2022 08:28:22 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id l25so7929364oic.13;
        Fri, 25 Feb 2022 08:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Yg7+VATWckSp/3QaQYWjzs95bNkFoPLYG5baR+5fkbM=;
        b=IBICuxzTZc9DgZ5gUz8CN5tD6E+/OVqYBbad2J73hXnAh9GVxTQObt7YYEyDXEwX+U
         E64kJPEK52bkuLmXNrP5Zfc4WyOqAIP6SF5ucN7G/ZpJ4fz/B92ebDLdT4yOo4Tnr4vM
         5bWxKyz4VLEMRXm3/AUPJItfP+yoVFJKnYgi7B3Re+Fonh2Wr97497tXc4Nt64rcN0Qc
         jWkKDhgCDMNpBMpcWx5s1lxWf/xTKTowwcTm0Jza4jvVygp2d35G97wKM6QyWGpWU64W
         hWso36eyWWUYtD7pumVbwZAiUWxHoKX3ir3wvSsak3q/ESbYSGSLHCukApk3Z5twaEXL
         F0Gg==
X-Gm-Message-State: AOAM532kCUAXoL2gFMIlzabxEwZWCDPsNJDN5vC/GFKyME/H1qleWVcn
        fkm1Y7NRu5EMOnpXuHBd6Q==
X-Google-Smtp-Source: ABdhPJwCgzjsTtba8mO1fd7ZgtP5lvO9rBeAVcw8nxHLbJCpAgGhFJIwt+BOxGR1cOQyypKWgPr9Rg==
X-Received: by 2002:a05:6808:1208:b0:2cf:48c1:bfb9 with SMTP id a8-20020a056808120800b002cf48c1bfb9mr2083672oil.15.1645806502078;
        Fri, 25 Feb 2022 08:28:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v6-20020a056830140600b005af1486cb20sm1305168otp.10.2022.02.25.08.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:28:21 -0800 (PST)
Received: (nullmailer pid 1042117 invoked by uid 1000);
        Fri, 25 Feb 2022 16:28:20 -0000
Date:   Fri, 25 Feb 2022 10:28:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] dt-bindings: mfd: brcm,cru: rename pinctrl node
Message-ID: <YhkDpJShgI/Ed8iH@robh.at.kernel.org>
References: <20220216112928.5330-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220216112928.5330-1-zajec5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 12:29:28 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This matches pinctrl.yaml requirement and fixes:
> 
> Documentation/devicetree/bindings/mfd/brcm,cru.example.dt.yaml: pin-controller@1c0: $nodename:0: 'pin-controller@1c0' does not match '^(pinctrl|pinmux)(@[0-9a-f]+)?$'
>         From schema: Documentation/devicetree/bindings/pinctrl/brcm,ns-pinmux.yaml
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  Documentation/devicetree/bindings/mfd/brcm,cru.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
