Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5AC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 20:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245733AbiCJVAI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:00:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245041AbiCJVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 16:00:05 -0500
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C116DDB859;
        Thu, 10 Mar 2022 12:59:00 -0800 (PST)
Received: by mail-ot1-f51.google.com with SMTP id s35-20020a0568302aa300b005b2463a41faso4901057otu.10;
        Thu, 10 Mar 2022 12:59:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KY8vboNBmqrfG0d73imgH39eTc9TfJDXwkAlFPUH9vc=;
        b=t2IXZR4wxmUsjfVVIt+ZXBe/etuSSCckKTev7KfG1UoqmUn6jzZerWgpwYRh/7S0wU
         fP2G36gV1zxQEI1BQPp9IEbmGEYYEkLFZ9xVqeKuhg0CiHmoKLqQlZSak/aNfVymVkCy
         ktwFpqbIgQxknIe7SL0EpIEaD3xUd9m3+7ukCxLILrh1j7QacY2bS4k6xPT8k+p+97ES
         kxU7wmuSgYjT+ms4HWcxTTwF01SDfJIskJxIWZN4l9loTLMrlHZiMSGL7/QxZqW8HMoI
         Tn9wyswLBZj0FvnsIgJKFEGrczJWj6pyisVFeaWZ66TaKAb3uU4RaCapmk5+GeHXxBh/
         CTXg==
X-Gm-Message-State: AOAM530e0OkS+Axp5Ji0wn+rcj0IvHdGX5bpu5lAZC9Y1Ztfu1uAdgg3
        BZrgmgLVohwOlExftOvLYKL2PfEMRw==
X-Google-Smtp-Source: ABdhPJweLHgVJP/ACLxeR6y+GKz1ica7nyWcDw6WwkEkwllJY8ExbXdnGbaAQa1EOxVBGQr9EAhM2g==
X-Received: by 2002:a9d:2ce:0:b0:5b2:1513:4997 with SMTP id 72-20020a9d02ce000000b005b215134997mr3460310otl.278.1646945940049;
        Thu, 10 Mar 2022 12:59:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q189-20020acaf2c6000000b002da32f2035fsm2768709oih.2.2022.03.10.12.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:58:59 -0800 (PST)
Received: (nullmailer pid 2058933 invoked by uid 1000);
        Thu, 10 Mar 2022 20:58:58 -0000
Date:   Thu, 10 Mar 2022 14:58:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     vigneshr@ti.com, richard@nod.at, miquel.raynal@bootlin.com,
        joern@lazybastard.org, kernel@axis.com,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, frowand.list@gmail.com,
        krzysztof.kozlowski@canonical.com
Subject: Re: [PATCH 2/4] dt-bindings: reserved-memory: Add phram
Message-ID: <YipmkgOuLZGVqH7S@robh.at.kernel.org>
References: <20220307141549.2732179-1-vincent.whitchurch@axis.com>
 <20220307141549.2732179-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307141549.2732179-3-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 03:15:47PM +0100, Vincent Whitchurch wrote:
> Add bindings to allow MTD/block devices to be created in reserved-memory
> regions using the "phram" driver.

What does 'ph' mean? Please define somewhere for the binding.

> 
> This allows things like partitioning to be specified via the existing
> devicetree bindings.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  .../bindings/reserved-memory/phram.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/phram.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/phram.yaml b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
> new file mode 100644
> index 000000000000..92e7a80ee87a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/phram.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/phram.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MTD/block device in RAM
> +
> +description: |
> +  Use the reserved memory region as an MTD or block device.
> +
> +  If no-map is not set, cached mappings will be used for the memory region.
> +
> +maintainers:
> +  - Vincent Whitchurch <vincent.whitchurch@axis.com>
> +
> +allOf:
> +  - $ref: "reserved-memory.yaml"
> +  - $ref: "../mtd/mtd.yaml"

/schemas/mtd/mtd.yaml

> +
> +properties:
> +  compatible:
> +    const: phram
> +
> +  reg:
> +    description: region of memory that contains the MTD/block device
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        phram: flash@12340000 {
> +            compatible = "phram";
> +            label = "rootfs";

That's an odd example...

> +            reg = <0x12340000 0x00800000>;
> +        };
> +    };
> -- 
> 2.34.1
> 
> 
