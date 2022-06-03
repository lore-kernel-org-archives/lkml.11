Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6172EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 07:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiFCHeF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 03:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242565AbiFCHd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:33:57 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E4396AE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 00:33:49 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h23so3225415ejj.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 00:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M10o54sTZvRy17C3pDC23gX+CuR4aMGD8UzGX2WMoMQ=;
        b=kFDEaqUzl3hYfbJ0sxUumnEbCBnKfF+EOl9AvTzBjiuP4XKwPl+nZlvehW7y3VE8PG
         lNRjXc8N/vvsf040kvBQZzeaCgcCEXygqygB0wQnAeN4KDjKFyjtxFa6BfJ+Pu6hM+8e
         mXoSRz9aKys+M9uf6lGJRigGkH6K5yZH2PwwWo/kaFzXetUNUP+GnZtr2PvXSASpeKgj
         h0sBACxcQiXTdr5pDPjehv4ljtGY3hY5eK/RiHadB0gXjg/recI9vsJZVuVu7KryAvZa
         8beSCB4hK01FSCxfptrKX7fLr4jWYErOYnYtXpkxMZJIHTKPO3mt9W/MJ6KZXhpXQGb8
         pXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M10o54sTZvRy17C3pDC23gX+CuR4aMGD8UzGX2WMoMQ=;
        b=VR1vUpyRsAx89vHf5zpLV7JGjSyNiwEX64NwfijKWoTSoeRHe/JRXIaf1fC00MkIxn
         ZMOEjDddNlJF0mEsPfQ8fRlflGsTnhMTA3xC47QU5FwVgB9f4DzEBVoUJcXu9LNY97+k
         /HhOAT+APfm9iKc0InxVCTjtc5tinVa4YRemx3cBBqXBrEYMH1CSA5bLouiYv9VdaMBp
         oaELGOUObZ5rgnsy16N3dS+LmaOZgcxg/vUOvHXyw4F7/0jSjhu7Q/37nUDv01V6xqTk
         KpWT96y/x1PL6gA+RkVjxxqkb4TBMCSKm+T/AaSSEhT/vGYKwrDWvulxNXb0I6PyFZvD
         /ohw==
X-Gm-Message-State: AOAM530eB9OJGGudQaPscl+VuSIRKGsh6yqynHjba7koIIVDWc6TYPzU
        pA1FN7qcqvrLGQu7qDq1b0asAg==
X-Google-Smtp-Source: ABdhPJw/l8CtC/oAgwkZakL9NahA1dUU5X0+2D/Z6/uAlo7dulXIk0x+O/uittuON2sFQiK9v2K8yA==
X-Received: by 2002:a17:907:1c8d:b0:6f2:eb2:1cd6 with SMTP id nb13-20020a1709071c8d00b006f20eb21cd6mr7282450ejc.568.1654241627415;
        Fri, 03 Jun 2022 00:33:47 -0700 (PDT)
Received: from [192.168.0.181] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id t26-20020a17090605da00b006fe7d269db8sm2535595ejt.104.2022.06.03.00.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jun 2022 00:33:46 -0700 (PDT)
Message-ID: <6a421c56-0616-c61a-608c-2907faeff424@linaro.org>
Date:   Fri, 3 Jun 2022 09:33:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] dt-bindings: Update QCOM USB subsystem maintainer
 information
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, gregkh@linuxfoundation.org,
        bjorn.andersson@linaro.org, kishon@ti.com, robh+dt@kernel.org,
        agross@kernel.org, vkoul@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com
References: <20220603021432.13365-1-quic_wcheng@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220603021432.13365-1-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2022 04:14, Wesley Cheng wrote:
> Update devicetree binding files with the proper maintainer, and updated
> contact email.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>

Thanks for updating the email address!

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
