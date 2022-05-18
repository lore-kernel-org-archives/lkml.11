Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F546C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 01:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiERB7f (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 21:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiERB72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 21:59:28 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929054BFF;
        Tue, 17 May 2022 18:59:26 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l16so1069009oil.6;
        Tue, 17 May 2022 18:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0ErEGE8/dmj2Azoe4zkAGcu/VtrcYAyL6ETVQstf758=;
        b=3CAoHwb8NNRNHbjfkoFx+Gb5VwXefeh5LsK2iaDhWRG9DOCWXAwoHj16Mx+GhBohqf
         exXE9pJrZnb1hkYIZ90LYkJKS3IWrf+KiXQkt/aIFivPcgJTKh3p1gkm/1WgF0eF/bx7
         f+410wFdNL5shUQSQD+DRodUzFqbejhfnSlQqV7LCaFXQPZwOqGrd9YVYZUERj4djVAQ
         5ySI93OVTJUzneijWWFGOmn81uZC0diYLcWihJrPnfl+B9unUoPSUfqVnW3p047n4sa1
         0EcPOmenj6yCpSqB7RO99orrmz7M1gCQfxSQGMH10kc8hcnFcOn9CwezCoZX2+XUzimf
         Un7g==
X-Gm-Message-State: AOAM530TxRiu7znxZLLWqUy4eAxSO0343HXFaIhK+AAxj+7B/ud5APdl
        zbSTQnWMvf+be6AhlSiiww==
X-Google-Smtp-Source: ABdhPJxyOQdpLuVw0xV36ku25ipTMD9vCUe8gXTwtgNZHLBeoLqKQEkvCVw7bsG7o+hu5caGfwojpQ==
X-Received: by 2002:a05:6808:2017:b0:326:a252:8abf with SMTP id q23-20020a056808201700b00326a2528abfmr11755597oiw.143.1652839166212;
        Tue, 17 May 2022 18:59:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a3-20020a056870374300b000e686d13889sm423835oak.35.2022.05.17.18.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 18:59:25 -0700 (PDT)
Received: (nullmailer pid 2069205 invoked by uid 1000);
        Wed, 18 May 2022 01:59:24 -0000
Date:   Tue, 17 May 2022 20:59:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 05/12] dt-bindings: net: dsa: add bindings
 for Renesas RZ/N1 Advanced 5 port switch
Message-ID: <20220518015924.GC2049643-robh@kernel.org>
References: <20220509131900.7840-1-clement.leger@bootlin.com>
 <20220509131900.7840-6-clement.leger@bootlin.com>
 <20220511152221.GA334055-robh@kernel.org>
 <20220511153337.deqxawpbbk3actxf@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511153337.deqxawpbbk3actxf@skbuf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 06:33:37PM +0300, Vladimir Oltean wrote:
> On Wed, May 11, 2022 at 10:22:21AM -0500, Rob Herring wrote:
> > > +patternProperties:
> > > +  "^ethernet-ports$":
> > 
> > Move to 'properties', not a pattern.
> > 
> > With that,
> > 
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Even if it should have been "^(ethernet-)?ports$"?

Why? Allowing 'ports' is for existing users. New ones don't need the 
variability and should use just 'ethernet-ports'.

Rob
