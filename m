Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B485CC4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 22:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiDYW03 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 18:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343614AbiDYVp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 17:45:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9546210C88A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:42:53 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q14so19520824ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0ON/l2oodv3sNlP+eHVo6ZPpiqCxnVVyYN++iumNjA=;
        b=Fbz20CF4Jj2RaIdFgpKFZNrAzaKTxj2Uv1lUdUtavR82B8XjNHdJlqKRYFj8J5sYnH
         2a+cy65W/7lJaACwuKUGno6crPpRa3JpDQ/3evU6c5XeZIM8JF/489oyyF9AR5CR/faW
         UkPxO4Xj9bmhWF8R8j+SJ7JRENzCLryJSbSxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0ON/l2oodv3sNlP+eHVo6ZPpiqCxnVVyYN++iumNjA=;
        b=orlZYkrgB5brEsd5JkCWNGwlkEc6xTkR+RWP2sc/sF9hzdM8Fjor8xtNplzDB6yymJ
         UfbGq66ls+mZzi35gXWJFbXFjiNHPyXUtD46vHjW4VD+xgoPPca8ksBa1yBDW9dwpFij
         Pb7tsPwzthu0OO2qqgn9wcrqD77x1uBeUZpAhl9aV4A0ZV18WpBpDRChlbvgs4YBjpon
         +QApG+yOPbFwQsCho1NM+dq6nkvYGxkbJlL79LjDJztpe+nmD06CxivnMh0uug9rLDXL
         WC7acHWq0FwB3M62T/1JMev27zS5z9N4Ycad21mQ+KLrbx2RMXsmuwGSO+uxkFq4lV3B
         gCUA==
X-Gm-Message-State: AOAM532Fa7maIL4cSdnVRXv/IAkk1Jpb7GZl2xbnXN4i5+zN7DazY/Vo
        CWXCIU/EIcGPVu8oQLQG54dkZaBUjWOsv9eF
X-Google-Smtp-Source: ABdhPJzxqfSAE6HmSSWAytMBB+E4dsOvzwhDlC3V98AFQUrCuWuVaancY7eyB7SdQlb1VBryduC77w==
X-Received: by 2002:a2e:5c81:0:b0:24b:7d:6ae7 with SMTP id q123-20020a2e5c81000000b0024b007d6ae7mr12727284ljb.76.1650922971566;
        Mon, 25 Apr 2022 14:42:51 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id d6-20020a056512320600b0047196449b7fsm1530932lfe.92.2022.04.25.14.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 14:42:50 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id c15so19511744ljr.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 14:42:50 -0700 (PDT)
X-Received: by 2002:a2e:8245:0:b0:24b:48b1:a1ab with SMTP id
 j5-20020a2e8245000000b0024b48b1a1abmr12172414ljh.152.1650922970684; Mon, 25
 Apr 2022 14:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whmtHMzjaVUF9bS+7vE_rrRctcCTvsAeB8fuLYcyYLN-g@mail.gmail.com>
 <YmZvAUakbWnyQEqa@debian> <20220425142706.23e6bea1d5bfdd944e33bc96@linux-foundation.org>
In-Reply-To: <20220425142706.23e6bea1d5bfdd944e33bc96@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Apr 2022 14:42:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiR+dTAw7qRGRQ80B4oUZEithHd2J4ZfNjc5eGqY1mWwA@mail.gmail.com>
Message-ID: <CAHk-=wiR+dTAw7qRGRQ80B4oUZEithHd2J4ZfNjc5eGqY1mWwA@mail.gmail.com>
Subject: Re: Linux 5.18-rc4
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 2:27 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm/nommu.c: provide vmalloc_huge() for CONFIG_MMU=n

Note, should already be fixed differently (with an alias) by

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0fc74d820a012550be006ba82dd8f1e3fe6fa9f7

although when I looked at the random collection of vmalloc things it
did make me go "hmm".

It might be a better long-term idea to only implement the very generic
low-level function in mm/vmalloc.c and mm/nommu.c (ie the
__vmalloc_node_range() function) and then move all the random wrapper
functions into mm/util.c.

Because right now we effectively duplicate all those wrapper
functions, which is kind of ugly.

             Linus
