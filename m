Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5889C4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 18:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237143AbiCQS61 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbiCQS56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:57:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E88165A8F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:56:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bt26so10573491lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNUNjaBCVasZfpBbOFNsbgHTLCGoLifuHLYmJKwlzBE=;
        b=HeYHtJ7Lk2fsSlITrtcBvb02gBAgV1u/Sz4/x831laGr7/psVM2Vbs9QGHfqxX8ulj
         ETvly1hrDFAdBIkS6/pnOGOojuIuqFayBbrVkJA2Yg34jQUErKO5bfvQC8X7c1+Ld0U9
         QrOOBvFDNRMZ8/V6mj/D7xyEVdr1YXu71Zhpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNUNjaBCVasZfpBbOFNsbgHTLCGoLifuHLYmJKwlzBE=;
        b=dnH9+vkf0kcfFlCHcxv2T+QMRocMcUz0xxKL0Z2zYyhcZAHBWoIXcqvys0RSd5mTS3
         aJm6uHbVvfn7Yvk4bk0odYaEVis7zfCb2yrzDhnIUmE8l133Ej0Nw0b/TYJwNFT+xtKG
         JEs9S0HhM4jZ9rVO5WikJ0tC1k2/uPupCqw2ETk66ebHHlTa6IgPxWk0BnZsgwYsZT3/
         RxJO4MylHgDZKqsugm37uK3atJy1ZDd83SFEEYjQk/9KVKnAc/tLj075p3lHFYKubSjP
         p8BYaJLxbAGrvsbvsJh/ENMbO672cAmWr2UC4LYf+34H7URiEqlH43MdG84jSqqytzOD
         fNSg==
X-Gm-Message-State: AOAM533rcRUxL2s7y8IZ7+f0LbOJUDayRJMxjALxGz0JBASO+eudxGtW
        +7jgLHDgRNQ3AhNhRJLcMJVHdBn8k8zxJLPS
X-Google-Smtp-Source: ABdhPJy+5yK3abkslp8A8sJUPSD6ksn1qhQmQ3mQz19njhrR7its/JM0Df9PY5SVbSrJNkx1IVIhew==
X-Received: by 2002:a05:6512:2614:b0:445:777d:3530 with SMTP id bt20-20020a056512261400b00445777d3530mr3806059lfb.647.1647543399271;
        Thu, 17 Mar 2022 11:56:39 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id t22-20020a199116000000b004486eef2bdesm507501lfd.272.2022.03.17.11.56.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 11:56:38 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id s25so8486482lji.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:56:36 -0700 (PDT)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr4044603ljg.176.1647543396246; Thu, 17
 Mar 2022 11:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000085b1b305da5a66f3@google.com> <CAHk-=wjLNbf7viXP74K59jK=sRkg6mUbj0i3qpQvy9_2S4Lbtg@mail.gmail.com>
 <s5h5yoc651j.wl-tiwai@suse.de>
In-Reply-To: <s5h5yoc651j.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Mar 2022 11:56:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh61USn+ATUDM-_hX+8p6Yhsq3RWHh+XR4BihfqFYJX8w@mail.gmail.com>
Message-ID: <CAHk-=wh61USn+ATUDM-_hX+8p6Yhsq3RWHh+XR4BihfqFYJX8w@mail.gmail.com>
Subject: Re: [syzbot] WARNING: kmalloc bug in snd_pcm_plugin_alloc (2)
To:     Takashi Iwai <tiwai@suse.de>
Cc:     syzbot <syzbot+72732c532ac1454eeee9@syzkaller.appspotmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        alsa-devel@alsa-project.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 7:13 AM Takashi Iwai <tiwai@suse.de> wrote:
>
> And, we want not only avoiding the overflow but also limiting the
> actual size, too.  Practically seen, more than 1MB temporary buffer is
> unrealistic, and better to bail if more than that is requested.

Looks sane to me, although I obviously can't judge how well that 1M
limit works since I don't know the uses.

Thanks,
              Linus
