Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60796C0502A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Aug 2022 12:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiH3MXl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 08:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH3MXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 08:23:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB180AA4C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:23:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id z29so6714354lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 05:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=y+/lGnJaLJVLR/XaO70T/uhmEN7c6IdO5d3GPBmHeds=;
        b=hATx49Joh9431NIAdfNrQzJR0lVJBUwK7hXK++ckvVE5EkWj+nWBXjt1yjto6nGQqI
         wCghFaNbOIj8ihHoNxPNX8LwqV0z4lx3xjJ2M2iYZDA1wB2/A5AZ9225bLdtrv/XhsoU
         oJN5mcT+ejwrn4dHCtuNkpDJVg7TmksCXyiZRNCxD2kENWW6LxjYFyrMkb4+LkSNVW9B
         Qn8cnhguOZUUrEm8I/GpSkTZExGxrpGLGBUX8m3qkw+NeSevx4MvQ4kGvsAvJbUQ76Bg
         JSq4fKDOoMU9ru9iRAEdYlWqZiLDKvzizz3Zr1FdFqov54UtNl+nAVQtb4vBFNUHlahM
         oFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=y+/lGnJaLJVLR/XaO70T/uhmEN7c6IdO5d3GPBmHeds=;
        b=CrqYOlPMzteWhZC/YhMm9MBeB/z6UCpM3bhXdojP2v/fWwHBwcs2dAqMbMf6kDGjkm
         MLsFMjjs2iknPY2qe/fzmFFX9ibjRY4D7vWaJjz6haebRw20GSJSXT4AZMWWmQm3J3PF
         Sl6UvCZklxTXKmitGdryqCitySy1+5Mq58nKSKMrdpbhNEo+PJ+wFOyIVQrba6cTj2ZS
         gdOhnAtwwTfkXhKi2WWfRbyASv5hnz3FwEG+fe7jAvwpNXPINsdPF3vHweWikRcix1xu
         VUbCp02zHIKZMo2LjGDZA7frj6CdQ+DcIz8XUw2Fj1/Djef62Oe5/C8DZlQBNKwHpLI3
         Y7Lw==
X-Gm-Message-State: ACgBeo0je9Vjqcg6wIKmWBzaVzjSx8po7l16QgYvyzxL2JBjMgZDH8Gs
        jlMsFcELGEIKYYrvgOkJ5AGpFJi3p+ASldQc0x8=
X-Google-Smtp-Source: AA6agR7dXQW8gkolpt7JptyYL/LhrZI7w32wgREH0RNo8r5Fl+4KO+v7jfL4X2VaeQ//NVdH2AWfqw==
X-Received: by 2002:a05:6512:3086:b0:492:c1e7:f5be with SMTP id z6-20020a056512308600b00492c1e7f5bemr7874153lfd.454.1661862210080;
        Tue, 30 Aug 2022 05:23:30 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id u22-20020ac258d6000000b0048afd0c496fsm1599913lfo.156.2022.08.30.05.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 05:23:29 -0700 (PDT)
Message-ID: <150c46c7-7de3-379d-4c8b-b94f81f2b860@linaro.org>
Date:   Tue, 30 Aug 2022 15:23:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: qcom: Document additional skus
 for sc7180 pazquel360
Content-Language: en-US
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
References: <20220830112013.v2.1.Ic4d4e0777115011544dbc2ab07ed4d7b408c003a@changeid>
 <47910371-6356-1040-1073-c50fc87b9d04@linaro.org>
 <CAFvdKjsEwFcs7HuhOrx4RBqmAP3DrA5bm6f2Y7MYGZ4gr5=Ehg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFvdKjsEwFcs7HuhOrx4RBqmAP3DrA5bm6f2Y7MYGZ4gr5=Ehg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2022 15:20, Yunlong Jia wrote:
> Got it.
>>
>> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
>> ---
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>>
>> (no changes since v1)
>>
> Is the above format correct？


The above is not correct. The one in this patch was okay.

The comment was about resending four times the same version. Read the
docs before next posting.

Best regards,
Krzysztof
