Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8F6CCA48B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 22:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237200AbiGYWgU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 18:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiGYWgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 18:36:17 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3728D22BDD;
        Mon, 25 Jul 2022 15:36:17 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so9740990otk.0;
        Mon, 25 Jul 2022 15:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eyu1crtWTSJ/wKktKn2bCD4mtqeJsq4ok+GmCcS2Uj8=;
        b=ZqNS4FeTfJCGeDjFyWEkfhBvXfKsiyxMOxekUrwpDIW6AtZGwRo2OwGpGARqjdCZ64
         mTAJZBbK/7Ezjlb2XPQmRiak1f/aN3g4uCEzO2PQvCw0mIeFlPOZAGGMt79T6bbqa+I+
         nQo5KA1N5GbIKV923HLPJd1V79lR/VrrlnQ5w9OOXOmYZ5hf/nbzbRZskztv/xHidWkg
         Wyjc2Od4UNKfLC6lHFaIV7EJCgn4Kaydm2yEfEpbwjRo9BoyWcfvjxlYbMgsswGWn0K3
         tVKDqFMxdMirFjk5DZCIcSN5dri7XBMh4HHeHbZMFWgmLU5gKTOfTOiy3bO6I7dMINHo
         U0AA==
X-Gm-Message-State: AJIora/h7/jFBxZh32RPHf0FxGJ8bxAqUsxpydWgc6HyyfP/4nTMSHvw
        /fFm4kDfY3lvnhYacg84EYFoSPVe8g==
X-Google-Smtp-Source: AGRyM1u0StGZDbuF9HoXEonCaBjVakg5NTUPPyrimmOjlELkzV3g/A4DSewECV8OF0DROTxFxF9t7Q==
X-Received: by 2002:a05:6830:1e77:b0:61c:80d2:1a66 with SMTP id m23-20020a0568301e7700b0061c80d21a66mr5456908otr.214.1658788576431;
        Mon, 25 Jul 2022 15:36:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id n8-20020a056870240800b0010d7242b623sm6597056oap.21.2022.07.25.15.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 15:36:16 -0700 (PDT)
Received: (nullmailer pid 2871903 invoked by uid 1000);
        Mon, 25 Jul 2022 22:36:14 -0000
Date:   Mon, 25 Jul 2022 16:36:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cy_huang@richtek.com,
        linux-usb@vger.kernel.org, gene_chen@richtek.com,
        heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux@roeck-us.net, robh+dt@kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings usb: typec: rt1711h: Add binding for
 Richtek RT1711H
Message-ID: <20220725223614.GA2871870-robh@kernel.org>
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
 <20220721061144.35139-2-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721061144.35139-2-gene.chen.richtek@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 14:11:39 +0800, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add binding for Richtek RT1711H
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  .../bindings/usb/richtek,rt1711h.yaml         | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
