Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA72C19F2B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 10:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbiHBKmW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 06:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbiHBKmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:42:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DB922539
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:42:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z25so21375081lfr.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bY01tj6bhjnSTa66elueqqLsj2KRUTIqIMSukoZtaQw=;
        b=a97TlgH47l/AS1nGVT0AYrCAVcEpLmIYQA9LhyxAHRkzibg3GpsAOJx5hzcHKYfUfL
         6zB2NUYACfU03NVqP6Ntiz4BU4+B2udhaR5dbWaiWA5V/H3zip9Pn+Yp2J59l3RDg+Bg
         Op4SqldumjC7042bHpyzVuiGzytgjuJ1M6ZlthX+4E6r9wG6fcdl/nFmnppvCKeJM/1W
         vxQMG1wnfIRjV3b2n+TfDD6lMDCfC47Hd/HUk+QmbdowrJ4OZamhF4rC4ojoq8nvn70d
         8Nw7kK55+P+vf9G7+xJvERRNbngclROd5qzHxn9tgJIGq90HyT8fUa9GqR+1LeT6Ha7l
         Dpdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bY01tj6bhjnSTa66elueqqLsj2KRUTIqIMSukoZtaQw=;
        b=vcFlfzNhq+tuzwXUDDCSzLQGGRUnjQOnPLOojY3FHin3OUyi9mReRB85AM+VYlUWDe
         DvSEvyfM+47/cvJf6e3otzWBYjA8Tj3uVaERjA4+AWVMg3H7kPsNn7ZyFQNUn+hdcm0w
         9F4DW4kHqygP+L9rbcyppyKc3RvQUI5qzoIYcQg0j/Edvm+sCl0ENdTk2k2rkhCV5VQx
         inry8ZGpoS0hXi4RyUzQ8GQFh4Arn5ND6IP/j9tlQXXkjstXcQQNnJpUmCH8nm/FxTkc
         za6s6vAftsjDcvS1f8dYcwhBnvjV+avSSDo0haP876ZftAdhRQApMqYV69kw4TB0PZzY
         TQ9Q==
X-Gm-Message-State: ACgBeo0uk2ilHD7QLBu9qe8lhbRNVrqzlZJfhNQBZVBhR3tU4qvxsS4Z
        OMSszLVTygVN8SYmJUpu2Hq21w==
X-Google-Smtp-Source: AGRyM1tvktEOKcMN0kcHboburZYkTpFq6B9HgJK5w2AHNVauLf3Qm2ECohk0A9nW1L0PEfCOJt/r9g==
X-Received: by 2002:a05:6512:10c1:b0:48a:b8cb:ef2d with SMTP id k1-20020a05651210c100b0048ab8cbef2dmr6884441lfg.384.1659436936306;
        Tue, 02 Aug 2022 03:42:16 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id v8-20020a2ea448000000b0025e2c5a12b6sm1884264ljn.129.2022.08.02.03.42.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:42:15 -0700 (PDT)
Message-ID: <e40e808c-94e7-395c-459b-d2b6428ba2fa@linaro.org>
Date:   Tue, 2 Aug 2022 12:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 03/13] dt-bindings: regulator: qcom_smd: Sort
 compatibles alphabetically
Content-Language: en-US
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220731223736.1036286-1-iskren.chernev@gmail.com>
 <20220731223736.1036286-4-iskren.chernev@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220731223736.1036286-4-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 00:37, Iskren Chernev wrote:
> Sort compatible strings and their descriptions by PMIC-name in alphabetical
> order.
> 
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
