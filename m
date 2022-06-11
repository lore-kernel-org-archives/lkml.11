Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6396FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 03:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiFKDqh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 23:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiFKDqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:46:33 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997DB26F1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:46:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so797623plg.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4IrN97Z1/unmod/0ZIgRREwNK9Dy4GlFmKlR4IOlB2k=;
        b=hb4l4z3HG1CVMmqPwl4/D1F8761cs2tTehUNvl/L8uMyrLPJvW7RsrggENAgsab4io
         Zv5yQK9qdUPwNuP9lVOY/y6TY8a3Oc5qDekpUtenRoFkvrFPoA6UvVws1C3tux1dCimp
         kOOuIyXvbj0inJNrczRDU//NJz3ohut46sRl6O7ofLIlPIoE71x5lG+Yn7kt055M4sGG
         V3coDTpJC9jh77FPAguxa2tqFo6LVbh2uJe7xg/aKvo/L4ePRAtsYhHyq4AxEoer/WML
         1ISE+Dm6SqmodoZ5bat1m55xhIzPSSrGZkDr+QuXreldboiOkADsv4W9qfm6qSC2EK86
         RtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4IrN97Z1/unmod/0ZIgRREwNK9Dy4GlFmKlR4IOlB2k=;
        b=HAjpM/2ctOBYC4HMuEBX+Uq9niLE0FtbAG6O7ojoOsXrlifeEt3pf6kQSllqDCY61d
         Jb1n8bLp2l9a6u1EajGki7n1UJk6tiMGFm/5g1L3t0E3EB30dVdb2bj5dDDYyoWTv6ri
         aZT046WJiGr0zXjfJNw0/jY7hwPmgg1iR4zx7lyELNPlZLV4ZrU6CF7P6kFvDX7YW0eI
         5czBYnopEhZxD2P04XVaB5qVYvuNG0PyWXN42524q3Fu9jaqh2NsM/ljhAB02ARsjFEC
         zuwyLDMXZ9lNyQaJuaUtMBzkV+usrK5aYxHlizSwv+EqvIjjP4aa/B/kog5Gg5V6yuC9
         vudA==
X-Gm-Message-State: AOAM532vnjN+XhvzRQ0WvxXCM8CMfSeaB97ecWJFP7/vohDDGE/lyRTf
        f4bLweBNNdkyI9DQZwCCKkk=
X-Google-Smtp-Source: ABdhPJz/jDdaLC34L72YARJH+N80C4P6Crbov088Y5N17eQQL78XPGY9rLyVrHfAlIl2f4KrcPbuXg==
X-Received: by 2002:a17:90b:3506:b0:1e8:8449:6acb with SMTP id ls6-20020a17090b350600b001e884496acbmr3024124pjb.27.1654919192077;
        Fri, 10 Jun 2022 20:46:32 -0700 (PDT)
Received: from [192.168.1.104] ([101.86.206.203])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b001677d4a9654sm463706plk.265.2022.06.10.20.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jun 2022 20:46:31 -0700 (PDT)
Message-ID: <957f5626-2c89-f53a-2156-bbde2bb545f2@gmail.com>
Date:   Sat, 11 Jun 2022 11:46:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 3/3] mm: kmemleak: check physical address when scan
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yee.lee@mediatek.com
References: <20220609124950.1694394-1-patrick.wang.shcn@gmail.com>
 <20220609124950.1694394-4-patrick.wang.shcn@gmail.com>
 <YqI44Q20oJNVl+QV@arm.com>
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
In-Reply-To: <YqI44Q20oJNVl+QV@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/6/10 02:16, Catalin Marinas wrote:
> On Thu, Jun 09, 2022 at 08:49:50PM +0800, Patrick Wang wrote:
>> Check the physical address of objects for its boundary
>> when scan instead of in kmemleak_*_phys().
>>
>> Fixes: 23c2d497de21 ("mm: kmemleak: take a full lowmem check in kmemleak_*_phys()")
>> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> The fixed commit above was cc stable, so we'll probably need all these
> three patches in stable. But I'd keep them a bit in -next for testing
> first (and I see Andrew already picked them up; we might as well merge
> them in 5.20 and send them to -stable after, it's not some critical
> feature).
> 
> Thanks for the series. I don't think you need to respin unless others of
> comments.

I've received an auto build test WARNING from kernel test robot:

    mm/kmemleak.c: In function 'scan_object':
   >> arch/powerpc/include/asm/page.h:215:42: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
        215 | #define __va(x) ((void *)(unsigned long)((phys_addr_t)(x) + VIRT_PHYS_OFFSET))
            |                                          ^
      mm/kmemleak.c:1403:19: note: in expansion of macro '__va'
       1403 |                   __va((void *)object->pointer) :
            |                   ^~~~

So I will replace __va((void *)object->pointer)
to __va((phys_addr_t)object->pointer) for fixing this warning,
and move the prototype change and the kmemleak_not_leak_phys()
removal to a separate one as you suggested at the same time.

Thanks for these comments and suggestions.

Thanks,
Patrick
