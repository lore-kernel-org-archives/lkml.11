Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC485C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 08:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347619AbiFUIdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345984AbiFUIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:33:43 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559D315A18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:33:41 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id n15so2938694ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HMKX9HopiKiPvhGo8pRtwogz/OTxkYemMdhWmz/2mng=;
        b=Qy2mzGsKIMehWP2l4RPCwSuNW+/nhWmw8gGlz2O7rBIkrT240/SyYyCXOPOPSc2jXQ
         hcvzdO1PoMRu6jnYKih17cqn8UEq6g28qgu8F5/Arna5pgwPtEkr+FZthih0/xMBosCF
         RTonsFPXUDXZ3GmXXTszStcZ/v+ulqFzTDOpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HMKX9HopiKiPvhGo8pRtwogz/OTxkYemMdhWmz/2mng=;
        b=sRpvAW1ou5JN385t/N98uTxwD4nRuJcIZ4nZEqHyymnOgsJg9y23TMcUpsFeEf1e5x
         u+udPSkV2tY4a1h/+kYYkujx/Dk5Nun1YbM8BprXgMJ0ZAWvKyNjxARCH4LuU+8pL+AR
         CYWwiQv/S9ND8oFG1UVPinSdSQR8/ateaOj6TXepC6FX6nZJBzLO/6g4qADvZA7crnZE
         irc8Z5z44NR1fwtYBD6BrLZSEUCG8rP1WuD7GSTBB+t9Alh6GlqR9MnuZyMOBlCTpDNw
         gtS6gZKYF4ZjPEA28EYgAWNi+nK1O/ZoAjT4LNsSs2sHr9MbozpHh7Ed9xvCJSIYmIsj
         l3Zw==
X-Gm-Message-State: AJIora9I+nrDNZouFh2EWpn6QiKNCG6i4jKa2o/vSeXcolPSwaLPRNDe
        UrXfj9gtRuyqccoufI4pmNdxOGNQKGboUL+z
X-Google-Smtp-Source: AGRyM1tX4NfXPaR20sBdTb9CuobI/w5VS8VApwR8FCZHn6goqQEMtbYP6TXg974CHIdGDzMuVmycvg==
X-Received: by 2002:a05:651c:50c:b0:25a:4504:95c with SMTP id o12-20020a05651c050c00b0025a4504095cmr13635771ljp.90.1655800419657;
        Tue, 21 Jun 2022 01:33:39 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id p12-20020ac24ecc000000b0047f7419de4asm605982lfr.180.2022.06.21.01.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 01:33:38 -0700 (PDT)
Message-ID: <82fb021d-31bb-4545-cbcc-a7622dbd2e0a@rasmusvillemoes.dk>
Date:   Tue, 21 Jun 2022 10:33:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 11/34] vsprintf: Improve number()
Content-Language: en-US
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     rostedt@goodmis.org, enozhatsky@chromium.org, willy@infradead.org
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-12-kent.overstreet@gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20220620004233.3805-12-kent.overstreet@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2022 02.42, Kent Overstreet wrote:

>  	/* generate full string in tmp[], in reverse order */
> -	i = 0;
> -	if (num < spec.base)
> -		tmp[i++] = hex_asc_upper[num] | locase;

Please don't remove that optimization in a patch titled "improve number()".

> -	else if (spec.base != 10) { /* 8 or 16 */
> +	if (spec.base == 10) {
> +		nr_digits = put_dec(tmp, num) - tmp;
> +	} else { /* 8 or 16 */
>  		int mask = spec.base - 1;
> -		int shift = 3;
> +		int shift = ilog2((unsigned) spec.base);
>  
> -		if (spec.base == 16)
> -			shift = 4;

So avoiding a branch here may be a good idea, but I'm not sure ilog2()
is very efficient on all arches. Since we know that base is either 8 or
16, we could do "shift = (spec.base/8) + 2".

Rasmus
