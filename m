Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AEEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 23:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351753AbiC3XGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbiC3XGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 19:06:01 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7B1377F2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:04:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id h11so29705142ljb.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDgQSkHHiSrnRRl+XOyzOTrWuP6P/qs63lMjRlAlumA=;
        b=H1uwlNadJ0WrOQDMcYJNfFurl6GqhsMtNqCvCiCYzwfrOZQovLUQdtOf10pbURXgQf
         pxrchutAbzYICc6R04Z6AaQzwmxoEta0W1oCaJa3CR9lP9R/CL+2buSY9c8mRTTeCOOt
         wKflnsZZ5GulJmTlUyXpc+Ybm951svaYxRDHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDgQSkHHiSrnRRl+XOyzOTrWuP6P/qs63lMjRlAlumA=;
        b=dYz/y8TVfriGDXqX/csW207U8U8jAV+DrgBFXBmusZZ+DcJXtbDBhqKQztQ89T+ReM
         zXMWhRYVH8i9YQe0lvNKQ4xj5rovycqfHH4H/ghksE87jCDOz1shz/uMLeie6IZtpGCy
         29w7ub9CabaGSd4rxuVUSxNkQX66XrkVCKqNJnerQYrCVFvTJ7PbjQlGlFmY+QhsgY1C
         D/0+0c8fA5LCf9jm73rMZ9JghFuDGPV8HuKJ7U0P0jjF0lHEx1jOhsPs0VyAMTzael79
         B9nEoBK6VN+rjb2zyYLKsUHy1+XgAzpfWbbf1uDDJcUb0gl4He29Uk4pDsxNacdCJWCR
         4fVg==
X-Gm-Message-State: AOAM532ZuJB7O/e5H5QSYSnD8bKcDBcd1ENDYgF/5PoW+sL10nOf+J0v
        kzn3bMryhFd06AoC8X6aLdpqdkoQ3rjtpm1L
X-Google-Smtp-Source: ABdhPJxlQnMUJvjkuX8C+obyuwpKV63ulFZoBRnIHHioIiBw+6pFQAua7nTeiNVUb7oao49rgDDmgQ==
X-Received: by 2002:a05:651c:a05:b0:249:8586:3f42 with SMTP id k5-20020a05651c0a0500b0024985863f42mr8488714ljq.349.1648681452486;
        Wed, 30 Mar 2022 16:04:12 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id bq42-20020a056512152a00b00447431cc768sm2469467lfb.170.2022.03.30.16.04.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 16:04:10 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id p10so32514938lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 16:04:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3055:b0:44a:3914:6603 with SMTP id
 b21-20020a056512305500b0044a39146603mr8634944lfb.435.1648681449455; Wed, 30
 Mar 2022 16:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220330221238.396357-1-zi.yan@sent.com>
In-Reply-To: <20220330221238.396357-1-zi.yan@sent.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Mar 2022 16:03:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=whZ7d8Z4rv5oV9+FLEEk_1A1X=JsJaeAmFZzhDxLqDLFg@mail.gmail.com>
Message-ID: <CAHk-=whZ7d8Z4rv5oV9+FLEEk_1A1X=JsJaeAmFZzhDxLqDLFg@mail.gmail.com>
Subject: Re: [PATCH] mm: page_alloc: validate buddy before check its migratetype.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 3:12 PM Zi Yan <zi.yan@sent.com> wrote:
>
> Fixes: 1dd214b8f21c ("mm: page_alloc: avoid merging non-fallbackable pageblocks with others")

Oh, btw - should this perhaps be backported further back than that
alleged "fixes" commit?

It does look like maybe the problem potentially existed before too,
and was just much harder to trigger.

That said, google doesn't find any other reports that look like
Steven's oops, so maybe it really never happened and backporting isn't
called for.

Or possibly my google-fu is just bad.

                  Linus
