Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D849C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 15:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiGSPMP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiGSPMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 11:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3EC752E6C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658243529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UbgLtHKRYJRRPICj7dQDhNkD4S1y/0PvJsqR4JfvyZk=;
        b=EKV4d28LI46JqofCbEEmYUVF6P9Z1wqPsVxmO9mW6eBpo9vTHu0I7XHr7KjcxcRpsuUh27
        COKqBq3OPd0RDtCQK4JiQYeXB2Hd6NeZSQMK74vE8qU6Fxt3+cUK/fnNPbr7XhHso3TXz3
        Qfn5iPmgbaiWOhqgMYZIs2/01q4F0hs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-74MxXds0OM-pw1dubqokLQ-1; Tue, 19 Jul 2022 11:12:07 -0400
X-MC-Unique: 74MxXds0OM-pw1dubqokLQ-1
Received: by mail-wm1-f70.google.com with SMTP id r10-20020a05600c284a00b003a2ff6c9d6aso9217648wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 08:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=UbgLtHKRYJRRPICj7dQDhNkD4S1y/0PvJsqR4JfvyZk=;
        b=fLX+O0NNzb6/PC+CB92agNmJAh2a61GoJ/khoVuJu+Q2jJfJRaFU3e6pDfYZ8uYbLd
         RHkcauJpVsTVOiNdUvMsRvEksYIgq0sA/jd560z6b/stl5kIhdgs/d6HyO2sUsRfxYda
         uEwLTYqtH/Lu/Pxo4u7z/qZq4AzbqHWfQHjaEM25anpPkj0j40O+DVGVZMf6lpigwKot
         pDfUOc3ROcSv0jVwgzqhYLC5cOoFk40iJOHgpboook3jGyXS3XgZXpVUvvsk+7Vpnwsj
         vvFx3s+4bI78+4OqNEb0pbLftyLZ18jN6djyqwN2YRMW6VynKuDtnSM7JGXTG1y3wZ74
         A2lQ==
X-Gm-Message-State: AJIora/5k5xqnr9lgn02C5LVHLc8aFWdvLWR2T66P/tnszKCB/tnQK58
        kj6YSUv0/6UinmmFuWrmIyZwf5WV8awZEiCevMMEX7Z4ueuB3lv4kop6e8EXbbnaNo3nSTqMeZ/
        usOnZav0dNwAwf/evFCS8L5+A
X-Received: by 2002:a05:600c:2196:b0:3a2:feff:4c42 with SMTP id e22-20020a05600c219600b003a2feff4c42mr26971944wme.163.1658243525642;
        Tue, 19 Jul 2022 08:12:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uM3f12PSx0BHnJTavhbvRFzyFKOHsZ9Z6JBoVVG6G3IfEO3+vgHXSl98DSo65AVStuIpycMw==
X-Received: by 2002:a05:600c:2196:b0:3a2:feff:4c42 with SMTP id e22-20020a05600c219600b003a2feff4c42mr26971925wme.163.1658243525487;
        Tue, 19 Jul 2022 08:12:05 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id b14-20020a5d40ce000000b0021a56cda047sm13692256wrq.60.2022.07.19.08.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:12:04 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org,
        tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        kernel-team@android.com, Vincent Donnefort <vdonnefort@google.com>,
        Derek Dolney <z23@posteo.net>
Subject: Re: [PATCH v4] cpu/hotplug: Do not bail-out in DYING/STARTING sections
In-Reply-To: <20220704131346.2650163-1-vdonnefort@google.com>
References: <20220704131346.2650163-1-vdonnefort@google.com>
Date:   Tue, 19 Jul 2022 16:12:03 +0100
Message-ID: <xhsmhfsix6ssc.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/22 14:13, Vincent Donnefort wrote:
> +static int _cpuhp_invoke_callback_range(bool bringup,
> +					unsigned int cpu,
> +					struct cpuhp_cpu_state *st,
> +					enum cpuhp_state target,
> +					bool nofail)
[...]
> +		if (nofail) {
> +			pr_warn("CPU %u %s state %s (%d) failed (%d)\n",
> +				cpu, bringup ? "UP" : "DOWN",
> +				cpuhp_get_step(st->state)->name,
> +				st->state, err);
> +			ret = -1;

On a single failure we'll get two warns (WARN_ON_ONCE() + pr_warn(), and
then subsequently just the pr_warn()), is that intended?

Also, why not have ret = err here?

> +		} else {
> +			ret = err;
>                       break;
> +		}
>       }
>
> -	return err;
> +	return ret;

> +static inline void cpuhp_invoke_callback_range_nofail(bool bringup,
> +						      unsigned int cpu,
> +						      struct cpuhp_cpu_state *st,
> +						      enum cpuhp_state target)
> +{
> +	WARN_ON_ONCE(_cpuhp_invoke_callback_range(bringup, cpu, st, target, true));
>  }
>

