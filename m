Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927F1C28D13
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 01:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238927AbiHWBVv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 21:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238940AbiHWBVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:21:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F3158DDD;
        Mon, 22 Aug 2022 18:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=Yib1tk+uwz/RcC4uYtW/ZehxqivBIeHpfdomfZR8WQQ=; b=Hwmc5eF+dcSqI/qWoh+/bI3qK4
        snGfaVELtegLLIrYkG+DjslkS8eru/V7DHly4E2V51WpHoCRUo+TRYaFH/tHBG1qOYx+20iY9Zfoi
        lthhpH7qPHQTEmu5zCzr+HJGVPdyTIkSMU2RAlMCa3lZgL11Sb3k6pwj5eyGum1bBJPMIwCHKcTRE
        FTztF53NNLVjok0KSk/WRUoyeSv4tosHEELS3OGyWfABGMgQe3oG3BYpEHhg+3mUOoSUmfEc4+IPz
        drx6HjjAC4QSPxfR7OeX9QstbPJnAnYzC4EyksSk7CDKqFT6g20RVAIAhAEf+l6wMQjHXeH0oZohY
        2oOb6KjA==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oQIbi-00HAmS-CV; Tue, 23 Aug 2022 01:21:30 +0000
Message-ID: <0848eb00-5e32-3d2d-0c07-a1fd09164bd9@infradead.org>
Date:   Mon, 22 Aug 2022 18:21:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH -next] soc: qcom: Make QCOM_RPMPD depend on OF
Content-Language: en-US
To:     YueHaibing <yuehaibing@huawei.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220820113202.23940-1-yuehaibing@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220820113202.23940-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/22 04:32, YueHaibing wrote:
> WARNING: unmet direct dependencies detected for PM_GENERIC_DOMAINS_OF
>   Depends on [n]: PM_GENERIC_DOMAINS [=y] && OF [=n]
>   Selected by [m]:
>   - QCOM_RPMPD [=m] && PM [=y] && QCOM_SMD_RPM [=m]
> 
> PM_GENERIC_DOMAINS_OF depends on OF, so QCOM_RPMPD also depends on it.
> 
> Fixes: 7d0221fb5912 ("soc/qcom: Make QCOM_RPMPD select PM_GENERIC_DOMAINS/_OF")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Works for me. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  drivers/soc/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index e0d7a5459562..024e420f1bb7 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -129,7 +129,7 @@ config QCOM_RPMHPD
>  
>  config QCOM_RPMPD
>  	tristate "Qualcomm RPM Power domain driver"
> -	depends on PM
> +	depends on PM && OF
>  	depends on QCOM_SMD_RPM
>  	select PM_GENERIC_DOMAINS
>  	select PM_GENERIC_DOMAINS_OF

-- 
~Randy
