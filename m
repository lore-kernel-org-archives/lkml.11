Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AF2C32774
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 21:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiHVVgL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiHVVgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:36:09 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDBD33419;
        Mon, 22 Aug 2022 14:36:08 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id o204so6332287oia.12;
        Mon, 22 Aug 2022 14:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=AvpFKTVtlMBq+hw7JoGPDSmZsSCDfKdJ6eZg738PV4U=;
        b=72I+AXieE7zyZUobZ1ufOEOuqE72ls1/XoS2SRbub8GYr+enpAUKHFftyB7T/g9PsT
         d8HsYp7XBiQvR5M5YJfNuTlkcjtNwJgM3vfwMIQ+ewKQ76Wf4R9xi5hMaW4zLMFoo767
         y4RN192nT3pw3SDzdK0R09yjl33kI3I97MFMEMpaxXKxCipO/N1BOF+T03WgCSPLl5H+
         hxSTzP5ZHhnr2aBzyzygPujtML59P65HS5jZxchepKMmH9ax9BYsaveqJSBA+02cFlfP
         i8NrM6ELnDQX9v1efZKzSalhJXbRoJAcRQxZhKY08C9BUDGq2REHhygiREXMxje+kzvD
         W2Og==
X-Gm-Message-State: ACgBeo0ZpkO0dNg9pvD+7Loz+YcDTP5xs3te03svEsIP/WWymYmH2dsu
        KOaN7ILVNa/FsCNRqHU8YA==
X-Google-Smtp-Source: AA6agR6jZHhw2YeqgJxqXl680sCfPVMjKdmRhCqYuprtJx5xwbSQ6YIMVFssbFBfSKcD4+SZ8ZzMhg==
X-Received: by 2002:a05:6808:3d1:b0:343:4049:6899 with SMTP id o17-20020a05680803d100b0034340496899mr126053oie.152.1661204168260;
        Mon, 22 Aug 2022 14:36:08 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fq36-20020a0568710b2400b0011d02a3fa63sm1688347oab.14.2022.08.22.14.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 14:36:07 -0700 (PDT)
Received: (nullmailer pid 894715 invoked by uid 1000);
        Mon, 22 Aug 2022 21:36:07 -0000
Date:   Mon, 22 Aug 2022 16:36:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     wei.fang@nxp.com
Cc:     netdev@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        f.fainelli@gmail.com, edumazet@google.com, andrew@lunn.ch,
        davem@davemloft.net, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, kuba@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        hkallweit1@gmail.com, linux@armlinux.org.uk
Subject: Re: [PATCH V2 net-next 1/2] dt-bindings: net: tja11xx: add
 nxp,refclk_in property
Message-ID: <20220822213607.GA894623-robh@kernel.org>
References: <20220822015949.1569969-1-wei.fang@nxp.com>
 <20220822015949.1569969-2-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822015949.1569969-2-wei.fang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Aug 2022 09:59:48 +0800, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> TJA110x REF_CLK can be configured as interface reference clock
> intput or output when the RMII mode enabled. This patch add the
> property to make the REF_CLK can be configurable.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> V2 change:
> Correct the property name and a typo.
> ---
>  .../devicetree/bindings/net/nxp,tja11xx.yaml    | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
