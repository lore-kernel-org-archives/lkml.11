Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8249CC00140
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 16:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiHRQDd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245638AbiHRQDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 12:03:25 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B0E5FD1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:03:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l64so1653006pge.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tv5ULlLKxM0cuyQ6J1iQhNfNqwRvi2Mu8C1ughJ0TDs=;
        b=E8jwzzSWkQZjYK0CTe9AbY7M6bB8NxxJIz7ILJ36UNVCbM0Ka4LYZT8J1DGl3bqPX0
         QYiBjYNWgQVin49A+zu6WhOjtftpm78q+i3lZxR2f8g79FNVN782BBPffwkFDM5Qhce6
         Rg/+3iDQr9tXHcDn/L45hCa9B+zu+rRP+330c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tv5ULlLKxM0cuyQ6J1iQhNfNqwRvi2Mu8C1ughJ0TDs=;
        b=aDr/yt9yJcalpQ54RjkeqOLO8SU7ZV6zEwSXwRonDxwAgiRDIWCWOqpxAOB5A5w0oK
         YRsgTgn1sQxGd2CHDUEvsFwRA7UHJ6Hz/VC8Xwx6xwJGVGf5wno3AIXEEwZwnESQOtoD
         ozTWw7O1qZvkt1vkHmFMt4Hv91jcn+YEUg0jhracUGfd1z0XdTPNOP8+Nt77Ts5xG4q5
         5fs9X3qWdYHGZBmN/LTvDvyie4GdYZxexASRyqMxtqoIo+2ggYwSSmrYsd0x8Q8AH/Kd
         FP/tu+2bQCXN+ktUHR/Hsm/8AThR5e/Dzy5nxWEV09HIGp/639epBpOWJFonRgjZZMID
         4zvA==
X-Gm-Message-State: ACgBeo1SyqkNWcdeoz5ChcG+9zi+0yblrJ0JqPQAu5s8muhhsk43sOYx
        RenXmQ0DeM4mEI3HH0vLZt0ZQg==
X-Google-Smtp-Source: AA6agR6I5By68BlJBuyT8Qm/ntSjcqHInGgvxgMFjK+rM4WhYuZnlmgsqf6IjXF03Hs9zZoNkbKTWw==
X-Received: by 2002:a63:231a:0:b0:429:fb01:3c5d with SMTP id j26-20020a63231a000000b00429fb013c5dmr2790011pgj.583.1660838602898;
        Thu, 18 Aug 2022 09:03:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l21-20020a17090ac59500b001f1ea1152aasm1630436pjt.57.2022.08.18.09.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 09:03:22 -0700 (PDT)
Date:   Thu, 18 Aug 2022 09:03:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Shelekhin <k.shelekhin@yadro.com>
Cc:     ojeda@kernel.org, boqun.feng@gmail.com, gregkh@linuxfoundation.org,
        jarkko@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH v9 01/27] kallsyms: use `sizeof` instead of hardcoded size
Message-ID: <202208180902.48391E94@keescook>
References: <20220805154231.31257-2-ojeda@kernel.org>
 <Yu2cYShT1h8gquW8@yadro.com>
 <202208171235.52D14C2A@keescook>
 <Yv4AaeUToxSJZK/v@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv4AaeUToxSJZK/v@yadro.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 12:03:37PM +0300, Konstantin Shelekhin wrote:
> On Wed, Aug 17, 2022 at 12:36:33PM -0700, Kees Cook wrote:
> > On Sat, Aug 06, 2022 at 01:40:33AM +0300, Konstantin Shelekhin wrote:
> > > > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > > > index f18e6dfc68c5..52f5488c61bc 100644
> > > > --- a/scripts/kallsyms.c
> > > > +++ b/scripts/kallsyms.c
> > > > @@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
> > > >
> > > >     rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
> > > >     if (rc != 3) {
> > > > -           if (rc != EOF && fgets(name, 500, in) == NULL)
> > > > +           if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
> > > >                     fprintf(stderr, "Read error or end of file.\n");
> > > >             return NULL;
> > > >     }
> > >
> > > Might be another nit, but IMO it's better to use ARRAY_SIZE() here.
> > 
> > I'm not sure I see a benefit for char arrays. It'll produce the same
> > result, and the tradition for string functions is to use sizeof().
> > *shrug*
> 
> ARRAY_SIZE() (though not this one) can catch this:
> 
>   - char array[16];
>   + char *array;
> 
> Saves me some.

Oh, that's an excellent point; I forgot it'll actually compile-time
error if the var is a pointer. +1

-- 
Kees Cook
