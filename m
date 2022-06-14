Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CD7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 19:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiFNTXm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 15:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiFNTXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 15:23:40 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755AA19004
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:23:39 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id z17so9408720pff.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oNhBOKueXR3/wV6Pdx6tcgkU7Tq6xyeJG/a4fyRbFQY=;
        b=hKMhqgaf/Y1rOeLAH82a39zdboCADD71RumknFq6HI569J9kUMit6BelRpiuUSMVjA
         Ck+LRUyDNBLABkGvzjJ6hMBQLU3B+u9EZ1UNHzJ613h3Zq1mmpOgNoiNIUYcKE8RVDr/
         8ZLuaX4vg8E1sq/enJSbUmJAvdVbDY3hOthNmUngU310hWyG4jacn9gSp724SWR7TA6+
         S8TsPcavmKCmRutYAYkaEAUJqiujNznZ1xlWI3rrYwa857/+qMnI6BSeiulJzvlcVtyS
         MW+VWVpVLgV99mR6956GTR0kSj+C+HTVFLE6Kh+OmcqxBepJJiqPmXjUcstzgl7mye5/
         9Xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oNhBOKueXR3/wV6Pdx6tcgkU7Tq6xyeJG/a4fyRbFQY=;
        b=e8pRtOF+bEWfyvGa9uwyUJuo/WnDps8oEkocxgIBUk+JRITclLPrRPYc84JionSjoB
         JuHkyVCq43c3nf0C9MF1G6XLxQlRWmaH0fhxMQfK0m+F1E31x7HGrHaQzfn4wMTzAhNP
         fx1TntvVSqyOfX3Yujvg9Gq0Zw1/v4zXa9mPEyBoRePJ24IXzLzWGAxfQKRek1RicBsH
         4EdWW/TfHwwFqaaGgqdsri2aJVr5CWvcJGks97XGgmVpDTUGQW3k75lpZLzfIJiOMNjr
         7eeW3p553ir6MBNy3bQDnRKNd+wabFy+IpO2xGxwIUOiXRQq21oI009kdAhsP4nfOfwN
         Qt5A==
X-Gm-Message-State: AOAM5325J0C3zxJhQrZZurUi+iSu3ofEPeBrAH7A+NSviKVCCA+bAzQ0
        3HMm8keHP5tRZGPCNQoYjCgVxg==
X-Google-Smtp-Source: ABdhPJyaRIgHu7WrWtcG9f59wBnOLI/cwZsceHoXmiXwSC/yBzoXFR5jEYFkCD3GvqlSyhCeHchjlQ==
X-Received: by 2002:a63:5f8a:0:b0:3fc:5c2b:446d with SMTP id t132-20020a635f8a000000b003fc5c2b446dmr5809875pgb.475.1655234618937;
        Tue, 14 Jun 2022 12:23:38 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id iy13-20020a170903130d00b00163cdf1a200sm7656139plb.38.2022.06.14.12.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 12:23:37 -0700 (PDT)
Message-ID: <5a5ef4b3-0b43-b01b-1bae-08ccf9f5a7cd@linaro.org>
Date:   Tue, 14 Jun 2022 21:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] dt-bindings: timer: Add Nomadik MTU binding
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org
References: <20220526213621.373727-1-linus.walleij@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220526213621.373727-1-linus.walleij@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 23:36, Linus Walleij wrote:
> The Nomadik MTU timer has been used in devicetrees forever
> but somehow we missed to add a binding for it. Fix it
> by simply adding it.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
