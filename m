Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B73C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 04:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245752AbiEDEeT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 00:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbiEDEeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 00:34:16 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7D92717C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 21:30:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so4158554pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 21:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ss87FSqUni7rDXSoxiu7XmQ/S9n/UK2R/Ew6b8zs5Do=;
        b=YyZvqaN8apSl08J8dH8FGbeUv8c4HJ/nHqUrqhpiuVq5HEEeW8jpk5PgiodHWz5sSu
         BjCUdhXJhsgk9WpSJBE6W3Rh5ls7C7zkKCJkrUpBtJvipm0D3pZo2XHY0C3Foa0aVnN5
         ExH2IgR6gIiHgEruLe4RLzYalm9hE3xbsGe/jFxy+KQaX4xE5+foGVK460WGikbYa6Cq
         2+wqYq8EChJlZMgC+nGcp1Y8As8trJTcsv1bTh2i5RBYXIcBUnqTdhEhQVZqPxM8dASr
         oBAD6HGp3PW9Cpbo6seeOXqtst70QXBizSICfi71ZZ3f0zQmjQKkLRl5oJcNZe4lWNvK
         agWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ss87FSqUni7rDXSoxiu7XmQ/S9n/UK2R/Ew6b8zs5Do=;
        b=Vf7siD3Tee60nLDSCTvn35+0Kz17uHifhBjdZswpMjoRHsqMLU3C59D6iwrUjm50f7
         usMVFLq5PuRU/NwmoVL7XJxQ2vafzPBcwuVemXpRHzxQm+Vea2A3U1gUt96a8ffdTqzL
         YVa6E5KsmQRyaUp0YCMGqs/ebRAhgmCF4jr0RJDj4MG0Qziqr7JFlKsUHobnk59TU8cm
         PQIdP0aQ1lal45GB78nQ+18M+oTZqiM74D/sOwO5Sur0zHRikh736se+/swm3vOcx6ks
         ImeNb9x17IeknGfRLNhWrThICWVEa9cOgjeiLWtQj2Xii5T9Wn+c8jnz9XvfKFAWu/Bi
         YnHQ==
X-Gm-Message-State: AOAM5305/69NW8geifCoczytX5O3vleJVJuxCGkSV2xZ1R1qyzcgZXFF
        shQ+q2ioG7JszFWBleThtcY=
X-Google-Smtp-Source: ABdhPJy2Y5/8OtXOPu/c1PKe4tkQfKkiCMcKdk/4GYE24NkhI+XeVbHPONv8WcaSkpFIqymsNUncQg==
X-Received: by 2002:a17:902:c78b:b0:15c:e5dc:4f63 with SMTP id w11-20020a170902c78b00b0015ce5dc4f63mr20013137pla.90.1651638641034;
        Tue, 03 May 2022 21:30:41 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8998:54e:9def:1e7c])
        by smtp.gmail.com with ESMTPSA id w10-20020a170902d3ca00b0015e8d4eb298sm7153537plb.226.2022.05.03.21.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 21:30:40 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 3 May 2022 21:30:38 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnIBbjRYACzvuZpp@google.com>
References: <20220503170341.1413961-1-minchan@kernel.org>
 <YnHzvV2Uz2ynENnG@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnHzvV2Uz2ynENnG@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2022 at 04:32:13AM +0100, Matthew Wilcox wrote:
> On Tue, May 03, 2022 at 10:03:41AM -0700, Minchan Kim wrote:
> > -void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc);
> > -void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc);
> > +void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
> > +void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
> 
> I see the build bot already beat me to pointing out why this is wrong,
> but do you not look at git log to figure out why code was changed to be
> the way it is now, before you change it back?

This patch added a new field as out param like compact_control so
the rmap_walk_control is not immutable.
