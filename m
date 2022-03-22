Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81CAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 21:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiCVVEl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiCVVEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 17:04:37 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7EC13DC1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:03:07 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id s4-20020a92c5c4000000b002c7884b8608so9836049ilt.21
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 14:03:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=A7UVHLa5gEcZxIqWogg32nPbf3+g0qv3P5D2guYzwY4=;
        b=5UD+Jg//oa17xi5aosvAwm8gza0QTvtaCzOxZVbTTD40qA/i/JuYJMIFTTrhbrVcKQ
         OjLhRvCT9Y1md4Imb84p5PEA9/YrrbG6tM1wlDsCbhHZKkog7iJzX60/i5mecl/7sL93
         QJ/x/+sY/WIKs8O4noQ83U0RzeY9VI6l7i9GntkiVSRze5mS8JJptOPxoLJ/LI1IiHj/
         O63KhDa95y7jLQCiy5H2m6NFUceVsKA4vR4PqPw4jQayhQ1sO+NdKPeWuuBuTzAv3EW6
         FoXdOw9/FG3PUNDODcxqkb4MFvmyIyuTqoxrIQDHrPBcZrBG0QYOwzseXeZZryfQQEfl
         z+jA==
X-Gm-Message-State: AOAM531XiOVrzO77rtLStCvQZCkbIWgkm5p2pPG4OO/Yzkm9738XOnZO
        oNpCI2ll9djA+W7JFrXuNJgKeaaIc9CKtWAoVtKUzNeVHeYh
X-Google-Smtp-Source: ABdhPJwOfvu/x2/eqvCqjcEw4w1ZMKJoI29/lmOcDU7xrUFNR8S2tLZ5XFHn2Mb7ejfSZWlcNOOTFpKWGoNgGamzY32N5Dvw4jq9
MIME-Version: 1.0
X-Received: by 2002:a6b:1495:0:b0:645:b115:611c with SMTP id
 143-20020a6b1495000000b00645b115611cmr13475591iou.199.1647982986421; Tue, 22
 Mar 2022 14:03:06 -0700 (PDT)
Date:   Tue, 22 Mar 2022 14:03:06 -0700
In-Reply-To: <0cd64678-f4de-0e30-87d2-01f32311ee98@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000806a2d05dad4f0e1@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in tty_release
From:   syzbot <syzbot+09ad4050dd3a120bfccd@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk,
        gregkh@linuxfoundation.org, io-uring@vger.kernel.org,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+09ad4050dd3a120bfccd@syzkaller.appspotmail.com

Tested on:

commit:         7d58de1a io_uring: don't recycle provided buffer if pu..
git tree:       git://git.kernel.dk/linux-block for-5.18/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8bdba3010ab9145
dashboard link: https://syzkaller.appspot.com/bug?extid=09ad4050dd3a120bfccd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
