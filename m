Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C3BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 07:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbiCVH1B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 03:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237439AbiCVH0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 03:26:55 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740764756B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:25:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a1so22249365wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 00:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ag85I8PruQxLQ72jOk0/wsx8Hp44RVX6T6D7aHNVsTA=;
        b=X1LaQW84nOPXcmH6so+bm9cVBbXpSasbHQRylsYLX0jMRX8euf2J4dyP4g5SlMZyHR
         IK1EN+PgMGyB2SAcOBjtDyTVdawdSBul8JDNGKZ9vvrUtnRfB/B3zN/lWIJcsdZ2+gQ+
         jkl1eyRGiizehq3fXOvU0I738M9u95T20xpuoYMCQEB0Ip+l77VoueQTS1qIB+Jqv6E4
         3S2l2NYyr71wu4/CbQ2q7CN+rl7SQlV0370lyfT2g6Di7KHaDPJmHollzdFZWeVcWhMi
         uvxHB89+G6RiUA/rlOPj07DzIGhHOW8GZsCV/a9ufpvB8j8GFmWD1dlyPrxbInm4FYdX
         Ec7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ag85I8PruQxLQ72jOk0/wsx8Hp44RVX6T6D7aHNVsTA=;
        b=zBc/ihAj4uMw2OXxAkjJMyvWt+7L15ootH1kC8b+MAXZWZVh0fAkmxYd3bGocMu2Pn
         IfF9myI2Y7RJe7cskd+t+8Z6wM2MFWCwlakxJBUj4MvOmI1Zx698UeqFIJR3phX+ccbx
         rMMEwYAcC44rqGKugbMsMPzkNDrkSEVvadhc/3k+X4azxtqaN7lpZV0vuoNDL7WhR3L+
         vQJHUQhrfbTmroIT+GKBza3y3qbcNNzRS15i7zZ/iP8s8vyR0bVpCQIZPsY8Rk1Qqzo3
         VWZtU4hvRkkas2LVGHT+73/gwEzJ4DmZAjO0lyt0zB+KrJS7fNOeN5ZlSBw+2PWMtK7j
         72BQ==
X-Gm-Message-State: AOAM533Z/i0yz9rDNXyM2x9+1lmrFw2YQ04fJyeotHsLtDfXb8hJOXrf
        f/NGdoLSBPGFL/E0Rw0Ho42Zq7vWBNoZaA==
X-Google-Smtp-Source: ABdhPJySKf9ebNrzKsIlcfG7NXMzXFxZX1tDzRxEAy5KUNqkeHkGmnmqcdE69reHVubUbIefi26dOg==
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id 98-20020adf816b000000b002037faea245mr21373932wrm.619.1647933927055;
        Tue, 22 Mar 2022 00:25:27 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q2-20020adff502000000b00203f17d73dbsm11159750wro.12.2022.03.22.00.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 00:25:26 -0700 (PDT)
Date:   Tue, 22 Mar 2022 07:25:24 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     linus.walleij@linaro.org, lukas.bulwahn@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: db8500-prcmu: Remove unused inline function
Message-ID: <Yjl55FWHtRbVUDcs@google.com>
References: <20220311125518.31064-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220311125518.31064-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Mar 2022, YueHaibing wrote:

> commit b0e846248de5 ("mfd: db8500-prcmu: Remove dead code for a non-existing config")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/mfd/dbx500-prcmu.h | 4 ----
>  1 file changed, 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
