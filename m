Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D2CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 20 May 2022 08:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244428AbiETImE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 May 2022 04:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347397AbiETIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:41:32 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E2763BDC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:41:30 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id w14so13079251lfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mOM3/bXCDSJ92n64FbMH5hkxby+aWy4nmII/rMMLa6s=;
        b=aBTsMjpo5a0JI53DGkowLuB+EgUd542Asyjlt9vBPtUGTaLS6s199Hqs9zX1zVmDHf
         ni9SWEsIYw4KfL41gYhFHrDDvkijSNH0TfSUH+Avfx0HKUak1vMNkrVlUlC9T26x9W7/
         ksEArMkLaCAo6g84mSV1nvezZXN6WnfK1/4VhPNX0F7M/SNGDo+3UOQNObkjPMjfg0X1
         BZBwiF5AMoD/Uq8ET5Ytcu/1oeIAwdDbZVMgwW9kyh9Y4sumDOA09NsgKsSJRPnK/+zA
         JpzVAsAEdJJjA+tWHv+2WK/4rkYoacjsa6C8OR1Ru2DEaSbroriOhbXVEx1Rmb5WXA4q
         fSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mOM3/bXCDSJ92n64FbMH5hkxby+aWy4nmII/rMMLa6s=;
        b=UUE9PQyXqR+f4Mfa4S4Raihwbcf1fI/iGi2KZmNYgyxrl64dt+j9tuSV3vGpBaz09+
         DYDzkIrqMSy3lZzFEGfe5XuGQWyHGQwZhJrYxtogYKdOSiK4lXHfLZmssTl+MnuXbIQH
         LY+upXRIJex/S3Yy8e4kE5rz94jkPtJVK1WFKQ37Q0fnNgGhcNmb28ZRWh9KPWFaCxW2
         x5yvtCuXKd8EN7aohUCjbiFwPH37DLuypnOk/hn6QfTSWMpoKkOyGENssdC4w8qTVfl9
         Yfej/drw2/eL4El4XvSGkxU5eCSjVTAtUwdYiLfM1SoBABn5tSPEAP6U5XKcVfyC/7aG
         6jwg==
X-Gm-Message-State: AOAM531jtoynR9YE8i3oLWHbCXAah8Jxtx1mPEvelwVNnvYXTQIhMa4P
        hm1UbKw7wmwqe909cDgwI+Y7ZQLDnjdWaivm1pnUlg==
X-Google-Smtp-Source: ABdhPJwESBHW/XZ/646NXd8royKCOv0R5aOPj1t/RZqKCDp/1YjSS8L0pS0nqqPng00EAJzWLMS4/pUqepkrCBNINew=
X-Received: by 2002:a05:6512:696:b0:473:a6ef:175d with SMTP id
 t22-20020a056512069600b00473a6ef175dmr6305530lfe.540.1653036088376; Fri, 20
 May 2022 01:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f0da6305cb1feacb@google.com> <15a67989-9ad7-11ef-9472-8e16ca6ec11a@kernel.dk>
In-Reply-To: <15a67989-9ad7-11ef-9472-8e16ca6ec11a@kernel.dk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 20 May 2022 10:41:16 +0200
Message-ID: <CACT4Y+bNGPfF-z-9fxCXQO7huMJ=yCknWm_-H=7CJNvKOne3qA@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in __io_arm_poll_handler
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+ba74b85fa15fd7a96437@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Sept 2021 at 02:49, Jens Axboe <axboe@kernel.dk> wrote:
>
> On 9/3/21 5:47 PM, syzbot wrote:
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> >
> > Reported-and-tested-by: syzbot+ba74b85fa15fd7a96437@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         31efe48e io_uring: fix possible poll event lost in mul..
> > git tree:       git://git.kernel.dk/linux-block for-5.15/io_uring
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=914bb805fa8e8da9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=ba74b85fa15fd7a96437
> > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> >
> > Note: testing is done by a robot and is best-effort only.
>
> Dmitry, I wonder if there's a way to have syzbot know about what it's
> testing and be able to run the pending patches for that tree? I think
> we're up to 4 reports now that are all just fallout from the same bug,
> and where a patch has been queued up for a few days. Since they all look
> different, I can't fault syzbot for thinking they are different, even if
> they have the same root cause.
>
> Any way we can make this situation better? I can't keep replying that we
> should test the current branch, and it'd be a shame to have a ton of
> dupes.

Hi Jens,

This somehow fell through the cracks, but better late than never.

We could set up a syzbot instance for the io-uring tree.
It won't solve the problem directly, but if the branch contains both
new development ("for-next") and fixes, it will have good chances of
discovering issues before they reach mainline and spread to other
trees.
Do you think it's a good idea? Is there a branch that contains new
development and fixes?
