Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C85C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 12:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiEWMyG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 08:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235740AbiEWMyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:54:02 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76018B37;
        Mon, 23 May 2022 05:54:00 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id c15-20020a9d684f000000b0060b097c71ecso3106797oto.10;
        Mon, 23 May 2022 05:54:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jq8HRtHzCtz/J4InLS0fIGv9eW9x4bTUmADGdhjM00s=;
        b=LK/XY3IhpGYkxjB4uAkdFwnaziUwsznJv3dLYlZtjbeKNwN4N6zRF/1BBYMKn26dC3
         C16EnL788pa0XZhtRmzWjqSDwc4MC7BMXq99ipC9SVSYaeFiAIIRFrNRjiEO0x0QAFue
         45fz1mtC755ulCVsEJXI4XmLI7xM+/eF38CZmmOQn/cchK5hI/h8Xid+mWFCxOoahpkU
         I5L2iuKeMmvHphn96XK9ioU2QU8zG+6qZvk4B6JSzgUfK9FRjJ2QiEmfXtBTgs5pwU0Z
         S69FBtK5lpmETWq0KULIGYCpKgqToYbUDcwH01G4oR0ea4uzozQhUpptJL6SSWRijRB4
         500A==
X-Gm-Message-State: AOAM5321gGE88wENTh+/YdMaClX6HT1RTJuGEjcVLIDe2M9GPnjSAl9G
        GIK8t070WTWOrmTwkOPNGw==
X-Google-Smtp-Source: ABdhPJxUIH55xkr7wZoXAk0lXYAGkICZiyq04nvXGCbndkBSHCQ2U29sAGiC94do7VnDkG4ApPB8EQ==
X-Received: by 2002:a05:6830:619:b0:606:a6d2:db5c with SMTP id w25-20020a056830061900b00606a6d2db5cmr8704533oti.85.1653310439471;
        Mon, 23 May 2022 05:53:59 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z11-20020a056870e14b00b000f1a2378a12sm3752093oaa.37.2022.05.23.05.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 05:53:58 -0700 (PDT)
Received: (nullmailer pid 1409363 invoked by uid 1000);
        Mon, 23 May 2022 12:53:57 -0000
Date:   Mon, 23 May 2022 07:53:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: Convert CoreSight bindings to DT
 schema
Message-ID: <20220523125357.GA1385486-robh@kernel.org>
References: <20220520214416.302127-1-robh@kernel.org>
 <20220520214416.302127-2-robh@kernel.org>
 <f2073815-3302-d092-5a94-61dcaf72e29c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2073815-3302-d092-5a94-61dcaf72e29c@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 04:54:48PM +0200, Krzysztof Kozlowski wrote:
> On 20/05/2022 23:44, Rob Herring wrote:
> > Each CoreSight component has slightly different requirements and
> > nothing applies to every component, so each CoreSight component has its
> > own schema document.
> > 
> 
> (...)
> 
> > +        const: arm,coresight-dynamic-funnel
> > +  required:
> > +    - compatible
> > +
> > +allOf:
> > +  - $ref: /schemas/arm/primecell.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: arm,coresight-dynamic-funnel
> > +      - const: arm,primecell
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  clock-names:
> > +    minItems: 1
> > +    items:
> > +      - const: apb_pclk
> > +      - const: atclk
> > +
> > +  in-ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> 
> Shouldn't this be with unevaluatedProperties:false?

No, because the ports definition has 'additionalProperties: false'. That 
does mean port nodes aren't actually restricted to 0-7 in any way. Not 
really any way to fix that other than listing #address-cells/#size-cells 
here or a pattern matching disallowed ports. But I think the limit to 8 
is just current implementations and perhaps practical limit of how many 
streams of trace data can be combined.

> > +
> > +    patternProperties:
> > +      '^port(@[0-7])?$':
> > +        description: Input connections from CoreSight Trace bus
> > +        $ref: /schemas/graph.yaml#/properties/port

