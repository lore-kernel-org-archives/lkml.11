Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896BDC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Mar 2022 19:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiC0TDD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Mar 2022 15:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiC0TDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 15:03:01 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B15DB6D;
        Sun, 27 Mar 2022 12:01:22 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id j15so24514656eje.9;
        Sun, 27 Mar 2022 12:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oSZ9o3rrdLDk+/nykPJO7ULpAAzpvgfrHQm7KAVfDx4=;
        b=SoVovB+KUOXNbje/DFq/jLIWd41/VYbAXiOmg38wU8sSSkv8XUtroZ425qk/ktmMf5
         MFl3NPzz1Xiu/3Gzr032+SkM25h3qqIJD5ER0aqei0kbK52o4o+050g7iARLsljFno4W
         Ngqz6K1+BHy1m8mMkEfn18S8gzxEfGOGsbDbU9TcuaSeyD09AQ3uqdstvODgS0bIZ/Di
         R6Ias7YKSnyekE67RtH6wLcpv7rdWbLF8tN40XANS0w0Q5y5W/uymGDwDGBHb48XsXJo
         clNQBLGfldihFdSwM27yjgPlwbx9VyOv/IqruG2Qx0NF88izi3iBKtoTCv/f2NeG2oaT
         JiZw==
X-Gm-Message-State: AOAM5309imTBsQDWxp4Sbif9shvnPIhTXgML0+x76ELXUv1kYgIc/LW3
        HJq7KAZ87rGWs1QyuoszXYM=
X-Google-Smtp-Source: ABdhPJyoNDg+QXSiSpdghTFWR535+B0wbdFJaNGQ+L/T+mFoDxLKKgK1Iet6vj2n3XFyVtUeIxlPGQ==
X-Received: by 2002:a17:906:4795:b0:6e0:78b8:42f6 with SMTP id cw21-20020a170906479500b006e078b842f6mr21528641ejc.88.1648407680670;
        Sun, 27 Mar 2022 12:01:20 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm4911278ejd.155.2022.03.27.12.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Mar 2022 12:01:19 -0700 (PDT)
Message-ID: <59ba4191-2e9f-7fdf-13e3-f1e924d70992@kernel.org>
Date:   Sun, 27 Mar 2022 21:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: regulator: Add binding for Richtek
 RT5759 DCDC converter
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1648294788-11758-1-git-send-email-u0084500@gmail.com>
 <1648294788-11758-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1648294788-11758-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2022 12:39, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for Richtek RT5759 high-performance DCDC converter.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rt5759-regulator.yaml        | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5759-regulator.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
