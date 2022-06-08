Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 13:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240727AbiFHNpU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 09:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240603AbiFHNpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:45:15 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC49C2E2;
        Wed,  8 Jun 2022 06:45:13 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id 134so12574349iou.12;
        Wed, 08 Jun 2022 06:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=wTTvlPBhL0R4VGrImadF6/peV4pBTwvdmzGU+XrZruE=;
        b=OEq9XMCQGuowZhKqmuCAal7cGi6ms4hse0C90ofHDhqo3lzOmYKKrTz8d5JC4eR7L5
         +0fLOuiYG1d4e2rFWh4P2xwbYE6QBDDqFoSfFPtYgjUFuVmvyjWPr8nHk6vU8bOeSfgH
         FNBNS857IygPtHxgYpn9E2WI+ugjxkvNBm5WGLGz/c1ZN2Jwv/cRSXIIB5yDAAUGJCkW
         VJJe4q9gkUrD+cbrWUvTXvXzmiTAexkKVleAv5OUn7UsivyfF9ugJ8+FblXyRmDL2LJk
         K3zJWX6Fd/sXAzKAaQIQlo5jgC4Ri5l4SxBk93B/UkzhGC98iRWLQT/sQZvwuM7yzs8M
         BXfA==
X-Gm-Message-State: AOAM532enjpkgJgg1viwlx6dDGuj1wahdDW/dwlmSM1I2HVk857Laz6F
        Tze9KrNAG5a7E7re1AXpPQ==
X-Google-Smtp-Source: ABdhPJzXC7b2axuL8VqcV+jcp6rJGpBavEB0PfCW3q7lAr4J3Dzn0kGXXRomqn4DlodahC0axmuGvw==
X-Received: by 2002:a6b:cf13:0:b0:668:bda0:f300 with SMTP id o19-20020a6bcf13000000b00668bda0f300mr16208468ioa.89.1654695912193;
        Wed, 08 Jun 2022 06:45:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id p4-20020a056638216400b003315a20c6e1sm7862407jak.9.2022.06.08.06.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 06:45:11 -0700 (PDT)
Received: (nullmailer pid 1272088 invoked by uid 1000);
        Wed, 08 Jun 2022 13:45:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, linux-phy@lists.infradead.org,
        Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org
In-Reply-To: <20220608070452.338006-3-uwu@icenowy.me>
References: <20220608070452.338006-1-uwu@icenowy.me> <20220608070452.338006-3-uwu@icenowy.me>
Subject: Re: [PATCH 2/7] dt-bindings: phy: add binding document for Allwinner F1C100s USB PHY
Date:   Wed, 08 Jun 2022 07:45:07 -0600
Message-Id: <1654695907.384174.1272087.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jun 2022 15:04:47 +0800, Icenowy Zheng wrote:
> Allwinner F1C100s has the most simple USB PHY among all Allwinner SoCs,
> because it has only one OTG USB controller, no host-only OHCI/EHCI
> controllers.
> 
> Add a binding document for it.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  .../phy/allwinner,suniv-f1c100s-usb-phy.yaml  | 83 +++++++++++++++++++
>  1 file changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.example.dts:19:18: fatal error: dt-bindings/clock/suniv-f1c100s-ccu.h: No such file or directory
   19 |         #include <dt-bindings/clock/suniv-f1c100s-ccu.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:383: Documentation/devicetree/bindings/phy/allwinner,suniv-f1c100s-usb-phy.example.dtb] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1404: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

