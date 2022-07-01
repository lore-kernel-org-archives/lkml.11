Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B39AC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 16:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiGAQUB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiGAQT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:19:59 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A89D3C4A6;
        Fri,  1 Jul 2022 09:19:59 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id v185so2710246ioe.11;
        Fri, 01 Jul 2022 09:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZQCylsq9M4rPkFWxs4C1uvnNMPUdbfbfI4jjvjvy8og=;
        b=q8FNKulD5SWgXA8pn2a5SvjPd7AYhmzzU0xqlZgaE35sVt+puncTBWCFr5sRCBA/0o
         o5g6I1S9SQIjNBdsKsfxN2AYpW2u9gE3qTzlL9zGWQpXIuzPuN2jucA/TkrBYpjJAr9y
         yhmodL6V6S+i77ophYvp+c4+Gu+f9I19X95sWddnzkL8UmArAA2GC1L/zHnmVfNmFqlb
         4r455mPiGJZEbjnXjyL6zJkDDDHP/RdhDdu0UOeCpfN+KH64rQve/4O6huTmkMoUue9t
         vOc1nwXyvXefFu1W7A2g6GowAPRVMs6zVlZ/DS8dsZlxOgWvOCM6XRo4iId/m/GvdO9U
         uZKw==
X-Gm-Message-State: AJIora8s5z23ESNoImn4+7AhIlcz0slHZ4RaRctOdYVTHRJT6UeU3v1g
        zjp1eGaL43tTbQRcIisPlQ==
X-Google-Smtp-Source: AGRyM1u3Qr+tXqjLIi/7Jr5GJVG/S9BRBU00/78V+UB90jdiTjI+ZtZU2goYTjMedm+wRJ06+ao5sQ==
X-Received: by 2002:a05:6638:10c:b0:339:e949:b332 with SMTP id x12-20020a056638010c00b00339e949b332mr9136760jao.22.1656692398271;
        Fri, 01 Jul 2022 09:19:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id b11-20020a05663801ab00b0033a3d88cebbsm10036931jaq.105.2022.07.01.09.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 09:19:57 -0700 (PDT)
Received: (nullmailer pid 1067780 invoked by uid 1000);
        Fri, 01 Jul 2022 16:19:56 -0000
Date:   Fri, 1 Jul 2022 10:19:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     t-patil@ti.com, s-vadapalli@ti.com, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org, vigneshr@ti.com, kishon@ti.com,
        linux-kernel@vger.kernel.org, sjakhade@cadence.com,
        vkoul@kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: phy: ti,phy-j721e-wiz: Add support for
 ti,j7200-wiz-10g
Message-ID: <20220701161956.GA1067719-robh@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
 <20220628122255.24265-6-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628122255.24265-6-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2022 15:22:53 +0300, Roger Quadros wrote:
> ti,j7200-wiz-10g supports an additional reference clock.
> Add compatible and the additional clock.
> 
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  .../bindings/phy/ti,phy-j721e-wiz.yaml        | 21 ++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
