Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156F4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 05:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241804AbiCWFBn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCWFBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:01:38 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA327091C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:00:09 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id i19-20020a5d9353000000b006495ab76af6so388308ioo.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 22:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6oYDZPp0LBPJzY6rTyL8BNLjnvNtQMaWxnBgcKEox94=;
        b=QzkbIPVYunMCsitgCBR6Q/5SpSsa4YpR4Biqno4JzEpNcm+/mM3d0KOqhE+s/xtbVr
         gf5PFM35MGFLLf0H1yE4XRnct2tgo0QyaYvfWic+2QxfRdrY8kiye71DzOBqXr3rNGMv
         NdaDB86lhIxbWYgGAUybxtL4kH15cJqJB8rKnAEEYdyoKkpgYiqCscWbVfi+R/nhJznr
         ostIfw3DIitriW4SSmgSByiS4wQin9g5Y57YsbMJ/KaeAV9InCI7ZPwaB7bvcsdeY9t5
         BhobM0z0TfLyQynFmx19aIj1LoAUP2DFbTid1af2RBH17ixEdL1va9LuFmleBP5GXM45
         yxZw==
X-Gm-Message-State: AOAM533a7AscTVvwqiZd7WeaQ01lnTWxqBPahqxdhVFlRoB5WkEQBtDC
        WcqqDCvHZeQrxg0xJXY13Q/OE25KUCG34rlNESImmZuU4ot6
X-Google-Smtp-Source: ABdhPJywpzb3LdIQOh5rVskDVLgV8tk+mcgnOSyT+AEYgYLttX0csyUGHT+zmnwungj8w2LzV7rYZny3xppw34szwOommpo4bzx2
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3052:b0:317:79e1:8b7f with SMTP id
 u18-20020a056638305200b0031779e18b7fmr15107849jak.239.1648011608670; Tue, 22
 Mar 2022 22:00:08 -0700 (PDT)
Date:   Tue, 22 Mar 2022 22:00:08 -0700
In-Reply-To: <64edb9d0-859d-c230-edc6-fba0f8a46b98@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085454a05dadb9acd@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_poll_remove_entries
From:   syzbot <syzbot+cd301bb6523ea8cc8ca2@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cd301bb6523ea8cc8ca2@syzkaller.appspotmail.com

Tested on:

commit:         7d58de1a io_uring: don't recycle provided buffer if pu..
git tree:       git://git.kernel.dk/linux-block for-5.18/io_uring
kernel config:  https://syzkaller.appspot.com/x/.config?x=198493467201ec16
dashboard link: https://syzkaller.appspot.com/bug?extid=cd301bb6523ea8cc8ca2
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
