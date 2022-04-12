Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6F9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 23:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiDLXTN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiDLXTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:19:01 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39176433A1;
        Tue, 12 Apr 2022 15:06:50 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id e4so193610oif.2;
        Tue, 12 Apr 2022 15:06:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G0pAhD9aV5AnyvwmtEpWGX9c5HWPBuJjLdVCNmvb9b0=;
        b=dMsjOhm/N8YBqpt3hVD5slD8DOgLJRA4+YCmqdH/HbLlgR+wv+LWU1sYWu4dSfIPyx
         eOnguFiUNWlFcy5iE0+WM1LxYj8I7DylPnYjEyn0VS+JnmJCNOBDx1mgcTWkRQc/kktt
         7hBqgdyjWf3esvLcgLkDlba1ISGo5vB+iTDEf1WQEVpTZGs/appZ9tmKVHR5GhBUV6xw
         N2RDFY4ipDVvWwq6lHIlajydBp5/JIoSpBnSeM7DXEe+59AYAEjcXXbyLehb1d+A/ueJ
         DnIwZOKQ/HrzR6bsaTaBrSDe2A7sqCpg6tNqyBPOPJ3c95KUxST7y+lS5aqTdVghsPKO
         YWUw==
X-Gm-Message-State: AOAM5328BMKTyGTNzu05h6X99cR+ogvtTOLH4jmtKhPf3/6JKukbrGYS
        ma7CLDdW8eqagczr4vDdDg==
X-Google-Smtp-Source: ABdhPJxE/UsRuMfOAtqMzMZJgMh3Iphs+MRCEPCalHC0CQNxxJhgkhfFrPYjVDsBukILcUlibYaHNw==
X-Received: by 2002:a05:6808:13d2:b0:2f9:b876:31e8 with SMTP id d18-20020a05680813d200b002f9b87631e8mr2798341oiw.157.1649801209539;
        Tue, 12 Apr 2022 15:06:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ek23-20020a056870f61700b000e2f14d4f8csm1439791oab.53.2022.04.12.15.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 15:06:49 -0700 (PDT)
Received: (nullmailer pid 1028482 invoked by uid 1000);
        Tue, 12 Apr 2022 22:06:48 -0000
Date:   Tue, 12 Apr 2022 17:06:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     krzysztof.kozlowski@linaro.org, linux-clk@vger.kernel.org,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, maz@kernel.org, robh+dt@kernel.org,
        tglx@linutronix.de, p.zabel@pengutronix.de,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        sboyd@kernel.org, arnd@arndb.de
Subject: Re: [PATCH v13 2/9] dt-bindings: reset: Add bindings for SP7021
 reset driver
Message-ID: <YlX3+EgShsr01dkT@robh.at.kernel.org>
References: <cover.1649659095.git.qinjian@cqplus1.com>
 <11b8f60a7f19f25d2fdaa7a2ed770e9383cec3ba.1649659095.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11b8f60a7f19f25d2fdaa7a2ed770e9383cec3ba.1649659095.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2022 14:49:52 +0800, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 reset driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> Move HW mapping from dt-binding header to driver.
> ---
>  .../bindings/reset/sunplus,reset.yaml         | 38 ++++++++
>  MAINTAINERS                                   |  2 +
>  include/dt-bindings/reset/sp-sp7021.h         | 87 +++++++++++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/sunplus,reset.yaml
>  create mode 100644 include/dt-bindings/reset/sp-sp7021.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
