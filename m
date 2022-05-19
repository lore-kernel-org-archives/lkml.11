Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDCEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 23:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245724AbiESXYJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 19:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241874AbiESXYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:24:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD5910657C
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53DE7B828D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B393EC34116
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:24:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JQg6UnLz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653002640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sIDkt1OCI8X0BLZktYQl8dg6BjT6OxWGAMz17UCt98M=;
        b=JQg6UnLzgnyN5LuZaqol0hfI0aypwpw6NiFctHfnyIWdQUIumE7QFeOcNcyrHt8aMamxZr
        8vqyXHpPTW4UNLSSQKjkc25aldwBakcq+B4cnTYBZQoV+ixmxhWJddcPB5cg65l3LgHDCz
        P8i6YJCnWE9jKvpfWlPkEoGe+LTkFwk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0d9390c8 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 19 May 2022 23:24:00 +0000 (UTC)
Received: by mail-yb1-f179.google.com with SMTP id t26so11565919ybt.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:23:59 -0700 (PDT)
X-Gm-Message-State: AOAM532QXILdzqH5vvVtSUIbXwCa0Q7n40ifXaHFqsRnw2SSzU8XAK6u
        njk1Pw2GmmApcoaprPmxMyUIIktchCB5FA1Et0M=
X-Google-Smtp-Source: ABdhPJyfQn+cIr6pOL+XkvG5YI+uwiO/SRkxIXqAtBesrwruWr9I6pc2oDYT1PtZ3Hms/+T7Q3FPdlR3Aa3znSyAjMk=
X-Received: by 2002:a25:bf85:0:b0:64a:422c:24e7 with SMTP id
 l5-20020a25bf85000000b0064a422c24e7mr6982080ybk.637.1653002639398; Thu, 19
 May 2022 16:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220519193133.194138-1-axboe@kernel.dk> <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk> <YobPB27Ozl7uqUEu@zx2c4.com> <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
In-Reply-To: <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 20 May 2022 01:23:48 +0200
X-Gmail-Original-Message-ID: <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
Message-ID: <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, May 20, 2022 at 1:19 AM Jens Axboe <axboe@kernel.dk> wrote:
> The source and destination for the copies are exactly the same with the
> change as before, so no changes there. The non-user copy is a different
> helper.

Oh, okay. Maybe a silly question but: should we wire up that helper
too? (If I'm understanding your meaning right.) Seems like it'd be a
good idea to just wire up all the things while we're at it.

Jason
