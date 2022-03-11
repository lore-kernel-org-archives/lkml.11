Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2511DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 02:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbiCKCDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345520AbiCKCDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:03:12 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715771A58CD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:02:10 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2d07ae11462so57665977b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 18:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2hsaR8WAxcqWtbQLCYo/TxbTYR2phuKd4uO3CbSGXis=;
        b=Q4jqn7qEyVL5UGQm48tyWxHXBIKnYgeh4VJEcNABuXL8XnVgyd64deKgPWFzS66j7R
         g19GwgGrR2Qn0tEHazNj8b5zGGY9w6dYR/QXR3bG0gkvWfu9DJlLW79z0K/C/zsxfTge
         GcJ5vm2PigirvczYxMY0bKFOqMgstn4HhF3LhKS5zTfBa4NqlI/XoXoEUjMe2v7dxm83
         78tk4oqkEHsC95dm3g4GEnbysiblZLmhiaBQwu415BH228ci8sg+b9UrKjafX1FBmrjF
         +3UHolf80KtUStuJ7TfPlOzTfUAoZ1d5e7HGQhKJXtFMuZ4vYMUHLKLRBrrn/Zia00/l
         V3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2hsaR8WAxcqWtbQLCYo/TxbTYR2phuKd4uO3CbSGXis=;
        b=cRokBrlTE53oLTXt/U53qzkt4keWmw+2vFwr/ycPMnUhLTIQKeo58nacHFcWOsRBYZ
         O4/DCJ2zN8vrU7G2DwyOdwlho5csR1EteWWLvWB7weIibBJI/NFPejFx/LRO0fCY5x+m
         sgC7+5sqP6PSltnZQ+dL6uYETgnRcz5Ca4BDLX7utF04EqyxYqDHwL9tiLSu3Htm7Ldm
         Ku6p+oPy68GQh6r/1znZ2s/JN3QqOarUOalJpURlgUuXIc9cIxyS1XXk1xNahaQVtzAG
         dy0BDRr79xiQ3gHaJcsJM6Mj5rwhp4QpVtynLbydwandAxHNLPVJ3Da0LLtvhRp2olxz
         RDTQ==
X-Gm-Message-State: AOAM5338fck1N2lrfnVBtwcXDg6ALBSwVyCnbNHpzED0yR6X52s5tkiL
        CmnL9wF2a8C7LdC+JMX/pwzXvWagtjtchg==
X-Google-Smtp-Source: ABdhPJzOTCYYIPtqY5f4TpqaFYLmmfYjNi7qJZgtvYTI9QaocypqR0Q/Ra+o/HDjGm3UwlCg1pPVe9yP2r+USg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a81:7556:0:b0:2dc:6ea9:8d53 with SMTP id
 q83-20020a817556000000b002dc6ea98d53mr6501468ywc.413.1646964129540; Thu, 10
 Mar 2022 18:02:09 -0800 (PST)
Date:   Fri, 11 Mar 2022 02:02:06 +0000
In-Reply-To: <20220310092456.GJ15701@techsingularity.net>
Message-Id: <20220311020206.qncvybld6zrgmm3m@google.com>
Mime-Version: 1.0
References: <20220310092456.GJ15701@techsingularity.net>
Subject: Re: [PATCH] mm/page_alloc: check high-order pages for corruption
 during PCP operations
From:   Shakeel Butt <shakeelb@google.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:24:56AM +0000, Mel Gorman wrote:
> Eric Dumazet pointed out that commit 44042b449872 ("mm/page_alloc: allow
> high-order pages to be stored on the per-cpu lists") only checks the head
> page during PCP refill and allocation operations. This was an oversight
> and all pages should be checked. This will incur a small performance
> penalty but it's necessary for correctness.

> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored  
> on the per-cpu lists")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
