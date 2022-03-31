Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA244C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 19:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235178AbiCaTIj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239928AbiCaTIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:08:02 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD82220FC8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:06:14 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id w28-20020a05660205dc00b00645d3cdb0f7so320093iox.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=r/0Q/v7LxnQii6Wat+1eXZLZ1gIDdS2hR5mCVVjGKVU=;
        b=iwCKKCzo/n7DAzb8RvWrbmQoCKd8lG7d9fC3DXS7KKgWKChVX/ATM+clWEoCnUcVgS
         DeSXBAz8dnvQPUsKvstiIxkiDlu+qYlSVaVshwLernFgwaxrf5Bi7fHyVH6doXoCOPII
         cSmWUIYypvAYqDaGnb7+pGiEdHpCQZLT8VNqX6wlSQ3wQ34A2J/ixFrimtBwCWl4xUIk
         oQ+0an7fy9uGP48bDcG2uZxR8BCVQoFxS/DjGD0+RNp+s/qcfz+hooA8Qo+GF/jEc1So
         7XlmKSV843FdbPNTMGpziny2Jrt0eppCyGx6J2chjwsr45EuzgYPJ6wh7jUL/7hoqo2p
         heCw==
X-Gm-Message-State: AOAM531giv0vUjVJJNxJG1mm4vM0BSpBlURYHocHwZE7ARNbVFs+vvG7
        Ca+G63WJwkkY6GPUJLIsF4u1g1/4D3cCnKKgUb/vndG4DJwX
X-Google-Smtp-Source: ABdhPJxhLwKFZ45jya0LVhjew/uXFv5NxVPTM0yGlD2OYJVrGpYWtkpe4WTktB5ooY57V7udWcsSpk1vZJPjYdvTK/6ygZ7oJpx1
MIME-Version: 1.0
X-Received: by 2002:a02:b10f:0:b0:323:9bba:a956 with SMTP id
 r15-20020a02b10f000000b003239bbaa956mr3701828jah.313.1648753574205; Thu, 31
 Mar 2022 12:06:14 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:06:14 -0700
In-Reply-To: <7f56f140-ecf0-d72b-b891-171a0aaf21ca@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001ce19705db885baa@google.com>
Subject: Re: [syzbot] KASAN: null-ptr-deref Write in io_file_get_normal
From:   syzbot <syzbot+c4b9303500a21750b250@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c4b9303500a21750b250@syzkaller.appspotmail.com

Tested on:

commit:         9570a845 Merge branch 'for-5.18/io_uring' into for-next
git tree:       git://git.kernel.dk/linux-block for-next
kernel config:  https://syzkaller.appspot.com/x/.config?x=6a82c1abd4cbb9ee
dashboard link: https://syzkaller.appspot.com/bug?extid=c4b9303500a21750b250
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
