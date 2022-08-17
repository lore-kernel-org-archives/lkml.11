Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DEBC25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 20:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiHQUbc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 16:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242011AbiHQUbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:31:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FBDA8CC3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:31:23 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 12so12919181pga.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/ZIBwdh7AZy1tlqpLcM+wJiYIr87DkwAsg5KZRoqj68=;
        b=Ruh/m0QpeWGCsAuDQ9vLgMeMnPwUDhrl9zrtFVQhUKHT651SheClw0ZDbbdAkAoW1i
         AWWwQTcmm7HgmZLKUbhe1zerjeL6tQndwX0YQvzXZaPS3qkGhMCJQ5MVId2fX3yigKC0
         EkEKImheXVwahv1KCIpsBcpCFuOAVPe3Csobg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/ZIBwdh7AZy1tlqpLcM+wJiYIr87DkwAsg5KZRoqj68=;
        b=N1uw810gQNpel6l8P4SDg+lTdp//mBIciOvtbsN6SJkd/+cd1/w9XTtP0vIe7/Yyw/
         Mh7ErRZWY1VdQxqURlMr2EFBZD99GfU9nxCEQbr4w/vnZiUD2r0KPqRf0bDfcgAh5l9a
         4qTGOBwPneo432IxP+/WqlIVWn0LHeu7pMJnICYz2FQXV7HdjSEtImKa8HgCxGnFOoax
         1ZGIXrrshBky3wFclNJIiLh6e0M4lQuyrBrfL4cITIaELIHOJYdr4mCwJ5VAoPpP5ayE
         xSrZ+wkKxbSxzUufRFMsF+WcN4uQstWRWAo4tNkPUj0YN920S/4j+ZksifLSKkz4Dzgq
         wFUg==
X-Gm-Message-State: ACgBeo0lUR9JVhJaafLhPixMrffVYRkojfcEa9rxrV40inXph9IfNwJj
        8+EvwiXVSnIauoW4qdujAIP5jw==
X-Google-Smtp-Source: AA6agR65FRhlhXg+iyS9uiPMyxhif0H2qZvkrI2JMX3wGGKR0i72/DbE/1rC0DSvM0UBXh9VWHpySQ==
X-Received: by 2002:a63:4f24:0:b0:429:aee9:f59a with SMTP id d36-20020a634f24000000b00429aee9f59amr6255932pgb.180.1660768282990;
        Wed, 17 Aug 2022 13:31:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e6-20020a056a0000c600b00528c7f6f4dcsm10895421pfj.52.2022.08.17.13.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:31:22 -0700 (PDT)
Date:   Wed, 17 Aug 2022 13:31:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: Re: [PATCH v9 03/27] kallsyms: add static relationship between
 `KSYM_NAME_LEN{,_BUFFER}`
Message-ID: <202208171330.BB5B081D1@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-4-ojeda@kernel.org>
 <202208171238.80053F8C@keescook>
 <Yv1GmvZlpMopwZTi@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv1GmvZlpMopwZTi@boqun-archlinux>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 12:50:50PM -0700, Boqun Feng wrote:
> On Wed, Aug 17, 2022 at 12:39:48PM -0700, Kees Cook wrote:
> > On Fri, Aug 05, 2022 at 05:41:48PM +0200, Miguel Ojeda wrote:
> > > This adds a static assert to ensure `KSYM_NAME_LEN_BUFFER`
> > > gets updated when `KSYM_NAME_LEN` changes.
> > > 
> > > The relationship used is one that keeps the new size (512+1)
> > > close to the original buffer size (500).
> > > 
> > > Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > > ---
> > >  scripts/kallsyms.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> > > index f3c5a2623f71..f543b1c4f99f 100644
> > > --- a/scripts/kallsyms.c
> > > +++ b/scripts/kallsyms.c
> > > @@ -33,7 +33,11 @@
> > >  #define KSYM_NAME_LEN		128
> > >  
> > >  /* A substantially bigger size than the current maximum. */
> > > -#define KSYM_NAME_LEN_BUFFER	499
> > > +#define KSYM_NAME_LEN_BUFFER	512
> > > +_Static_assert(
> > > +	KSYM_NAME_LEN_BUFFER == KSYM_NAME_LEN * 4,
> > > +	"Please keep KSYM_NAME_LEN_BUFFER in sync with KSYM_NAME_LEN"
> > > +);
> > 
> > Why not just make this define:
> > 
> > #define KSYM_NAME_LEN_BUFFER (KSYM_NAME_LEN * 4)
> > 
> > ? If there's a good reason not it, please put it in the commit log.
> > 
> 
> Because KSYM_NAME_LEN_BUFFER is used as a string by stringify() in
> fscanf(), defining it as (KSYM_NAME_LEN * 4) will produce a string
> 
> 	"128 * 4"
> 
> after stringify() and that doesn't work with fscanf().

Ah yeah. Thanks!

> Miguel, maybe we can add something below in the commit log?
> 
> `KSYM_NAME_LEN_BUFFER` cannot be defined as an expression, because it
> gets stringified in the fscanf() format. Therefore a _Static_assert() is
> needed.

Yeah, please add a source comment for that. :)

-- 
Kees Cook
