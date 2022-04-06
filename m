Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FE6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 17:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238866AbiDFRYp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238768AbiDFRYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:24:33 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0414B4BB6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:23:12 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-d6e29fb3d7so3248256fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=hiSfOStXccjbf1AYzjiGRDT1g1SFjOKXyv+eLAAqR4I=;
        b=S8QZvZFAQKRsGAYTUOeGLbGgTqU9p6NgODt08xv+GJQH6OOxo3vbZVmfWMHv4CQsrv
         sreWgOA4uSXOeHZ5H4VFNs55oW3/EjipqQkJxdYnWoYkoxWoERMNuYKEBMxwI2KmYcWG
         PGRDKJx7La2RUWEju8pyKfnGl4dktn6Ha0V5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=hiSfOStXccjbf1AYzjiGRDT1g1SFjOKXyv+eLAAqR4I=;
        b=ZXdko3VPc7ybGMq365MWIy13P2OR1ijPiww7fLHRCiRPfWBl4RG+XTDFfxSlpRvs3m
         aXKxuo+x9Tnf8tIxIonPkQiNui43C5AZ8ctcLP7Mw8eJyw8Pb2eGCuS5RD31DqBwdUf8
         8KCj7arLvoGc3h6VXFu7/K/rj2I8ss0tfJX4JTAu/HAxtspPuTb4/0BAxJ+8lltygW26
         c4pIeMhWMgp4jrd3/5rnYzBYj9XlAK5N4N7NOuJV50XQ+1ZCU024rvStaXOuY6dKyS+y
         Ki/SML12S8gkwsWLTbIT9wSerJfBYJBvN35ZbZ9Q/NroGB2fREfUPQrauUIn0OR+fW6Z
         99uQ==
X-Gm-Message-State: AOAM530USN1gm3VZI9IpqBngOmo3cgtfhz1iUSgxqOK4ZnvOEA0KIVrU
        Xu6qKm6qY2nc/kzuTaONLSCszpGO7jd6NlbmGr+/JQ==
X-Google-Smtp-Source: ABdhPJyAXhv6StedGOtJuWf7fO5MgYIPzySA3+7UPCtieqRLefs7juSZxzHlMkcvHchGKDyCITgazKVuobCc5PuwwYA=
X-Received: by 2002:a05:6870:e314:b0:e1:e5f0:d777 with SMTP id
 z20-20020a056870e31400b000e1e5f0d777mr3969864oad.193.1649258591945; Wed, 06
 Apr 2022 08:23:11 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 6 Apr 2022 08:23:11 -0700
MIME-Version: 1.0
In-Reply-To: <Yk1B4f51WMGIV9WB@sirena.org.uk>
References: <1649166633-25872-1-git-send-email-quic_c_skakit@quicinc.com>
 <1649166633-25872-5-git-send-email-quic_c_skakit@quicinc.com>
 <CAE-0n53G-atsuwqcgNvi3nvWyiO3P=pSj5zDUMYj0ELVYJE54Q@mail.gmail.com> <Yk1B4f51WMGIV9WB@sirena.org.uk>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 6 Apr 2022 08:23:11 -0700
Message-ID: <CAE-0n53Cv_bR92M64dhdnDge_=_jeOs4VZzDhUkksN90Y7rgog@mail.gmail.com>
Subject: Re: [PATCH V9 4/6] regulator: Add a regulator driver for the PM8008 PMIC
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark Brown (2022-04-06 00:31:45)
> On Tue, Apr 05, 2022 at 02:09:06PM -0500, Stephen Boyd wrote:
> > Quoting Satya Priya (2022-04-05 06:50:31)
>
> > > +static struct platform_driver pm8008_regulator_driver = {
>
> > Why isn't this an i2c driver?
>
> It's a MFD function driver isn't it?

The DT binding shows a single i2c node at i2c address 0x9. The
compatible for it is "qcom,pm8008-regulators". It looks like an i2c
device that is dedicated to providing regulators. I'd only expect to see
an MFD if the device responding at i2c address 0x9 supported more than
just regulators.
