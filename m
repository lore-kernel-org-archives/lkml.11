Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF4C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Jul 2022 19:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiGITb5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Jul 2022 15:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGITb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 15:31:56 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C867FD1A
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 12:31:55 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id j65so1599886vsc.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 12:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xlsWHsy+WSigsg0uYZliDjxgP+p+SBFZhCdQ1FFyqWg=;
        b=WEZ0ILURpKh8sbC8lm/EYHEdBpmUWlb1LIJP7fEVKuC5/tseDNMcSLwQZv0oudbI9y
         tNTRCeyQcMhr2SaIgvMUo06GRD8mbBY4jKcQBq6EswCLk+C517DmNnfQfnuf3CRollfm
         vKzGsPUk+VYFJT+uTZt7I+hPqd39NPcIUnqqWgifLAuFqIrlBAWptVI24I2xIbAfDkdz
         N+Sh/VSK/15lMLEhN/syOHbsXSgOzqUly9kYLSYdqe2I1CrUOCzvlTxJEpydXosxlCeE
         jDhtsUH6m8Ik0vNuP4p+j/T0RrozPRiYdtTxTGW+lpRUd/D0UJN6LhBI6WkOBMq9ImPl
         /J/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xlsWHsy+WSigsg0uYZliDjxgP+p+SBFZhCdQ1FFyqWg=;
        b=6snOBt+3myv89YhkReHOYUwWY4Ayxrkkfwumr/QDSZJfbMi4WLvIvf9PJW8PqYkqL7
         bC8Fx+cX7OWAh87htDaj+XYTZ/E9l/7AmS784KOPIG1QysB3alQKTU1T6Hn2hydQeczS
         v2QzetoY7pPx/LIxCfcsGl2h6LECKN35MX0jPME+Llzf7PK7yf4sLFJQof5kAtkBpXw+
         uq7eFGZkM7qTcBI/9/G4YqE1zcLUpZCZdw/zSI+73MjOVKbqsGcBP/XgxPMhR7E14O3Y
         N8BSwFXaP/DjEEBYznh4qjY7gOGJZSRjfVp/f8yHPYkqX0vz5PRoVlCohkJs77THRC72
         owgA==
X-Gm-Message-State: AJIora/iuzKFpzNDWfx1EGpAqBNAE9h7xu8J29waEjI+lKQAgWj9o1VG
        HY61W5EQiBSbGqrQQwBGu4Yy5jt6VGwYPgsnHbPvCw==
X-Google-Smtp-Source: AGRyM1uC2aQTpOv2bSpzFZ97reIMfr0s6VV8RvjoUaHE3jCQW7GzZMlqog/s6RGckY3SERJErgCsgEwk3HW3QVCGG0w=
X-Received: by 2002:a05:6102:3656:b0:357:406e:54a3 with SMTP id
 s22-20020a056102365600b00357406e54a3mr3173785vsu.50.1657395114649; Sat, 09
 Jul 2022 12:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220706220022.968789-1-yuzhao@google.com> <c576d1cc-9f67-4cf7-a851-48bc0e9f0082@gmail.com>
In-Reply-To: <c576d1cc-9f67-4cf7-a851-48bc0e9f0082@gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 9 Jul 2022 13:31:18 -0600
Message-ID: <CAOUHufbhmma8phX4arNwF10xBf7as=gtc1Y7k01f6CD3v04-QQ@mail.gmail.com>
Subject: Re: [PATCH v13 00/14] Multi-Gen LRU Framework
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 9:03 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 7/7/22 05:00, Yu Zhao wrote:
> > TLDR
> > ====
> > The current page reclaim is too expensive in terms of CPU usage and it
> > often makes poor choices about what to evict. This patchset offers an
> > alternative solution that is performant, versatile and
> > straightforward.
> >
>
> On what tree this series is based on? I tried to apply on top of mm-everything
> tree but it didn't apply cleanly, so I had to abort.

If you are on the latest mm-unstable, then please
git pull https://github.com/yuzhaogoogle/linux.git
for-mm-unstable-2022-07-09-03-05
