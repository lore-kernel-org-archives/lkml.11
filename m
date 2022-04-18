Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816E0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 15:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345373AbiDRP22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345216AbiDRP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:28:18 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB5DEF0A6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:30:23 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id q5-20020a0566022f0500b00654a56b1dfbso1335199iow.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BN5fWD0TeLhPc5Z6oQepdojRwLAV8DN+bsBK6JxWVII=;
        b=49aCuH5SCS1MRcnEFLrYFY5cB13N7Pv4sFjPqvL95XgYmzAC2N3Nsc37qeid8EcYke
         h1CjJ3+adoLn3qYLcNztAKi4A341HyhFNL39dRvqYc1tDMqu2uO0zbpgsn6kHlhjedd7
         iBXliiwdH8ZEUG6QJsiRxKQ4QjfbKSQuEizhwoVG3zP0/g+9W3QicPlIXA7V4aimdtBF
         z8jpc80TZSAwMDvNAD2aI4DLEUK+OcJdizS0w+OoJFOLyLXtwA/xzLwkXdmm/r6K7tDX
         dtgCjWX2oDM3+ls4v27H99djdEl1BOJ2lNwoqLXwrgp/RXSvUmwCjdiyoDJU53jDef0J
         kKbQ==
X-Gm-Message-State: AOAM532atVHspVENkGoMqf4YPagMmsO96OilUqaVui4QC/qk8lDsrLB9
        bXHN6s4wTDOICK07qqomnHqU/iNYWv7jYJZKjmVazlVpq7AN
X-Google-Smtp-Source: ABdhPJzWzBG11rL3flvX+FuNHTYL4B70FkdlZ6XZyc/KiElQOgqmWmo2ZwISJladuE/r+A9XJjK3YpY4W+BcKBB6DJbhhk1fR4gc
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b29:b0:2cc:354:a156 with SMTP id
 e9-20020a056e020b2900b002cc0354a156mr4757883ilu.194.1650292210558; Mon, 18
 Apr 2022 07:30:10 -0700 (PDT)
Date:   Mon, 18 Apr 2022 07:30:10 -0700
In-Reply-To: <20220418140008.1853-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fc726305dcee9845@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in __snd_rawmidi_transmit_peek
From:   syzbot <syzbot+70e777a39907d6d5fd0a@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+70e777a39907d6d5fd0a@syzkaller.appspotmail.com

Tested on:

commit:         a1994480 Merge tag 'hardening-v5.18-rc3' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb177500e563582f
dashboard link: https://syzkaller.appspot.com/bug?extid=70e777a39907d6d5fd0a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13d94b3f700000

Note: testing is done by a robot and is best-effort only.
