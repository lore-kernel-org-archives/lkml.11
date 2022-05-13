Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74122C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 13 May 2022 12:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380122AbiEMMDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 May 2022 08:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiEMMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:02:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2377261604
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:02:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7ADEB82ED3
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:02:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45174C34114
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 12:02:53 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="coy5xqfG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652443371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1OErOWsuT0Jr0lu98c0hVbu6PukoMngtQIeLqNObUU=;
        b=coy5xqfG8UlWi+mrFlawtW/w39+5uLaSTfM4wCfDRAtbNKXduTNIA21HBwE7q6Ya6YxZ9r
        2EPTJ77P5VVn/SlQwxVfZyjpMskGCzqEgnMYdxy/eW7Bh1WfyoFQ9DVwDtHZ888CS6nnzG
        revql5/S9QBy0fNiCmvly8uZsDmeqVk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b3b4764c (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Fri, 13 May 2022 12:02:50 +0000 (UTC)
Received: by mail-yb1-f172.google.com with SMTP id j2so15030831ybu.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 05:02:50 -0700 (PDT)
X-Gm-Message-State: AOAM532fw5Ejz0HmwGsrMoHD15eU4a9VVpMu1VT1We3DXNXqH6jhyiEu
        feT2x+yzmjTwtzqe/9ll9syxWXtOoOzjCIRE3Rw=
X-Google-Smtp-Source: ABdhPJw1109GvXy0Ck4VnmPSd3e8284CeeUj8dpwQmOFIPv/tz4Gh/zSsYR5cksftoXDL2jz57s3qEhQxNDDKLC1qgY=
X-Received: by 2002:a25:74d4:0:b0:646:cfd6:daa3 with SMTP id
 p203-20020a2574d4000000b00646cfd6daa3mr4360031ybc.235.1652443369811; Fri, 13
 May 2022 05:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220509121409.529788-1-Jason@zx2c4.com> <20220509121409.529788-2-Jason@zx2c4.com>
 <Yn35k+yyrvgAt3tb@owl.dominikbrodowski.net> <Yn4xLowv+farg814@zx2c4.com> <d0dc54cecff5400d97f877676d7f11b1@AcuMS.aculab.com>
In-Reply-To: <d0dc54cecff5400d97f877676d7f11b1@AcuMS.aculab.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 13 May 2022 14:02:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9pN_N_fG6k5gFB8mwrEPn1W-Zy54AmA3VSSvrkQyc3PvA@mail.gmail.com>
Message-ID: <CAHmME9pN_N_fG6k5gFB8mwrEPn1W-Zy54AmA3VSSvrkQyc3PvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] random: move initialization out of reseeding hot path
To:     David Laight <David.Laight@aculab.com>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, May 13, 2022 at 1:38 PM David Laight <David.Laight@aculab.com> wrote:
>
> From: Jason A. Donenfeld
> > Sent: 13 May 2022 11:22
> >
> > On Fri, May 13, 2022 at 08:24:19AM +0200, Dominik Brodowski wrote:
> > > > - if (!crng_ready()) {
> > > > -         crng_init = CRNG_READY;
> > > > -         finalize_init = true;
> > > > - }
> > > > + crng_init = CRNG_READY;
> > >
> > > Why unconditionally
> >
> > To avoid a useless branch.
>
> Are you now dirtying a cache line that would
> otherwise be clean?

Fair enough. I'll keep the branch.

Jason
