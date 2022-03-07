Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40056C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 03:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiCGDZh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Mar 2022 22:25:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCGDZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:25:36 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1034BBA2;
        Sun,  6 Mar 2022 19:24:42 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id j24so13833215oii.11;
        Sun, 06 Mar 2022 19:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=rRMcIDFNsMrHVcQpeNAQgGAzCpgyd1bViwvm+oMJecM=;
        b=PINQ6b7nyVNEH6feh/BgAzCRB92IOhRhHv+LSpr3bJ0A2y59x0r7c6cijmLBqVCx4k
         p9ddD958LiwFP18JEJLUZ+rvXcC3V8387FXkEgzqaDVSvZQuLVEJUF6S1PGaVp9/mIKP
         VdH62GPoB3kqsNV5gD76LegyfMjJlN+Q2VMA6OQaqOyyZ4+nlRNzIXgpjDL5ceCVEABS
         mgxX4mcqFndgrWH/yjxgwy0MTPX8ZfacIqtsHkGXP3pwCcTly/Sc12VaUUZQBriuxttc
         8reWxwbKznixw+M8UOVp54ToJUoV3MoJUixthuYjuDn/bte+AePy/HMSVwaAr70N+cYE
         WnxA==
X-Gm-Message-State: AOAM532VFNgQUzvbktMwZH1+Cn+AYPheKzcIbOG5O1zkncHlWSsBv3RS
        8PXo59onf2j9nrPz1PW36g==
X-Google-Smtp-Source: ABdhPJy42wbu90nS67eyfE8eddlgGnQI0b2lTBeVISHiL1rJAcZBiB7zCyWKHAdFAHxDyc4nxw5SdA==
X-Received: by 2002:a05:6808:2387:b0:2d9:a01a:48a0 with SMTP id bp7-20020a056808238700b002d9a01a48a0mr6340597oib.235.1646623481829;
        Sun, 06 Mar 2022 19:24:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x25-20020a056830409900b005af164235b4sm5556600ott.2.2022.03.06.19.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 19:24:41 -0800 (PST)
Received: (nullmailer pid 1496441 invoked by uid 1000);
        Mon, 07 Mar 2022 03:24:40 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vincent Shih <vincent.sunplus@gmail.com>
Cc:     linux-usb@vger.kernel.org, robh+dt@kernel.org,
        stern@rowland.harvard.edu, devicetree@vger.kernel.org,
        p.zabel@pengutronix.de, wells.lu@sunplus.com,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
In-Reply-To: <1646547036-14885-3-git-send-email-vincent.sunplus@gmail.com>
References: <1646547036-14885-1-git-send-email-vincent.sunplus@gmail.com> <1646547036-14885-3-git-send-email-vincent.sunplus@gmail.com>
Subject: Re: [PATCH v3 2/2] dt-bindings: usb: Add bindings doc for Sunplus EHCI driver
Date:   Sun, 06 Mar 2022 21:24:40 -0600
Message-Id: <1646623480.199192.1496440.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Mar 2022 14:10:36 +0800, Vincent Shih wrote:
> Add bindings doc for Sunplus EHCI driver
> 
> Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
> ---
> Changes in v2:
>   - Address the comments by Rob Herring.
> 
>  .../bindings/usb/sunplus,sp7021-usb-ehci.yaml      | 63 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.example.dts:37.5-6 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/usb/sunplus,sp7021-usb-ehci.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1601662

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

