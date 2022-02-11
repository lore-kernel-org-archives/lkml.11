Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC826C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 16:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351544AbiBKQbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:31:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245006AbiBKQbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 11:31:41 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C336FCC9;
        Fri, 11 Feb 2022 08:31:40 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id m10so10136674oie.2;
        Fri, 11 Feb 2022 08:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nFyYz6B61o6ZmAG6Z9u/1BTHXgZZ6LE9DEH+VRcvbuw=;
        b=jZ0xKT4tdpO2v5fuo4wm7bxxXCbCwFdUZW7lx+XLwFh6WrvGRRevlTKlD4Dute4IjO
         TmfJYr3dq6rFg9B5KymicWTcYfDGkbhYjxfDLIfhaWKx9omfdjCYWC9oY2AiwRQlgIDN
         MzTHvGbnxSxMxU15xLuV+1B6NT1izVZsYVAD1PPDaWcuZgDeihi/B3rNon27iJ2JPDLQ
         RDUM4Wx5dKh+ZUWjtXPZ6M2QQ83wl5DfJCmxKpOqZhhsv9nvVwfJKLtbRKP9y1xOg+wE
         LsFCwEXtgRt9IeMIe7g0bVcr5Js13DW5StGDUQLPDruLX6nE6Esr26pypvf2rjEHoyxa
         ZvTA==
X-Gm-Message-State: AOAM531l9f48TEk0NP3tTCBZ1uCOFXe4oa1bmbg/+W71oCh7cXK1Q+sL
        GhEk4MihLYwXfM3bOTrxdQ==
X-Google-Smtp-Source: ABdhPJzMDrkvZvhakAn+3iVKL9Rft7BZPls2T14LUm00GHSM8rLsUZomTSrj9kvEapTDMlbz2LhKdA==
X-Received: by 2002:a05:6808:1b22:: with SMTP id bx34mr541927oib.298.1644597100188;
        Fri, 11 Feb 2022 08:31:40 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id ay42sm10106671oib.5.2022.02.11.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:31:39 -0800 (PST)
Received: (nullmailer pid 476413 invoked by uid 1000);
        Fri, 11 Feb 2022 16:31:37 -0000
Date:   Fri, 11 Feb 2022 10:31:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, ~okias/devicetree@lists.sr.ht,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] dt-bindings: display: bridge: document Toshiba
 TC358768 cells and panel node
Message-ID: <YgaPaULepfCMUeDc@robh.at.kernel.org>
References: <20220207223911.97180-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207223911.97180-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Feb 2022 23:39:11 +0100, David Heidelberg wrote:
> Inherit valid properties from the dsi-controller.
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - added $ref ../dsi-controller.yaml# instead copying properties (Dmitry)
>  - additionalProperties -> unevaluatedProperties (Dmitry)
>  - example dsi-bridge@ -> dsi@ (Dmitry)
> 
>  .../bindings/display/bridge/toshiba,tc358768.yaml          | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

Applied, thanks!
