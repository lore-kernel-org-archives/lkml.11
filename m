Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5A5C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 22:59:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiCUXAz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 19:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiCUW6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 613BA397F16
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647902741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EacfxnkX9Tda5ZqPqX8sw6gxpx1DWpcPyhYrvwZcwlU=;
        b=f1tUEisi7PeDvQv/2srrTc7duluto8RercQTC54qAWMDmb/uNuWGxdpBqlhYt+/+IpRoaV
        0yHrU5tQUFgvExHK9Is9o1hUs/v2o116q2WhADOkViYJ7sVbvKP5mcXZ2u/V2A/moAPMQN
        qAjAkrsG2J3zhISxQ0NHlCnJluqEq18=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-JJBg0tSfP9GLQ4es8Tt5xw-1; Mon, 21 Mar 2022 18:45:40 -0400
X-MC-Unique: JJBg0tSfP9GLQ4es8Tt5xw-1
Received: by mail-io1-f69.google.com with SMTP id x16-20020a6bfe10000000b006409f03e39eso11382127ioh.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EacfxnkX9Tda5ZqPqX8sw6gxpx1DWpcPyhYrvwZcwlU=;
        b=G9pGhfewYKEMxv82ACDOMiK9un+37U9Oi13gAQVVIGDRaFWmJTCwpUsQmzUWTMeVSQ
         PEB0vm+vZLHh6fiYAqp86YibzDvsQ9sOjmTMMl/YQaZBI5npyw8LPnhB4xM2VpYW+nQD
         QMpzfWAkQ6oJ7cCPkp+4bjcjDHghXBP86AbsTVgAXMwYWgJr0GF37TqlYVk/rtXZA0JE
         6BN0ImQsSZg9LvbEzcW8MKEYjCaDerMPLXCu99xG1r3gxRDih/JjKV6DuYM1XNTE3q/e
         n+20KQ1ua6vaCxcU8+hO7Bc+AVztP9z5rdWHcqhpP9REHL9pVCG0IRCfFqloiBqMigMJ
         FNRQ==
X-Gm-Message-State: AOAM531uQtbcgf8bq+OF0nb1E8ipZPgewEVMYqdW3/bZQY4pNGk37Yye
        ChH7tKnjIQveBzXy8KH9bjW4iwx75BZMS1n7Y31D6ic6o4OBZ2+39FSdDTC+K6Zd7NYL7YOE0G4
        czZmQYry1I79RXDbgC2sI2s4h
X-Received: by 2002:a05:6638:13c9:b0:317:c419:d89f with SMTP id i9-20020a05663813c900b00317c419d89fmr10887661jaj.190.1647902739964;
        Mon, 21 Mar 2022 15:45:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9v+YQKtNMlmmbkRLQ9Mh/8d2VVK6NtoHwO1dk2TRXjXzbtyNd6Op/CViXq1noVFi/pnFKQg==
X-Received: by 2002:a05:6638:13c9:b0:317:c419:d89f with SMTP id i9-20020a05663813c900b00317c419d89fmr10887649jaj.190.1647902739700;
        Mon, 21 Mar 2022 15:45:39 -0700 (PDT)
Received: from [10.0.0.250] (c-24-9-153-244.hsd1.co.comcast.net. [24.9.153.244])
        by smtp.gmail.com with ESMTPSA id g6-20020a056e021a2600b002c826fcf141sm2748404ile.48.2022.03.21.15.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 15:45:39 -0700 (PDT)
Message-ID: <9fb05fa3-4474-5a49-9f1c-67c31bf96c94@redhat.com>
Date:   Mon, 21 Mar 2022 16:45:37 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit and
 the oom_reaper
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Savitz <jsavitz@redhat.com>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 02:55, Michal Hocko wrote:
> On Thu 17-03-22 21:36:21, Nico Pache wrote:
>> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
>> be targeted by the oom reaper. This mapping is used to store the futex
>> robust list; the kernel does not keep a copy of the robust list and instead
>> references a userspace address to maintain the robustness during a process
>> death. A race can occur between exit_mm and the oom reaper that allows
>> the oom reaper to free the memory of the futex robust list before the
>> exit path has handled the futex death:
>>
>>     CPU1                               CPU2
>> ------------------------------------------------------------------------
>>     page_fault
>>     out_of_memory
>>     do_exit "signal"
>>     wake_oom_reaper
>> 					oom_reaper
>>                         		oom_reap_task_mm (invalidates mm)
>>     exit_mm
>>     exit_mm_release
>>     futex_exit_release
>>     futex_cleanup
>>     exit_robust_list
>>     get_user (EFAULT- can't access memory)
> 
> I still think it is useful to be explicit about the consequences of the
> EFAULT here. Did you want to mention that a failing get_user in this
> path would result in a hang because nobody is woken up when the current
> holder of the lock terminates.

Sounds good! You make a good point-- We had that in all the other versions, but
I forgot to include it in this commit log.
> 
>> While in the oom reaper thread, we must handle the futex cleanup without
>> sleeping. To achieve this, add the boolean `try` to futex_exit_begin().
>> This will control weather or not we use a trylock. Also introduce
>> try_futex_exit_release() which will utilize the trylock version of the
>> futex_cleanup_begin(). Also call kthread_use_mm in this context to assure
>> the get_user call in futex_cleanup() does not return with EFAULT.
> 
> This alone is not sufficient. get_user can sleep in the #PF handler path
> (e.g. by waiting for swap in). Or is there any guarantee that the page
> is never swapped out? If we cannot rule out #PF then this is not a
> viable way to address the problem I am afraid.>
> Please also note that this all is done after mmap_lock has been already
> taken so a page fault could deadlock on the mmap_lock.
>
I don't think we can guarantee that page is not swapped out. Good catch, I was
concerned when I saw the 'might_fault' in get_user, but I wasn't fully sure of
its consequences. I'm still learning the labyrinth that is the MM space, so
thanks for the context!

> The more I am thinking about this the more I am getting convinced that
> we should rather approach this differently and skip over vmas which can
> be holding the list. Have you considered this option?

We've discussed it and it seems very doable, but we haven't attempted to
implement it yet. I'll give it a shot and see what I can come up with!

Thank you for your feedback and reviews :)
-- Nico

