Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24956C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 21:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGAVBW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 17:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiGAVBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 17:01:21 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DB6B26D;
        Fri,  1 Jul 2022 14:01:20 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id r133so3401040iod.3;
        Fri, 01 Jul 2022 14:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6XLaDjmZpV+39X2SoruSi97P56tMOri9XipqgBnuDRk=;
        b=rqwR/5o0kNKVPYXNxHknXKGcEGw9gyvsZ6SZg7+delVW+wp1Kp6kYEMqTqlyF19+bn
         hLiE5253WQYFRC+CpvdZaJEzqbZXgKaewo+/3j8k6F0F9LeKsd22KBVIh4LkYNhNGlfs
         149kb5VVse30vPBEcRMBaEDjmTJF2L7hvLBBB1hcVTtt+aFAk7JImsizQFgI6FjULI9a
         bFaapURZTDG3Y6yKwg4QmGkw+BWaodi7a3xVMg2+mPKNLcJlV9Akf4P7Ul1ehHrcPHkv
         Ek+XC8iThGlBtPdVPK9G+u5pRL2RJSLM718QqomC6dO/huRPK1FFdFvkggKnWBgmsS5X
         jpmA==
X-Gm-Message-State: AJIora+bMDAaSs4VrV+Ot78C4Ddu9pmT1Mlake0jsRjrOOYhgI0n08SA
        qeu/nTfIu/H7ce8vigVQrA==
X-Google-Smtp-Source: AGRyM1u1GR2b4fia1istnXRyqCOUiDB6GZsCxRVLcN1zAPurCTe1edb599kWiOc1qdgnD/2NF4fy/A==
X-Received: by 2002:a05:6638:218c:b0:33c:9cae:166d with SMTP id s12-20020a056638218c00b0033c9cae166dmr9828247jaj.223.1656709280088;
        Fri, 01 Jul 2022 14:01:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e11-20020a92d74b000000b002d4032b41casm9453149ilq.32.2022.07.01.14.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 14:01:19 -0700 (PDT)
Received: (nullmailer pid 1523226 invoked by uid 1000);
        Fri, 01 Jul 2022 21:01:18 -0000
Date:   Fri, 1 Jul 2022 15:01:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        maz@kernel.org, vdonnefort@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        will@kernel.org, Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: vcpu_stall_detector: Add
 qemu,vcpu-stall-detector compatible
Message-ID: <20220701210118.GA1523163-robh@kernel.org>
References: <20220701144013.1085272-1-sebastianene@google.com>
 <20220701144013.1085272-2-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701144013.1085272-2-sebastianene@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Jul 2022 14:40:13 +0000, Sebastian Ene wrote:
> The VCPU stall detection mechanism allows to configure the expiration
> duration and the internal counter clock frequency measured in Hz.
> Add these properties in the schema.
> 
> While this is a memory mapped virtual device, it is expected to be loaded
> when the DT contains the compatible: "qemu,vcpu-stall-detector" node.
> In a protected VM we trust the generated DT nodes and we don't rely on
> the host to present the hardware peripherals.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  .../misc/qemu,vcpu-stall-detector.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
