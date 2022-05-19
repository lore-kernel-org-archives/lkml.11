Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E20C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 23:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbiESX1Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 19:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343528AbiESX1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:27:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E916106561
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:27:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF6C161935
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27022C34114
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 23:27:20 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="NJTppc0s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1653002837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bWfT48bof4DVuEig2bfh2aXNkmL9/2QWl1dz1TZ/JEw=;
        b=NJTppc0sRBO82SeVbOT0V5LZUxaWphmdGingDDLkpQOrUrdUuZfBSeeVZ8HGx24xr0OZPL
        FZ4Zh9r63Dgesg/9wbVsGBt/oM+9hDkgU7yLJRFX3jp7gsU6AmbIqNpitHDxDC3Me2Pafh
        3uWIjyTF1ftQNQrmT+QXfTuUTcwYzOg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1c5c4ee7 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Thu, 19 May 2022 23:27:17 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id x2so11236324ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 16:27:17 -0700 (PDT)
X-Gm-Message-State: AOAM530lhCT2aIyJ8w8Lx6aFkcJB4mlWoabaBDxEUyZDQh9l9a5Hgri5
        5FhN9H2MVvyx3ck16qMIC/RhS2pI3HxWbqZGlhM=
X-Google-Smtp-Source: ABdhPJyf0vVmxlZkg07270kqMxjh91eXdfhgbO4IuiwIzF1jSlHeyVMZQHGWqRGOnDGgqPQZH0RhbH9rdUD0zWUjh64=
X-Received: by 2002:a05:6902:507:b0:64d:e8c6:942c with SMTP id
 x7-20020a056902050700b0064de8c6942cmr7029118ybs.267.1653002836532; Thu, 19
 May 2022 16:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220519193133.194138-1-axboe@kernel.dk> <YoajCafKmgUbbaY0@zx2c4.com>
 <a6c843ff-a3d7-ce6a-4e99-70968834a02a@kernel.dk> <YobPB27Ozl7uqUEu@zx2c4.com>
 <3553b935-0aca-3d3e-2495-12288f601b53@kernel.dk> <CAHmME9riX+YuqSVp64bhy=nX08_7d-m8es82BHy2qh-oWkqa8Q@mail.gmail.com>
 <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
In-Reply-To: <aa7ae20c-a2d7-4959-b5fb-efe7b56294f1@kernel.dk>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 20 May 2022 01:27:05 +0200
X-Gmail-Original-Message-ID: <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
Message-ID: <CAHmME9oLPxzsnRezFPFVssmedOQUi2E9NWFbakEe92=Hdk1QuQ@mail.gmail.com>
Subject: Re: [PATCHSET 0/2] Fix splice from random/urandom
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Fri, May 20, 2022 at 1:25 AM Jens Axboe <axboe@kernel.dk> wrote:
> I'll leave that to you :-)

Alright, I'll have a look. Which one do I want here? This series adds
splice_read/splice_write. The new thing would be sendpage? Or
copy_file_range? Or something else?

Jason
