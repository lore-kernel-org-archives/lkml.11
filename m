Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D39DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 17:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbiCIRdm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 12:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiCIRdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:33:40 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A85DA860
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:32:41 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v130so5822209ybe.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v8I9rVh449xj9D045Y6s7uA6WVIr+RagQY+WMcg87OI=;
        b=g+BR/qvwq9//xxibZjdrhWKWOAO4O0s7AYq41a103ZswtzQ7Ew8H9zCEk+L4QIs3qv
         8UbLmgNN3QzwZUK7nIkr1ARqfH3dwNxv7BEv0B+pLn2FK6vTsdnFA559s9jm5xGOT5/1
         mkUsTvNk1Z+X/jCGrNPJyozZV1VpZZRyGyr7rnpO1WStwzXy+LD/BmzLjs2YX/58UAF0
         L7UHLX6kFk6QSpCCzWVprOU358yC0KqVQFjC7Iw5CFjpuUFOxqYuHRuFBzH10Y5ei8py
         07oJ9b4hTYakS2PD4YyoErid8y9iSsc0ESTqJLXX8og6f7HKlDM2CkcI5GuBMpWCZ2Aa
         OePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v8I9rVh449xj9D045Y6s7uA6WVIr+RagQY+WMcg87OI=;
        b=AANe2yijhl5CjFxBHiMyGnIGHXhBJx+EsTaUbVCB1c0beB7SFO1VP/0m726U6kOqJQ
         gTq6uxPh4vuL6UVwUu/St49PO+9YDq7KutSa1nqNYC+4YiHrLx85BQxRDm5l5F1o+vMm
         HsCuf5D5Js2tL9/6T4HhmZpjycMI+7aqyH7tjIcwFcvX81OysYLkdymuTbcUxo+M0zVI
         RIMQrihjmFSTjxCPLlr8I5P54Jyuhy8JdNcxvUwg5qOvyZolgqeUoPvRMmadqMmn2bpw
         XiL+yQSUqOnOIqjBxdoCgfOiXu/sVX0670tPtd+UjS4qyVG/HMh48UqUM/sF9LkT+ldv
         FLUA==
X-Gm-Message-State: AOAM530DG+0+7AD/li8M1ENtnpynsFBFY9H4tBhEIfNH6aGrxS5A3ueY
        CSlI2EiEUY2CPYZJOYfvaLBxRCOpuWePnqQ26bA4tP17UpwmxQ==
X-Google-Smtp-Source: ABdhPJzdNSsV+EnBETzF7al3BTdSykx7KBrwPPXsRMe8yPq/+DLtS3UMlMRXHd4s26hur+LuhcYBsU3+BUJdPQG47Yo=
X-Received: by 2002:a05:6902:1347:b0:629:1863:9dc6 with SMTP id
 g7-20020a056902134700b0062918639dc6mr747150ybu.36.1646847160230; Wed, 09 Mar
 2022 09:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20220304170215.1868106-1-eric.dumazet@gmail.com>
 <20220307091541.GD15701@techsingularity.net> <CANn89iLmwT4XQ6JPi4C7dO+Q2O_j7HK19-TAo4nA1NUf8ZSLBw@mail.gmail.com>
 <20220309123245.GI15701@techsingularity.net>
In-Reply-To: <20220309123245.GI15701@techsingularity.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 9 Mar 2022 09:32:29 -0800
Message-ID: <CANn89iKy2_hutqReS9oa+e9d6Eao639=-PXA=9r5oNkqeh46rg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone
 spinlock is not held
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 4:32 AM Mel Gorman <mgorman@techsingularity.net> wrote:

> We should because it was an oversight. Thanks for pointing that out.
>
> > Or was it a conscious choice of yours ?
> > (I presume part of the performance gains came from
> > not having to bring ~7 cache lines per 32KB chunk on x86)
> >
>
> There will be a performance penalty due to the check but it's a correctness
> vs performance issue.
>
> This? It's boot tested only.
>
> --8<--
> mm/page_alloc: check high-order pages for corruption during PCP operations
>
> Eric Dumazet pointed out that commit 44042b449872 ("mm/page_alloc: allow
> high-order pages to be stored on the per-cpu lists") only checks the head
> page during PCP refill and allocation operations. This was an oversight
> and all pages should be checked. This will incur a small performance
> penalty but it's necessary for correctness.
>
> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---

SGTM, thanks Mel !

Acked-by: Eric Dumazet <edumazet@google.com>
