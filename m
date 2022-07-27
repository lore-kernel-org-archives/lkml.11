Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E34C19F29
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jul 2022 07:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiG0HV7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 03:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiG0HV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:21:57 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07CE402D6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:21:56 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id i4so12356592qvv.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 00:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8vEcinysAZAPa9OFx8vPwdOMKAFvJuoa47D1j/eu8A=;
        b=zDtvlLezlvnJBzzhvH7cYxzXql3DyJKSmQvdrFVUj/jIMTwvIxKUC6kazyYuMHU9Nf
         U4amF6oqStzsihsj/Eo7aruHNJb2KlcAG345Hf7zgdcLGPi2hgiY/j413jq8m/M3b6ec
         MVD3dIdRbCZN39w3k+qaiYwqQr381uFWFABVoNvPMi5NQ6v8Y3M7rzRI3cSomLk7zcdR
         0JtMabM2SLXZwZAkhLjDl8w0IlEjbGPsu+iwUNXtWVR8AEcNm5et1457obW7UltZak6K
         qn9lvwaw6JYE/ucSuOgevWSYsIf3aQ2waqd+cJfCI9Wjp5gio+wXUNMI2+9BFiDh6Wkb
         UGtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8vEcinysAZAPa9OFx8vPwdOMKAFvJuoa47D1j/eu8A=;
        b=3I/FgylOIKkD7/sD6UnmiUNUQtaZio9d4g8REwRLL0zlBVSEVFsw+bmitRDub/WuHD
         oiXXsw9I37pPzxVey2JZ3brrFl/QpVaIiwXxB8D1cz/1G3QR2/pV61afeS+J28jQTrAa
         J7fAvP3sWPuhsiRfgh60NNkW+MH7AuecKQVPfFi4OQDduHthwIsebg9fjauDeOdqY4ZQ
         eiEoGMpe1gXX68I2qEATRQ3aaHcZ6TjgWcUcd73JdZsZPyALH3JqvuKEOuJUVAl3KyjW
         uVycVUCbXueQjq4t4ZOUug4vXLxyNetXojWKSYo97tiaoCBh/NmPpTizXOyUNmRYyu2x
         ETYw==
X-Gm-Message-State: AJIora+ol7eYgEzcoFdWmCXCRMT8Iy9Ks0qL5irjQ+XxrmU+lINre2Yn
        KDoG08Z7new9KR8KEWstRiZ2CQvHbp1BEwTUkab/Zg==
X-Google-Smtp-Source: AGRyM1u+p5T1PL1Pc87uhZO+I9O13rtfcJPZ5X2sY8EmM5xnM4Mv+fvfDBCl3BehqoMy9cBRH6+SqHFV9fHM2Nb7SMk=
X-Received: by 2002:a05:6214:2a84:b0:473:2958:2b02 with SMTP id
 jr4-20020a0562142a8400b0047329582b02mr18327863qvb.122.1658906516131; Wed, 27
 Jul 2022 00:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220727065830.10681-1-krzysztof.kozlowski@linaro.org> <20220727065830.10681-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727065830.10681-2-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 27 Jul 2022 10:21:45 +0300
Message-ID: <CAA8EJpr_aW6_+4SXun3FsWtA+sy6zRnbzK7A6FRH5jM0VzFCcA@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] ARM: qcom_defconfig: enable more Qualcomm drivers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 at 09:58, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Enable Qualcomm drivers:
> 1. socinfo driver to provide some basic information about the
>    SoC being used.
> 2. Remote filesystem memory driver (used in MSM8974).
> 3. RPM Power domain (used in MSM8226).
> 4. Sleep stats driver (used in MSM8916, MSM8974 and APQ8084).
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
