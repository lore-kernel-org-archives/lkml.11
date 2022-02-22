Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A11EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 22:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbiBVWDH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 17:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiBVWDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 17:03:05 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4C4255BE;
        Tue, 22 Feb 2022 14:02:39 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id a6so16146999oid.9;
        Tue, 22 Feb 2022 14:02:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qVzagXFs5VEoZwWyyGNLg7Fowl1hS4qpjsXljb/7Fq8=;
        b=wG89iSBmUA5FU7HM5PcSNljOTUWYEf9QkK4I/s/O+HgNUFd2OmfTL947LRIJJyJDFm
         rQsoGgpsiVm6XCIFMUGN5Um5niEG5becSKE7yBjXtSh/8DQ0zk298AdFpyXkyF7rDFq7
         2VE/t9IysTAUrO4x+ASo9WxzUoBrp3EAJhjPvlKuZRwWS7Zs3xd7OgcXwbb91AeSY4Xl
         T7yXfQ+gM8Q8+UinU4fEivAKsU1v+DDYII475+dSQOLJqh5GSez5GhGkXD3v77MvCdpN
         hDzILP06EYQ64hKhBddwL8OOEaFqxTsDd3zTjgK6guamtO33l3E61e8FmMUYo2S1Au2R
         tk6A==
X-Gm-Message-State: AOAM532mnKblx2DuxDi0TzgjXTLy3Ry6wn11qQTXyhvun33u3tT2ibrI
        //5IGCzGVlHRVZmj6GAsVg==
X-Google-Smtp-Source: ABdhPJzddgw5NvXpghiT/HLsn6Dz+VYjNGjWr5+tXH0vFjhBcCClmiqEAXpbVgVFM3mV5hEInbbmCw==
X-Received: by 2002:a05:6808:e82:b0:2d4:1c37:d6ea with SMTP id k2-20020a0568080e8200b002d41c37d6eamr2969950oil.148.1645567357406;
        Tue, 22 Feb 2022 14:02:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 11sm1997082otv.56.2022.02.22.14.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 14:02:36 -0800 (PST)
Received: (nullmailer pid 3669247 invoked by uid 1000);
        Tue, 22 Feb 2022 22:02:36 -0000
Date:   Tue, 22 Feb 2022 16:02:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: vendor-prefixes: add second Synopsys
 prefix
Message-ID: <YhVde2P4UMWmi3OD@robh.at.kernel.org>
References: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
 <20220221082228.34407-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221082228.34407-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 09:22:27 +0100, Krzysztof Kozlowski wrote:
> There are few bindings with compatibles starting with a "synopsys"
> prefix.  Document it as deprecated, to be sure no new usages will
> appear.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Applied, thanks!
