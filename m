Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A51C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Mar 2022 00:58:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiC2BAR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Mar 2022 21:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiC2BAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 21:00:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D84AE885A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:58:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v12so8769074ljd.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbT6csJp5gfPs56Yka3GMDExKyohstgFfA3vzHyoz4o=;
        b=hkrcPaaBthoDmVf0x8DqWOp3+DOMUUl364NXBBrlTr+MeObvVj9lA3H/mEfDVmF1jF
         xzadtY24nWv+DJGgoDKv8i38g+H++jeiOO8/nubtuxIxqyDnSfLFXwTvaXRAIFJejJrG
         dSSoHLZV2getqXXTmQOAjSfemMBtGEe7ripPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbT6csJp5gfPs56Yka3GMDExKyohstgFfA3vzHyoz4o=;
        b=ecFAKHVpQYiv6r8X1KdUSpHpbFxam4axUT4uc4mFp7mbWfLW/pqcnp8uIH9kABAqLf
         OK1adEgPrCutI89moED+GHrTa1oMoUXkKhLgRQpjm8FvaxORL/zHjgycZR+114igOCB5
         eo5dqKiPk0FLs4peAqOL/WCwvRcGavrb4tW/nOiVQeT/YSzVDKpuArZNKzSFXcnsFlZ3
         x4AI8gUvGp8zXv9e8d3BLVzldXIHfMNVHT4YjaxcXK9TUV112Nw30WEwTxE/y0qiTebn
         rC4G7tMbAEZCYAzMGO5Zh9BmSXfdT1U76/VGGewcrbPqdmB7Sg3ZgzdPJyc/U2rSpovx
         ooeg==
X-Gm-Message-State: AOAM5338h5isKemgakCgwXxdzOB1YKqjU+d7mnb0gdRUYnvEcDLdGKpE
        s7UInEwXwWcgHAr5rFiFi9dPoMbKoCLjLxP2
X-Google-Smtp-Source: ABdhPJzrjL+SFq4xg1x+BntYRPVixdBKK7ZJgFI7ZRDdkL82OIH/AcrqAC4rVOoowBlfQ9bpFGyn0w==
X-Received: by 2002:a05:651c:1413:b0:249:266f:50fd with SMTP id u19-20020a05651c141300b00249266f50fdmr188838lje.325.1648515511023;
        Mon, 28 Mar 2022 17:58:31 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id bu20-20020a056512169400b0043eaf37af75sm1790901lfb.199.2022.03.28.17.58.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 17:58:30 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id t25so27667541lfg.7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 17:58:30 -0700 (PDT)
X-Received: by 2002:a05:6512:2296:b0:44a:6aaf:b330 with SMTP id
 f22-20020a056512229600b0044a6aafb330mr199946lfu.531.1648515510085; Mon, 28
 Mar 2022 17:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org> <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org> <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org> <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
 <20220329115308.7388b656@canb.auug.org.au>
In-Reply-To: <20220329115308.7388b656@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Mar 2022 17:58:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB4V+XkVvsZmJ4j_K=QKMSj13vDYnVjY0R8fHUmGaF8w@mail.gmail.com>
Message-ID: <CAHk-=whB4V+XkVvsZmJ4j_K=QKMSj13vDYnVjY0R8fHUmGaF8w@mail.gmail.com>
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 5:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> See https://lore.kernel.org/lkml/20220316165612.4f50faad@canb.auug.org.au/

Ok, so it was known, just not reported to me.

And the good news seems to be that at least there isn't anything
hiding elsewhere.

                Linus
