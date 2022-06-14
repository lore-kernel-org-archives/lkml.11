Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA25C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 17:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345051AbiFNRtz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345029AbiFNRtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:49:50 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C19D44132F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:49:49 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id u99so16382870ybi.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9HssQcvv+z8PMOk3w7trm8lob60ctWFcsyzhbTHkSh0=;
        b=nn/vJ8LnxV4y5b2PuVbbt1J/VBwpoZbFlgmg33sw6MgHr50fS2e9v94ZHMC1UNjj0u
         YtAChRXlf1KXvkPNjhD5qeqFzNyF397fzsPmUWDCf/0kwSE3ukH3IM43fPPl9s/c8v4V
         XA7C4RnbnkTWRE94yaKshUFkUGxdfPzmMgCu5RIyxOfuYPjx0Q6x5gMmiFHGYEQeD5pc
         54GjSM6KorNdJGP5kLwmI+a0TWdkJMuhsEQ70TNlP70ZMi3d9igKsZL53kcbr5jyNiKQ
         FG1pKyROK2VDZ7nn7vTocHpthJjf/Y7RM8ER/EViKQ7+tc77I/nSYW3YHKH73SLTtH1I
         U+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9HssQcvv+z8PMOk3w7trm8lob60ctWFcsyzhbTHkSh0=;
        b=iyEVv4F9MiWrigrLzu/HeRC8e+q+ILpC8ktxqVyQN2oUlvoNoZAfMKIi0BsPCBAhJK
         IdDHeDk4/fJVnj8dkUtnF4KLJorciEzFQic+09bIl52cZF4gDF5K72IbhzP+JsTZ+eTh
         /Bj1sm0aC7LlA4gn3ONiDgVlxkO3oym5/zAwC6v+hZeV/6rAzfV0U/lafHEHEt+v5pdk
         8eGPZVgFSHC7YIHW+/AQJl0+HYnCIon+EzXX5fmYnD0g1KKQzhLqMUirTE2p4TT3kXcu
         0cbOLMJ/IguO+u7KOMdZDIFR7BxhLGOJ1QX5Ih9TK/eQYCXJ65ODsgJwU/ySOIhaSQfF
         5peg==
X-Gm-Message-State: AJIora8raBIGAXOeZOELy1FFUyckdU/PYBp7f7BXYoyd+r2qtu+0hToq
        /hxmxaoDUfiDkbHzTdXimJLy2Vlfij94hfI15Js=
X-Google-Smtp-Source: AGRyM1t7eamBoCcTiRk0CAMvHWvlPV/gdt1veg9RZAslhtt8XbZtdUgVF9TI8KMPBJToajZs+i2yQNWe0Eu+3JRYZsI=
X-Received: by 2002:a25:7209:0:b0:663:f48e:83d6 with SMTP id
 n9-20020a257209000000b00663f48e83d6mr6158586ybc.76.1655228988939; Tue, 14 Jun
 2022 10:49:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220613155612.402297-1-daeho43@gmail.com> <Yqge0XS7jbSnNWvq@sol.localdomain>
 <YqhRBZMYPp/kyxoe@B-P7TQMD6M-0146.local> <CACOAw_wjCyTmwusY6S4+NgMuLOZm9fwGfrvCT272GJ01-RP6PQ@mail.gmail.com>
 <Yqi+vyY4K0mzEdeP@B-P7TQMD6M-0146.local>
In-Reply-To: <Yqi+vyY4K0mzEdeP@B-P7TQMD6M-0146.local>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Tue, 14 Jun 2022 10:49:37 -0700
Message-ID: <CACOAw_xw3jN2KQaiG7AgCttaQr+uqJme=rsj8AT9wdsGWj3iVQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: handle decompress only post processing
 in softirq
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Daeho Jeong <daehojeong@google.com>,
        Nathan Huckleberry <nhuck@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, I heard that you folks are really suffered from the scheduling
> issues. But for my own previous experience, extra memory footprints are
> really critical in Android low memory scenarios (no matter low-ended
> devices or artificial workloads), it tossed me a lot. So I finally
> ntroduced many inplace I/O to handle/minimize that, including inplace
> I/O for compressed pages and temporary pages.
>
> But I'm not quite sure what's currently happening now, since we once
> didn't have such non-deterministic workqueues, and I don't hear from
> other landed vendors.  I think it'd be better to analyse what's going
> on for these kworkers from scheduling POV and why they don't schedule
> in time.
>
> I also have an idea is much like what I'm doing now for sync
> decompression, is that just before lock page and ->read_folio, we can
> trigger some decompression in addition to kworker decompression, but it
> needs some MM modification, as below:
>
>    !PageUptodate(page)
>
>    some callback to decompress in addition to kworker
>
>    lock_page()
>    ->read_folio()
>
> If mm folks don't like it, I think RT thread is also fine after we
> analysed the root cause of the kworker delay I think.
>
> Thanks,
> Gao Xiang
>
> >
> > Thanks,

I don't think this is not a problem with most devices, since the
allocated memory is not too big and it'll be kept just as long as I/O
processing is on. However, I still understand what you're worried
about, so I think I can make a new mount option like "memory=low",
which can be used to give a hint to F2FS to have a priority on as
little memory as possible. In this mode, we will try to keep minimal
memory and we can use the previous implementation for decompression.

Thanks,
