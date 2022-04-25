Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7029C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 18:25:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240571AbiDYS25 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbiDYS2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:28:51 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E192B93
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:25:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v12so15285192wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QZoBPC8Nkhk5k104wkau4dObrEjdqxzPZb/mWYZPD08=;
        b=wAIjqikbcmTsGb3Jai6rhk+RkX19w89yVPsullHUPhFvojJOeGVZ5RPdo2fpa4cvLo
         dEnJik4nMtb5jPFSr0KDgxm1ffSMex169d1YJ0S5JrCyYu6CIjCM058TlVyExmX/ZV/u
         ealkHg2TwTq4pVf3Xo+YlypEGJybfu+C1JX41+5Jc7qwBAi3j3z5rkafMuB0BmdcrK4Y
         H17EPMVV75WfPiDsZa1u49FcAox6Dd8R0hNPzifJF1fr2/moXsV96Z6Ezo3kaiuLO2kU
         fQ2aFtoV86ilqTJiO6IjC4+C6IFl1qiwLgY9WzcmChQ2FFTK/jxSW1ztpFFMt63SXWqg
         TQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QZoBPC8Nkhk5k104wkau4dObrEjdqxzPZb/mWYZPD08=;
        b=baYpICYlK7ArkZRhv4RE9xPWaRgaCw3BEjNkShtBLf/BOcPYa2KEZ2mSMf4SL+yYLL
         9LYRXsQtACmBOjDFLPtkJK+AQ34TCW3zsmKmAWXjJFcO/N9eFRdw+0dP6WRTRFzWmht5
         CrbWTY3z9bjmQBhtXgjfa48OYYawU78sPhJ0F1vbucltX49ByiB2xflaM4ssRFSZIz3W
         TzZDjhpEDRA8ZjqXHKW2X2cL+Jym4UvX96fV2ez1eXmxWjJGasJHSFhhRT1oedQv3X+8
         Q+qUeE5KhNGYsWxY15saZjXiHBqtxkbn76NdJVXTyU7ok9X1t2K6dCiqzp8kk7WCrbQo
         c35Q==
X-Gm-Message-State: AOAM532b4NV2cz680j1g3YPn95IpjLWT8PNveoHkDWzW5DY64nptzMe0
        7X1DT4Z74E9uToReVYiiwJOXSA==
X-Google-Smtp-Source: ABdhPJx1RHb2igDyXFNSmlueXh7psE8Cvjcy5JGDZx5hzrA/yet6g0mYbEs1wL4zseEKQm6y6R1Tsw==
X-Received: by 2002:a05:6000:144c:b0:20a:818d:e3c0 with SMTP id v12-20020a056000144c00b0020a818de3c0mr14907941wrx.584.1650911144763;
        Mon, 25 Apr 2022 11:25:44 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id k65-20020a1ca144000000b003929a64ab63sm12452187wme.38.2022.04.25.11.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 11:25:44 -0700 (PDT)
Message-ID: <9243faf3-69af-eef4-1e48-867f88cab5d6@linaro.org>
Date:   Mon, 25 Apr 2022 20:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] thermal: broadcom: Fix potential NULL dereference in
 sr_thermal_probe
Content-Language: en-US
To:     Zheng Yongjun <zhengyongjun3@huawei.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com
References: <20220425092929.90412-1-zhengyongjun3@huawei.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220425092929.90412-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/2022 11:29, Zheng Yongjun wrote:
> platform_get_resource() may return NULL, add proper check to
> avoid potential NULL dereferencing.
> 
> Fixes: 250e211057c72 ("thermal: broadcom: Add Stingray thermal driver")
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
