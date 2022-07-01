Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66149C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 15:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbiGAPdv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 11:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiGAPds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:33:48 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5843963E3;
        Fri,  1 Jul 2022 08:33:47 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id y2so2574970ior.12;
        Fri, 01 Jul 2022 08:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/gtsWZzs11rOAoat2DepGcmoUmhOje1LXQ/dA67hzhs=;
        b=rB/74MUpfBWGEeKH3y80/iVLrRU9kgBVpZOe5pHjH63Osl/IXDfv4THbbwYe04Hwz+
         TTRMN14icD5Sdqc1zjmoJC1VqN3qgN2gQUbR4EqVrG5L6aFMjtNv/kotFqRZ0F3u20Z2
         CY81YHVwplzU3tH6MLqnlbGJVIoaPtunuszgtObZHlHCUfXB2w2o4Bwn7dwMtcyUy902
         DmZtQDYG38qreHfjFU8WHmEw1uago2vvvSJWK6xhWZ9pJYPaOzOnw93AyO/PA1jQhewI
         s6rFWZ/tw1rm+AYzvwmByiwbpQo5jmKemPPwXou1SF3faya12U985s8WLRCgCFv3fK+a
         QL5Q==
X-Gm-Message-State: AJIora8QSi3LDMQ6MuJClpL/oITa/ptDCzpo4nDngMVPAokbNbXjvULn
        2kc6qDgW9NLETbpWLia9VQ==
X-Google-Smtp-Source: AGRyM1u0cmw8U6ymxJ0n788cNCEzWwveFrpkZU/yQQp9+zXJZefi0jFOspR0fLeb9eBJC81Txbb4+w==
X-Received: by 2002:a05:6638:438b:b0:33c:b617:fb46 with SMTP id bo11-20020a056638438b00b0033cb617fb46mr9067086jab.238.1656689626571;
        Fri, 01 Jul 2022 08:33:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g9-20020a02b709000000b0033156d6016asm9908074jam.91.2022.07.01.08.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 08:33:46 -0700 (PDT)
Received: (nullmailer pid 989067 invoked by uid 1000);
        Fri, 01 Jul 2022 15:33:44 -0000
Date:   Fri, 1 Jul 2022 09:33:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>, maz@kernel.org,
        vdonnefort@google.com, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, will@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] dt-bindings: vcpu_stall_detector: Add
 qemu,vcpu-stall-detector compatible
Message-ID: <20220701153344.GA989015-robh@kernel.org>
References: <20220627102810.1811311-1-sebastianene@google.com>
 <20220627102810.1811311-2-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627102810.1811311-2-sebastianene@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jun 2022 10:28:11 +0000, Sebastian Ene wrote:
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
