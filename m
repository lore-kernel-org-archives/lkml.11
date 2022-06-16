Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590ABCCA47C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 20:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378958AbiFPU6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 16:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378921AbiFPU6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:58:45 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAC22A707
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:58:45 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q140so2288138pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i/ID+pDiSzzMuJuiQpKwiHmsa9j1VcPIYRxj1Z2pw9I=;
        b=u/1l0Eoiz4R0iMnssEAD/HtH1dCWVB0z0UAaSkzRk9jPWafYOFWXfmo/obB+39E8/E
         lUv4bVzuvdkm6ytXHLa05IQuuXILc5gZDC6wrp5thffAuTNIym/2zKmQWxgPcFq2YvSg
         A3uLcEhjJ3cpaIuIdoz5XxO62xsLQHVXEuB61bmwvDs0MiUgqs+L3pX57ZVq/S5b9SLV
         7n75wErkeo/kNk5/yxk0hZz6odF45+7Mw1G4TnKQiSaKvbeylZfyhagqmJqJ50iqE294
         +zkBwvZ9EnwaT/ajH/waktJHPWoten4mouaS/nLmcsmKsUbgCDp78LrS96G1P44b/A6K
         maXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i/ID+pDiSzzMuJuiQpKwiHmsa9j1VcPIYRxj1Z2pw9I=;
        b=uLsK7IpMYUADd20xlxtd0qAwnMHLbCvBZt+6E9NVb5NdW7eXwWgRr2pjbWZQHIj4ev
         KItZ6OOhMbuH/8BqP5Rp848R4ol7eQve8ym0L4WdP2qh1g0P9TJQjZ/N0Os1YaDD8hvp
         qFMc2EQ7SeWHxWQYHA5mJbx0yUS2AjdZaEfOI/a8/WUSeFN4wET9Rxsgtac+9jzsqYxm
         OCRjvZie+dUVXnTCpnWjs/nHOCb0ZHCiPJoSuvTpDhJ/6jNCyKGk268LCIoSfak4YkF9
         4vqmq+9AIvBvb5PIEewEOWORQNh4xXlNvGEoqmhGn5WmHonFKCTCGxNVweKQ7HCEL4q5
         PEKg==
X-Gm-Message-State: AJIora86FVQWei77KddFMYNRt/3RlSwL8Lp9wj680pYcHruGQHLg+tu/
        lnZw3hglTfpZhgQrESOnf3QxRA==
X-Google-Smtp-Source: AGRyM1vOz2Afkti6mlOah/khUmgMyLaPLcgaTVa4kk2bxbz2YytR62NITJ+OJBzf1zpxhYbXtZiOmg==
X-Received: by 2002:a63:8642:0:b0:3fd:a160:6724 with SMTP id x63-20020a638642000000b003fda1606724mr6041960pgd.506.1655413124744;
        Thu, 16 Jun 2022 13:58:44 -0700 (PDT)
Received: from google.com ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id cp17-20020a170902e79100b0015e8d4eb1d5sm2082190plb.31.2022.06.16.13.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:58:44 -0700 (PDT)
Date:   Thu, 16 Jun 2022 21:58:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Subject: Re: [PATCH V15 3/9] dt-bindings: mfd: pm8008: Add regulators for
 pm8008
Message-ID: <YquZfQ3HRQ1FLBkt@google.com>
References: <1655200111-18357-1-git-send-email-quic_c_skakit@quicinc.com>
 <1655200111-18357-4-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1655200111-18357-4-git-send-email-quic_c_skakit@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022, Satya Priya wrote:

> Add regulators and their parent supplies along with example.
> 
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in V15:
>  - None.
> 
> Changes in V14:
>  - None.
> 
> Changes in V13:
>  - None.
> 
>  .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 50 ++++++++++++++++++++++
>  1 file changed, 50 insertions(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
