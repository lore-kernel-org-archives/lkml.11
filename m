Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72020C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 08:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241276AbiCKI7k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 03:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbiCKI7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 03:59:37 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452711BAF2A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:58:34 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 16E263F1DE
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646989113;
        bh=4oWCA4NLKvjSmIF/iS2q4v0RGuN/XnWESBLEc5FowtU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=qiedKUuTHl3gPJIqzcQEEPmz6uJsMPhD0b3peWMCyBbl7oCgJbzAarfwBoB866/s7
         OHY2GNjOJNTTnzQZ/+eBsZbfdxvxl65KX3UXe4On3nlhjYcBJQnFgpJnPzg4kIiP/0
         hqGLPTh6nfieJMdwh6hB6Un7te1+QrXNVXhO5CFTefFL/dexcBYVaB4Kr8eN3LhWMx
         Cbs5asPAMZBNuKQ7QV8AdnvFGPHt1ypi/0H2cpXFk2dxKo98wnM/yKU/BxCwmRMsps
         ccRivZGoTbOXeBUWECK6df07CgoATyWhgaHc2WsyvXIJmW0zIHkrghiWharPbk8i6I
         aSvRtY99kg5OA==
Received: by mail-ej1-f71.google.com with SMTP id ga31-20020a1709070c1f00b006cec400422fso4560978ejc.22
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 00:58:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4oWCA4NLKvjSmIF/iS2q4v0RGuN/XnWESBLEc5FowtU=;
        b=xoTNEOfTtSTS00ZelOehzWKyEvwRNtf+WuLPEWSrFDybQ+cCfyGTE4Fz84LHBnGqra
         /vP0k9ZdJ0+PvyrSpOJrOUTHDHj8CmpOdhMusSNm6yfJYu3QTeIzjmJ4oQbOxoW+JPc2
         G14yqaXNuNdoBbIugmUGzs2fwc2EYfnTxbcIg3c0MeV7gwCfZ/tw6Ar7hFC8FA/iDCoa
         98kMt1UbWC58DuwkzY3LoP3cMmpJP/DiSWMlYNCCszyaniEwFxX+keh00KChzi/W+/Rd
         ZnbjUUdIoBCEFSLhtiEAfYrDmxLQrgEnsWwZxFk70R6YYOzxaDVl5XAxEsm71x1Cdq0b
         Gb0g==
X-Gm-Message-State: AOAM533LUWuOnrOu/g8AJJE7RyvIaVZEi7Q4XUS+XYBK7e7UTBKENnvW
        impxahQQC7VRee58FROFle97i4uiQVRdC7Xmjkp9H8lMkDWBJpYOqFnXkkeFATNV40UrtW9PDHO
        tyYrhaWpGOhl93sadD5sqtuyBV3SZOR8CRXaUHJSEFA==
X-Received: by 2002:a17:906:7852:b0:5bb:1bdb:e95f with SMTP id p18-20020a170906785200b005bb1bdbe95fmr7861548ejm.435.1646989112769;
        Fri, 11 Mar 2022 00:58:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxO1BN5CDGpOVftYD6z0QjOIReFTewAdaLx5yU/nD7h3MjTVXoyy86j2o/DRNBRsU6XYOPTNg==
X-Received: by 2002:a17:906:7852:b0:5bb:1bdb:e95f with SMTP id p18-20020a170906785200b005bb1bdbe95fmr7861521ejm.435.1646989112541;
        Fri, 11 Mar 2022 00:58:32 -0800 (PST)
Received: from [192.168.0.148] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id og49-20020a1709071df100b006db0dcf673esm2742538ejc.27.2022.03.11.00.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 00:58:31 -0800 (PST)
Message-ID: <a6e719f2-2ca1-4ae6-680e-46ec0dd96969@canonical.com>
Date:   Fri, 11 Mar 2022 09:58:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/3] dt-bindings: edac:
 nuvoton,npcm-memory-controller.yaml
Content-Language: en-US
To:     Medad CChien <medadyoung@gmail.com>, rric@kernel.org,
        james.morse@arm.com, tony.luck@intel.com, mchehab@kernel.org,
        bp@alien8.de, robh+dt@kernel.org, benjaminfair@google.com,
        yuenn@google.com, venture@google.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, JJLIU0@nuvoton.com, KFTING@nuvoton.com,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        ctcchien@nuvoton.com
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20220311014245.4612-1-ctcchien@nuvoton.com>
 <20220311014245.4612-3-ctcchien@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220311014245.4612-3-ctcchien@nuvoton.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03/2022 02:42, Medad CChien wrote:
> Add device tree bindings for NPCM memory controller.

Use reasonable subject. You missed the verb describing what are you
doing here. See git history for this and other directories.

> 
> Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
> ---
>  .../edac/nuvoton,npcm-memory-controller.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> new file mode 100644
> index 000000000000..46f61b0806ee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/nuvoton,npcm-memory-controller.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/edac/npcm-edac.yaml#

Please, test your changes. This won't work.

Best regards,
Krzysztof
