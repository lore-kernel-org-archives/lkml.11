Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4CCC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 23:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiFKXRC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 19:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiFKXRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 19:17:01 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593B3403F0;
        Sat, 11 Jun 2022 16:16:58 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31332df12a6so21580537b3.4;
        Sat, 11 Jun 2022 16:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7tY0AdLKGQcBZThRCKqEnHHKhqjAUktylGqxkcbwV5M=;
        b=MkUznwHRAxP9+dhosAeqvGb2QHCUqhvglnLe+Ay0eMDpsTrsROFrqBqQNV907jqR1k
         PE2DZB0piQZii/9kYn3Nn6qK4782QU37QOcmw7/isWdIyQV+2HSeVQdT43sMKW2+E8JI
         dhOaGyLje/PreClJgBIcQ6/7fcZqE4h66uDkBxHR/kjW+qZwvD5X9qTF+pX9Ulcqw6XA
         P3abM7JyEvmvQmqbrIwWVbuRM2ZH8kxFqEIKDrMHJjfFKdsDBG/HUMY4NmC/FetK5vbt
         q9BwbuOnI+NtI6u57xBjA1qJzpd2I2vWt4s2kFz6zP9JEHmDYIQhgT8OsOrjWu2Qs1BM
         7PeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7tY0AdLKGQcBZThRCKqEnHHKhqjAUktylGqxkcbwV5M=;
        b=xqNv10xmIJZbqu12FRWVcjo7pHjfa/2Pk3/iGQ2l9TyVoYT9e6XNe/QW3GWnqCZcxn
         Oay9ENcMCVdQFAnLmO8qlZCxQi4vmAN2ffYSK2+c8ET3pF4uTV06AclPLSyFHKSz/t5g
         pAAOavfdDV641sV7TTXdhrpaqtw0WfV9bS1PSLQEvBLEh79qJ6yr3m/2SRUtZ00u0+HZ
         ZeT5quJXLxtVEgKOa77QgwtkmLFLAz9Vtxfx9OT5mHPFpB9GUQ5ecxq/vTnEokh16f32
         vmsb5nJNSiIyzgwSyx+T7EgGl03wQQFTDRGwH3zSqUsmyeMZP7gDTsBqCXIK02YJP/kP
         m91w==
X-Gm-Message-State: AOAM530B1FLOB3sr11dUKgUar+41JwhwiLVsqJjC+cvBaCtCc0/wXrAh
        A4yN+y06JXJtIEpFG3xHltbv2YjF/yrFULsHSak=
X-Google-Smtp-Source: ABdhPJzlwYpvKTPyyPdeXtV2pl9MFSrG58VQNbCZMgzIM4+A3xkdjLHgnk9bXvveXs22MFjk8SlQTB1IJrT1XFksgVA=
X-Received: by 2002:a81:25cc:0:b0:30f:ea57:af01 with SMTP id
 l195-20020a8125cc000000b0030fea57af01mr54129487ywl.488.1654989417608; Sat, 11
 Jun 2022 16:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <YqRyL2sIqQNDfky2@debian> <YqSGv6uaZzLxKfmG@zeniv-ca.linux.org.uk>
 <YqSMmC/UuQpXdxtR@zeniv-ca.linux.org.uk> <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
In-Reply-To: <YqSQ++8UnEW0AJ2y@zeniv-ca.linux.org.uk>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sun, 12 Jun 2022 00:16:21 +0100
Message-ID: <CADVatmOJvTj21vrL5cnAVjWx46cB4r_kB+T2ankDj+mKH2-7=w@mail.gmail.com>
Subject: Re: mainline build failure due to 6c77676645ad ("iov_iter: Fix iter_xarray_get_pages{,_alloc}()")
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Gao Xiang <xiang@kernel.org>, linux-afs@lists.infradead.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 1:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sat, Jun 11, 2022 at 12:37:44PM +0000, Al Viro wrote:
> > On Sat, Jun 11, 2022 at 12:12:47PM +0000, Al Viro wrote:
> >
> >
> > > At a guess, should be
> > >     return min((size_t)nr * PAGE_SIZE - offset, maxsize);
> > >
> > > in both places.  I'm more than half-asleep right now; could you verify that it
> > > (as the last lines of both iter_xarray_get_pages() and iter_xarray_get_pages_alloc())
> > > builds correctly?
> >
> > No, I'm misreading it - it's unsigned * unsigned long - unsigned vs. size_t.
> > On arm it ends up with unsigned long vs. unsigned int; functionally it *is*
> > OK (both have the same range there), but it triggers the tests.  Try
> >
> >       return min_t(size_t, nr * PAGE_SIZE - offset, maxsize);
> >
> > there (both places).
>
> The reason we can't overflow on multiplication there, BTW, is that we have
> nr <= count, and count has come from weirdly open-coded
>         DIV_ROUND_UP(size + offset, PAGE_SIZE)
> IMO we'd better make it explicit, so how about the following:

Thanks. Fixed the build for me.


-- 
Regards
Sudip
