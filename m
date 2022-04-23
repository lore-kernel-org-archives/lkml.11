Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D1FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 14:06:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiDWOI6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 10:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiDWOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:08:50 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5342420BE5;
        Sat, 23 Apr 2022 07:05:48 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D902922239;
        Sat, 23 Apr 2022 16:05:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1650722747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V0S/oc+wXadYAn4cvpMWVcNVtpYPXcEJ8ZqN5GSnQSY=;
        b=o9xt9autRqqT6wiRcf57ZmdCkCJFYoHHx5vLUVm9StUUMq05RSMSSQWpgiRRfRILEA8K1c
        P5sUwdJ4u7wGcAPrgvCgJmXL2n2iJbEjy1+TuMu7gDDFt1WzYTeydn0Qm0nvEXaXSXZVhE
        V8MmGrD0D6b7mp+qugFpkqyMh/1j54c=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 23 Apr 2022 16:05:45 +0200
From:   Michael Walle <michael@walle.cc>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fsl: convert fsl,layerscape-scfg to YAML
In-Reply-To: <fb8c2c57-38bf-065f-a781-beb2fb89353e@linaro.org>
References: <20220421153115.3496834-1-michael@walle.cc>
 <fb8c2c57-38bf-065f-a781-beb2fb89353e@linaro.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9c8c910e62b6b8a674ee0f2c752b6479@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2022-04-23 12:17, schrieb Krzysztof Kozlowski:

>> +patternProperties:
>> +  "^interrupt-controller@[a-z0-9]+$":
>> +    $ref: /schemas/interrupt-controller.yaml#
> 
> Do you have a specific FSL schema (bindings) for the child?

Mh, indeed there is the following binding which I didn't notice
earlier
Documentation/devicetree/bindings/interrupt-controller/fsl,ls-extirq.txt

So I guess it has to be converted before this schema?

-michael
