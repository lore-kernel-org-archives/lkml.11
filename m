Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D221C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 22:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244076AbiEBWg1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 18:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiEBWgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:36:23 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B751DA1B2;
        Mon,  2 May 2022 15:32:53 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id m6-20020a05683023a600b0060612720715so3401252ots.10;
        Mon, 02 May 2022 15:32:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XSA9YndvfNYBh4vCbeUSx3HnFvZdR1DxFJAhwqu75m0=;
        b=4V35YE40lhHsC1lwUNaepjeKvVK0FuDe99SWnjWuL/NCISd4SQv8UdrHiZppXuf+Yr
         733OLuuHny8xHNhmZ32PskCTqnfCnT8qIUSHbS4Jh/aSu4E/scj7q+geeWUl9QkEvGLN
         WSTgKKGKzAwNpP9XnPCJtrcB4ol7frodJeAiwUCfF+26B5SWYkkJfntsvND1rZ9NSmxY
         t1ZM9UqOWZEn3ZvA8N+EFwHQ9aqkjd7JdUHXtJ0+Eoxuiszt0MUiiU1b+c2epEhBq9u5
         ckSGMd7R/pRAB7vaHAE0wWUUjFvAfYJYEC9WNylH2+kDrWw+z7NG/mfLDSVz/50xtBqE
         KA+w==
X-Gm-Message-State: AOAM531OT+eXBfkve1uLcqRKYPlh75oQSNvmtvo1VP6ThFzfHxRu3Le0
        mMRU9zVM+a3ffXe9ypMdy+bl6FJMkQ==
X-Google-Smtp-Source: ABdhPJzF2BhR/JXe6VIWEotbfWv8kVNDq/XceNLCdYXdx8vxLRKHHvOxpjQARdjMPuAAOHHRfZ0lZg==
X-Received: by 2002:a05:6830:1d92:b0:606:a1e:946a with SMTP id y18-20020a0568301d9200b006060a1e946amr4185338oti.294.1651530773029;
        Mon, 02 May 2022 15:32:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n10-20020a9d6f0a000000b0060603221264sm3377485otq.52.2022.05.02.15.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 May 2022 15:32:52 -0700 (PDT)
Received: (nullmailer pid 1916692 invoked by uid 1000);
        Mon, 02 May 2022 22:32:51 -0000
Date:   Mon, 2 May 2022 17:32:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nathan Rossi <nathan@nathanrossi.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: dsa: marvell: Add
 single-chip-address property
Message-ID: <YnBcE96wbQxZguw2@robh.at.kernel.org>
References: <20220423131427.237160-1-nathan@nathanrossi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423131427.237160-1-nathan@nathanrossi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 01:14:27PM +0000, Nathan Rossi wrote:
> Some Marvell DSA devices can be accessed in a single chip addressing
> mode. This is currently configured by setting the address of the switch
> to 0. However switches in this configuration do not respond to address
> 0, only responding to higher addresses (fixed addressed based on the
> switch model) for the individual ports/etc. This is a feature to allow
> for other phys to exist on the same mdio bus.
> 
> This change defines a 'single-chip-address' property in order to
> explicitly define that the chip is accessed in this mode. This allows
> for a switch to have an address defined other than 0, so that address
> 0 can be used for another mdio device.
> 
> Signed-off-by: Nathan Rossi <nathan@nathanrossi.com>
> ---
>  Documentation/devicetree/bindings/net/dsa/marvell.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/marvell.txt b/Documentation/devicetree/bindings/net/dsa/marvell.txt
> index 2363b41241..5c7304274c 100644
> --- a/Documentation/devicetree/bindings/net/dsa/marvell.txt
> +++ b/Documentation/devicetree/bindings/net/dsa/marvell.txt
> @@ -46,6 +46,8 @@ Optional properties:
>  - mdio?		: Container of PHYs and devices on the external MDIO
>  			  bus. The node must contains a compatible string of
>  			  "marvell,mv88e6xxx-mdio-external"
> +- single-chip-address	: Device is configured to use single chip addressing
> +			  mode.

Doesn't sound like a common feature, it needs a vendor prefix.

Some of the commit message explanation of what 'single chip addressing' 
is is needed here.

Rob
