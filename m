Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9645C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 14:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbiCHOHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 09:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiCHOHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:07:05 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16A449F91
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:06:08 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so1457254wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 06:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=YIiKmaAv0jfkwMQ3/YJwiKUInE3iPjcQmLg3VXVO7ns=;
        b=Twi5VphyBmw2kd6/DH9/5mzqFGHZ1pwNvDEj+Q/UmEh4goe5TbJBWNcDpoUG6fObxR
         0N6ZUmT3CWurqwzxqqhQZLJUvq76AUKBV6GZktT34RD3+nVzN8TYfg7pcYs5F2zJVnMr
         sp7ngWEPrXW9SLgk9i7g9jGm5kJ/otl7QQB3vGdnjYUU/gBip9zniZ4/HHFV6AFQXucQ
         blMrzY6YWF0fxx8HyrkBjhkomRAKnM+M26lRFBEv2HBZBuusGldIrRD2eRio2ZhjLTXK
         gwZf4tyBq9FqL7m2M2JsRNLBgSP4lxQsFgH3QiJ5wDW5nGxmZTGo2KLWFfKaSFedOr2d
         Ai9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YIiKmaAv0jfkwMQ3/YJwiKUInE3iPjcQmLg3VXVO7ns=;
        b=QlJA/xGvOjywgzxXn+A1ZxR+bt4kyoj4Mx5g3cnlj2+JURvb+Mm1UAfNUaxdnw4zPd
         lRhtgphLOF2ZHi0sxUsCCFXkZj30NZdAE6iq+DxpZpNSpwVP5NvVcAvsbsL12dt00nga
         9FkxXOaVI/c1R6OBgbc9fhSs95fp7qlJIgk6aTawNmfX+9kc6cUxyWDa7bOLiO1hVzVM
         o7CuAs+YzRVNwGsdGJ9eZ1uTYealSTPf/W76N1sIGl3VzaNU8Cnw4v4B40aHL1TnojXF
         WivaLFS5TySwN3TsbW575J9RAN20PqB3SSXOBjJyEw3uPw2H0McjUa528GmkwYgR0SFX
         AESw==
X-Gm-Message-State: AOAM532MuHl7pPEtORCqz8Jpvz5NOtiiClZJLASfr1Guo2LaSlJza5j1
        5pet2YMNdv3FFZidvp0tkU2aGQ==
X-Google-Smtp-Source: ABdhPJyqc3uZctdMTU4CXLw5I0yjukAcwGJK6f9VsX4vNKTOQkzD3NVn9cnc+Rknx4ywALYX/tDL1w==
X-Received: by 2002:a05:600c:3d0b:b0:389:a525:7b92 with SMTP id bh11-20020a05600c3d0b00b00389a5257b92mr3852383wmb.152.1646748367242;
        Tue, 08 Mar 2022 06:06:07 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6cbe:1901:15e:e188? ([2a01:e34:ed2f:f020:6cbe:1901:15e:e188])
        by smtp.googlemail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm2917880wmq.35.2022.03.08.06.06.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 06:06:06 -0800 (PST)
Message-ID: <2d120cbb-3919-9a14-4ea9-6e95423d10c6@linaro.org>
Date:   Tue, 8 Mar 2022 15:06:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] MAINTAINERS: thermal: samsung: update Krzysztof
 Kozlowski's email
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220308065648.6443-1-krzysztof.kozlowski@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220308065648.6443-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2022 07:56, Krzysztof Kozlowski wrote:
> Use Krzysztof Kozlowski's @kernel.org account in dt-bindings maintainer
> entry.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> Hi Daniel,
> 
> Could you take this one directly

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
