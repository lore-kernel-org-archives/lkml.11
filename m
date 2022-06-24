Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE10C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 19:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbiFXTAN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 15:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiFXTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:00:09 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504081C4E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:00:05 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id n203so1626988vke.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 12:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SGluoKDvNhpoEckHDDWOrxS1tEeRkkrqbbiy7mtXDJo=;
        b=SeBK9OzzJLTSt+E2NcO4CyshZ5eHLG0+k5F08mXxwS2vxxQ9f/og5eFQvpKJ8uSSwI
         rHel2K+mUIoxl2Afl9nRzCRLf3eWH9X7pklzRV2sYVenMZQDJ9ViZZ3ozsOnypQl1toQ
         bAJ60csNSyGqcrE+qY1mCB468Vs/hKPnFMwiKFOdp9z6vJ4VZDIqzOYk4ZIs9G5/pKLZ
         eGXW2mR4f/2KWbDJrx4Gs/xh6DA0sVwkUyg1EZcCOY2cyjAX/mq8VqdOwQJN4jBYv5w1
         Hw7gwdX71XnQGV0lxkEQdiUjeIfZtKjhEioV9HJPoMu1f/p2+QgVO/u4CpEyhkTabe5v
         Fk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SGluoKDvNhpoEckHDDWOrxS1tEeRkkrqbbiy7mtXDJo=;
        b=VugHjw+a37z1gynu2g2LOS/rRa9f3hZckp39RbLwBMgPIGzMnPadCkTVaBnLETXMIR
         dTchj1jB4Tk4Lf43ys3NYUuEFMCtC3E49oOedKNyNBBzpqHGPQURQ4sOXTg3gNpkfKLK
         ZJzjoim9LsJP/RnlWM/Pe+BbMyamthnEvobyoND8JuaLD/uz5/SplaRNyUWEGldkI2qT
         e31r03FWO3aCMKWLtiR285sc9fmbhYrQuVQz7VoKsqe8IpsA7ZL2lIDWReWgjcncRnDy
         HNo/It9/1TsHBLSwogIBaaL41ru1l/wG8DsiAUT1qSoiXXMOG5dgNjKYW5FSytKf3nYJ
         VIxw==
X-Gm-Message-State: AJIora9pAuKojfWwcQJHFcc+CqcQuL9aWNrBmeq9TDiiomlOwOUigCoc
        XdwCX3dUi6WnV9TdigVagKSKMW6pBmUXjkUyw4Pqpw==
X-Google-Smtp-Source: AGRyM1ukY9oxnkNfmBtHx7HwwDrY4EIVheW23sU7aprr50cq3luECdsgoeFJYDVuTX/JqSzKyopFqE+pi+fD4wyo4bE=
X-Received: by 2002:a1f:1886:0:b0:36c:c60b:a4ef with SMTP id
 128-20020a1f1886000000b0036cc60ba4efmr125792vky.29.1656097204398; Fri, 24 Jun
 2022 12:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220624125423.6126-1-mgorman@techsingularity.net> <20220624125423.6126-8-mgorman@techsingularity.net>
In-Reply-To: <20220624125423.6126-8-mgorman@techsingularity.net>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 24 Jun 2022 12:59:28 -0600
Message-ID: <CAOUHufba2KQLbFMoHusTpvEBHS_EWQ1NnOfm3Wczmykk0A1pTw@mail.gmail.com>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal spinlock
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 6:55 AM Mel Gorman <mgorman@techsingularity.net> wrote:
...
> +#define pcp_spin_trylock_irqsave(ptr, flags)                           \
> +       pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, ptr, flags)
> +
...
> +       pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);

Why pcp_spin_trylock_irqsave() was added earlier but not used later?
