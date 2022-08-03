Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA44C19F28
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Aug 2022 06:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiHCGhh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Aug 2022 02:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiHCGhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:37:32 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F229819
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:37:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id f20so17808873lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 23:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3C/lNt77+qlJDztrS8WVjy6lbQy6qfEyINiYOOYnU18=;
        b=OkTTeDdgE1wq3JFHiRmbjgpyqJF9kC+95jnwwzwrKilHNWflwBySJidfMTBFuX1US3
         JLlom3TZgEzsdoeqoGjWDbLUUs/wzgFAasq1I/3bubb/U3cA+rKmxQqyjFFm6Goml4Kd
         yL4A1YBkBsHnJ5jm/nuf9kXHpK+/Wh/bXGqfyfPkqHdEjzw69+Co4UoPHz1VMgo2gXTQ
         n0GGainzh8Hw+TW+JVZ9ockkmlKNfPaTYHI2oNT/mHU4J9H03QGZhyxvdaY0z6pejV3B
         UVlfzuHuwgOOoVEZDOtR0K6eVjW6IEUuWpk30GlQNTScVwvI6zi1tmQlxysqusRscnZk
         PhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3C/lNt77+qlJDztrS8WVjy6lbQy6qfEyINiYOOYnU18=;
        b=BXdY0XQXERXpUcocqS3fZrfavfUd6EiTnRHj/X10XXtXzWa2XIuCjzuDz8l0vOXICX
         2GV0Fp1fBlROT6RBjjgKDDyU4sdpTSAPTc0F8ADDux0ajpp8b9pOaA+u2QbxTywgrWpa
         Xj9s4jP54FSMatHlDwGVoIJWBcMf1Vsrv1M2fsRNCJlcW7gXvZPTfWzU9z09KCEE1eD+
         ACQGCyF7Mvr3/mUY20+R1M3tK12BmyAJu4poaTA+lgqQC24+iWxFXVOfCUrT00loXbZD
         mEZczA5b+ajv4CKzMBfM597H7yFJCm2aUprsqU/efie+QOi5HIjgE7TOF/P5g0q0uONk
         3plQ==
X-Gm-Message-State: AJIora/MnWIU0lN07u+Y67vDHxxPa9cwlw6eJOoW7Vm4zRgqdM9x4biQ
        TTE1Vc0GuFnyV04pPTynbhg0kA==
X-Google-Smtp-Source: AGRyM1s5ZskGPA3x2RfGUG+ZddgaBOYCr+PGg5vqJBsdELbLJDGDQFIGpzGmtTAa7OvrGnkfkkU8OQ==
X-Received: by 2002:a05:6512:3f0c:b0:48a:433:6d3b with SMTP id y12-20020a0565123f0c00b0048a04336d3bmr8447107lfa.570.1659508649004;
        Tue, 02 Aug 2022 23:37:29 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id a11-20020a19f80b000000b0048af437ce87sm1246604lff.183.2022.08.02.23.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 23:37:27 -0700 (PDT)
Message-ID: <f2453080-d71b-3c33-ba8e-d2ed15e06927@linaro.org>
Date:   Wed, 3 Aug 2022 08:37:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/5] dt-bindings: clk: qcom: Support gpu cx gdsc reset
Content-Language: en-US
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1659172664-10345-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730144713.1.I68b749219741db01356a42d782f74265d29a2ac3@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220730144713.1.I68b749219741db01356a42d782f74265d29a2ac3@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2022 11:17, Akhil P Oommen wrote:
> Add necessary definitions in gpucc bindings to ensure gpu cx gdsc collapse
> through 'reset' framework for SC7280.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---

Assuming discussion in cover letter sorts out:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
