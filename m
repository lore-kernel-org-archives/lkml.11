Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD65C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 23:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240602AbiCVXkI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 19:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241008AbiCVXif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:38:35 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B8FB61A1D
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:37:07 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id g16-20020a05660226d000b00638d8e1828bso13432342ioo.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 16:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=nxTGya4rQb08tK4gHJKHSTw3wZe8r7lubNldP0E5UM0=;
        b=PQIK8mO5Tx0d8P7yxXme7Jo3+8VSBTmnPKwjLDBF++afWdy1K6aXDy1km/1eY8EyJf
         clgp+O8IWSiZL9CV/G5zmGg/jnrbA305vn5Fg+wU1A+T4zIt6NyzwgwtQko4L/6B0Pvj
         6wnERLqZ/6DOjh4E8Dd0+LSLc+Y4uLV2b1V0Vp39EmoHYMA6YiCpBDM5Y+8VkuS9QZtY
         igBQz5G4bauBM2XzoToRsRpKtLAOAYA6eqkVgGRIa/JL6Tyh10xwdZcKgW71E+6ffGfC
         Dmw2PcfD9pl4760N6oNs5nJZr1dsYLRqiyISxZcAfhCPbjP1PF+bpTSkH72tqbjCmoxO
         3MYw==
X-Gm-Message-State: AOAM532mMInRY6ndbyz9RLBYEfMX49ztpWKlzgQKUp38I85O7jj6rIUM
        IyRD8L5JOJfQIMKVrKYDMDVLiQXZ4tJEbpFhS3Lrboas2Osp
X-Google-Smtp-Source: ABdhPJxkBIOSGWs6S8nhxejuf9nHwhVtj7JyAqCDEH/z3FhT2iqZsZ6dhC1IxoNid3/SYYBBE6W47SN+xfAXn5CzD4+KmXXPCsmG
MIME-Version: 1.0
X-Received: by 2002:a92:6012:0:b0:2bd:fb5f:d627 with SMTP id
 u18-20020a926012000000b002bdfb5fd627mr13275273ilb.86.1647992226627; Tue, 22
 Mar 2022 16:37:06 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:37:06 -0700
In-Reply-To: <00000000000012e22c05dacabb11@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042c81b05dad717e6@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in add_wait_queue
From:   syzbot <syzbot+950cee6d91e62329be2c@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, io-uring@vger.kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 91eac1c69c202d9dad8bf717ae5b92db70bfe5cf
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Mar 16 22:59:10 2022 +0000

    io_uring: cache poll/double-poll state with a request flag

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1280c825700000
start commit:   b47d5a4f6b8d Merge tag 'audit-pr-20220321' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1180c825700000
console output: https://syzkaller.appspot.com/x/log.txt?x=1680c825700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=63af44f0631a5c3a
dashboard link: https://syzkaller.appspot.com/bug?extid=950cee6d91e62329be2c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14506ddb700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139b2093700000

Reported-by: syzbot+950cee6d91e62329be2c@syzkaller.appspotmail.com
Fixes: 91eac1c69c20 ("io_uring: cache poll/double-poll state with a request flag")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
