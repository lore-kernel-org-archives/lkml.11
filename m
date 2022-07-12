Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B109CCA47C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 10:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiGLKIe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 06:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbiGLKI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:08:28 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C036FAB6AB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:08:26 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y11so6572493lfs.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9tmI5itLo+az2NBT8yzH/XgEsrNR0rdSvtFYImf7rvM=;
        b=jGL3yWUVHDyLo2mditJsLo9eZwQRwOlRMs1BOzwXgQgMl9VZKiWusZB3OL6+6pe1T3
         1/kprO7Bg7O0JkhTVP7syWIF3fjkfFipAOfKIwsyREqj+gEs++uY4I0EC3riNWSg7M6+
         wJpFMibQKKtpc2ChIZY33TAZyZekuEStAadNkqP0WmUB9+8kFaHVZnWgkhH3deTvqAnL
         +LgiC3Fo2/ThdhQrS7xXtyUVhEFsjxNqdx0oAfDe+QL/gmUNMtTrINMQ6jSep5gtwNNx
         S39Kw2Dp3bBW9Q8PGyofZ4rtXUpXOWvys+Ylgd6faJUOluLru5+mTt8DhZD9NlgbdtTj
         bvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9tmI5itLo+az2NBT8yzH/XgEsrNR0rdSvtFYImf7rvM=;
        b=g6abZyYZvfdFXkSIKd9sf35jz812ZxZkobBKZcdUAzXgHymDDAv+DTeDh1XEexO5WK
         weJ1+vJy/l0MCaNavTbsc0xYvYt8Ia9XtFRsqYbAomjSfq/9x9loFap6NkyAui/gEeQ0
         MvTCGihFCMjQDIFUL7l4kgzG4id+iXL9Wn+EI6Se6UcJSRvBi7vgR6YteXqof9d820L4
         /e4WjSD3DbdmmjUYOYimonB6fcad+7QurrOHJvir4HQCEHmGEnNcMhrVzlH6dUnTEXJB
         LQdM0XLNhcLQjQaMHZ0/VC1HOkSCfmblERwJPRthcGwiYWpv4nEkFGMJPofxLgxZK5gO
         2m+A==
X-Gm-Message-State: AJIora8Xyic8YJMMVZtdG9KHkjIUUnni6vuOa/QfJjOXggXNHGwRrpQz
        7LJ/EtCEmoZUDhau4nHjW9lSoA==
X-Google-Smtp-Source: AGRyM1v7YtW6PNha688Ly/qRMtHWf8J90QekegU41aq4ftRdp8UQi3tEPZqQDVm+oefoOtinVjYqVg==
X-Received: by 2002:a05:6512:33d2:b0:489:ce1a:fb2a with SMTP id d18-20020a05651233d200b00489ce1afb2amr11046939lfg.558.1657620505091;
        Tue, 12 Jul 2022 03:08:25 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id u2-20020a2e9f02000000b0025a67779931sm2339204ljk.57.2022.07.12.03.08.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 03:08:24 -0700 (PDT)
Message-ID: <fdef31b4-9c27-ddda-f1e5-ee881812aa4e@linaro.org>
Date:   Tue, 12 Jul 2022 12:08:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/7] pwm: dwc: add of/platform support
Content-Language: en-US
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        William Salmon <william.salmon@sifive.com>,
        Adnan Chowdhury <adnan.chowdhury@sifive.com>
References: <20220712100113.569042-1-ben.dooks@sifive.com>
 <20220712100113.569042-4-ben.dooks@sifive.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712100113.569042-4-ben.dooks@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 12:01, Ben Dooks wrote:
> The dwc pwm controller can be used in non-PCI systems, so allow
> either platform or OF based probing.
> 
> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
> ---
>  .../devicetree/bindings/pwm/pwm-synposys.yaml | 40 ++++++++++++++

Bindings must be a separate patch. Preferably first in the series. Use
proper subject prefix matching the subsystem.

Best regards,
Krzysztof
