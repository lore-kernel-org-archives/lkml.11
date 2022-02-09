Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8745AC433FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 02:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbiBICmT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244610AbiBICNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 21:13:00 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41FBC06157B;
        Tue,  8 Feb 2022 18:12:59 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id s185so1094891oie.3;
        Tue, 08 Feb 2022 18:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r5gCY8AxP7VeaG+k6jS1gI6uSgHlAryZ8BxlEn4k9Rc=;
        b=UkJDCfwIHyquATNakP/z4pc3wpMctudxOoWr99WRIkYJ86bpMO4rZLW6O9pD+4BzD7
         bW1ctiFAM/A0eocviRtEf7TYccxzKjpWo4Vel2hXmq9xbsl2MrDFXeExXbP8+aptAqhV
         WLh0fnXDgq01NchIzgtwLTXHoPnxUwwROm1AKPBRkpAE6/mJzqoNUoNVcJ2Mx7qWoXHs
         1WllZL7bEMhl9Hq+kPKkN9tn1ZbHQIj/XB0sV8gs806OO4GEIY+9ughTgIrJidCTs9YZ
         Y/gW0PY3P/oByQ1yNgyjw1U+7O+byHIFXP6fPlSj2AiuPcRwvIXa92XQueXoF4HOARfl
         Bg3w==
X-Gm-Message-State: AOAM532z9k6zqLugve1jjlOMjX8dAzlsISBzDU2SYjs38xXY4BKlGTRD
        Ms9fIqXqwkFhL2rVdHpbtQ==
X-Google-Smtp-Source: ABdhPJyybaBExBPo3whsZHrm5eZwynXqvVsKrJ51MSnzvXPpLlZfZ5bu+CINFJwXbnhU5wvMT7zyTg==
X-Received: by 2002:a05:6808:148b:: with SMTP id e11mr390463oiw.163.1644372779024;
        Tue, 08 Feb 2022 18:12:59 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v26sm5989448ooq.20.2022.02.08.18.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 18:12:58 -0800 (PST)
Received: (nullmailer pid 3465770 invoked by uid 1000);
        Wed, 09 Feb 2022 02:12:57 -0000
Date:   Tue, 8 Feb 2022 20:12:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 04/15] mfd: qcom-spmi-pmic: Add pm8953 compatible
Message-ID: <YgMjKSNEpTLe8tsE@robh.at.kernel.org>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
 <20220112194118.178026-5-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112194118.178026-5-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 20:40:53 +0100, Luca Weiss wrote:
> Document the compatible for pm8953 as found in msm8953.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> Acked-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
