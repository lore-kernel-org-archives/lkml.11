Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8940FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 18:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiFASrU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiFASrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 14:47:15 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6F5FF5BA;
        Wed,  1 Jun 2022 11:47:13 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-f16a3e0529so3910637fac.2;
        Wed, 01 Jun 2022 11:47:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BpEiiB8zVcuCrCk2bsjNqQCXUo6W+A/7ZvIlEFJ0600=;
        b=VcCh/IQMVfW4AfBXLZsv2TH6BZJz7AAOS+z+2fBQcbA+gzp/j4EDXtujYFf1NCDFgX
         FHgB4z7c6MimO3vFDHmUNYjqCCAuAJyjVj/dkKdUaGul2v2O4TdXD7nrYh8Q+9Hajc3p
         pVcDAdpFRm/alNgL5gCNrIsn8TQeDpLHpmTvzqZKkX8D99aZrJxIAXJfht21ehrfrYVi
         5AasNFL0Qdf7XfZiiC2EUgSTaq05Lslgz85Brp2SlE636HNVodLx88vF316rkQHC1/bH
         NmaaSqxNjONoi+fTG4PGnNZGSe24U/k9nRZe2ZOvv7eBijSeP4jjj4eCZx0GpFJ93a9Y
         n+tA==
X-Gm-Message-State: AOAM533RfUYaiHGcOw3sC2Lhgp2AhoATx66g/iFw0hqH1YNcne+s0vlf
        uo0Cd3L8QQdDkxaxjt2p6ZHn3ZCAsQ==
X-Google-Smtp-Source: ABdhPJyX5bZMQUJDsNtFITnapRJKekczXfA75TW+eMztGj93S5/Ele4MFys9QeG0ABJjDOQVNxdf9g==
X-Received: by 2002:a05:6870:599:b0:f1:67f6:5860 with SMTP id m25-20020a056870059900b000f167f65860mr17570575oap.114.1654109232930;
        Wed, 01 Jun 2022 11:47:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j6-20020a056830270600b0060603221264sm1073444otu.52.2022.06.01.11.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 11:47:12 -0700 (PDT)
Received: (nullmailer pid 205923 invoked by uid 1000);
        Wed, 01 Jun 2022 18:47:11 -0000
Date:   Wed, 1 Jun 2022 13:47:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Max Fierke <max@maxfierke.com>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: display: Add bindings for ClockworkPi
 CWD686
Message-ID: <20220601184711.GA201654-robh@kernel.org>
References: <20220601051748.1305450-1-max@maxfierke.com>
 <20220601051748.1305450-3-max@maxfierke.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601051748.1305450-3-max@maxfierke.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 12:17:47AM -0500, Max Fierke wrote:
> The CWD686 is a 6.86" IPS LCD panel used as the primary
> display in the ClockworkPi DevTerm portable (all cores)
> 
> Signed-off-by: Max Fierke <max@maxfierke.com>
> ---
>  .../display/panel/clockworkpi,cwd686.yaml     | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml

You probably can simply add this to panel-simple-dsi.yaml. It mainly 
depends on how many power supplies this panel has.

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml b/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
> new file mode 100644
> index 000000000000..935a33b9305f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/clockworkpi,cwd686.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/clockworkpi,cwd686.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ClockworkPi CWD686 6.86" IPS LCD panel
> +
> +maintainers:
> +  - Max Fierke <max@maxfierke.com>
> +
> +description: |
> +  The ClockworkPi CWD686 is a 6.86" ICNL9707-based IPS LCD panel used within the
> +  ClockworkPi DevTerm series of portable devices. The panel has a 480x1280
> +  resolution and uses 24 bit RGB per pixel.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: clockworkpi,cwd686
> +
> +  reg:
> +    description: DSI virtual channel used by that screen
> +    maxItems: 1
> +
> +  reset-gpios: true
> +  rotation: true
> +  backlight: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - backlight
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    backlight: backlight {
> +        compatible = "gpio-backlight";
> +        gpios = <&gpio4 30 GPIO_ACTIVE_HIGH>;
> +    };
> +
> +    dsi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        panel@0 {
> +            compatible = "clockworkpi,cwd686";
> +            reg = <0>;
> +            backlight = <&backlight>;
> +            reset-gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>;
> +            rotation = <90>;
> +        };
> +    };
> -- 
> 2.36.1
> 
> 
