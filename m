Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775FAC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 13:34:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236715AbiCRNfa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiCRNf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:35:27 -0400
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F2C111DFA;
        Fri, 18 Mar 2022 06:34:08 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id w12so14105038lfr.9;
        Fri, 18 Mar 2022 06:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KhDv91PxFYgSkqcUvNWoeCSYMAJKbkYHzPzcZD3bfZQ=;
        b=OCM/3J+h4x86f34CufIBP/6oPCFg5B4OVlbnqivOmVP2g2Z59nj9jQHUneLtxrQoIh
         zT5neoZvMpjwYlFsnsrHbWT55DG+1CgxBTJt4q9oukKgUV4o5raS141k2wI/bGyTtgNd
         /cKi+XBdlvdSO1I5sEKPHa5EhYbadVpM0T/gK31/seBQaWecu5LXFS3MYZvnKf5pG+zx
         MnflFItzwjzi57P/oPXWhRGMIGQX1dGMDlNkQYjMOfw/KdGe/7fIzhaU8oomJ9xyoeas
         KC4glOi3ssRZM4Oy2cpnIn1j5N2VfRwzYAcj+LDWKdPznrWbWGkbn5XuTTvIGP3NYJCR
         OL4Q==
X-Gm-Message-State: AOAM532qxBpMoLUIIWtSIgyat0XJrES8zwgKIjoBBMSOseqf9vF6A3NG
        FUNpXUwxdbKR7TJlpSJ1Mf4=
X-Google-Smtp-Source: ABdhPJzAX4hDzXlaImfjCBv77mcTgemyobKhvOpkMxrbOwUEhyizr85lnjxT3MWNPqa9YlT0XnMXzg==
X-Received: by 2002:a05:6512:992:b0:448:2e2b:d452 with SMTP id w18-20020a056512099200b004482e2bd452mr5743658lft.632.1647610446550;
        Fri, 18 Mar 2022 06:34:06 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id c1-20020a196541000000b00448bcdccb91sm757200lfj.231.2022.03.18.06.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 06:34:05 -0700 (PDT)
Message-ID: <fba6c4c7-8b81-de9b-5361-c0dfe9e701db@kernel.org>
Date:   Fri, 18 Mar 2022 14:34:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/3] dt-bindings: arm: fsl: add toradex,verdin-imx8mp
 et al.
Content-Language: en-US
To:     Marcel Ziswiler <marcel@ziswiler.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Li Yang <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220317160122.341484-1-marcel@ziswiler.com>
 <20220317160122.341484-3-marcel@ziswiler.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220317160122.341484-3-marcel@ziswiler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2022 17:01, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Add toradex,verdin-imx8mp for the Verdin iMX8M Plus modules, its nonwifi
> and wifi variants and the carrier boards (both Dahlia and the Verdin
> Development Board) they may be mated in.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
> 
>  .../devicetree/bindings/arm/fsl.yaml          | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
