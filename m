Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 104AEC19F2D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Aug 2022 07:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiHIHfj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Aug 2022 03:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbiHIHfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:35:02 -0400
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066821815
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 00:33:34 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id qn6so8901357ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 00:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:cc:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=CntXBxHI/kHKDMWJBBfjDOoG5OOq92BHHIC2Q6AAQF4=;
        b=2DrPGuNG4ZOgpVhySqiI09iHvMpqbi9IZB9uBFR5CYd3n3lEzNyOkj0IkghG0CxAry
         SQ/9qb+nNGCO0/9f1wepu+U4zMwO/cZSyv+lZI726eNeXB7sfqqKfusZTNtb6k5oDotG
         xaYQDmsXDWfyLS9i2AGwCwUVB5NhP4XMpmx7OX7nZFqV4TOVIRW2evZqgi3TCopAswsQ
         uvNQfSQXzJypH3f6x5IzZOkOBzbT3Bjke8aX/VAceSVJSvuKRler4IWSIq8+kiEVsukU
         nRD/FTL40w5R/R2V0xhU0hb2nDz90ChMvhY2exJ19dSLMo0tERZGoL5YFhnW6n+DPA4+
         OzuQ==
X-Gm-Message-State: ACgBeo3kkUsJanmCD+xo4UL9JhTrD5vv22Im8CYvB9jWqTX7AONvn8C9
        OFoDKhtNKz+Nod55JNJGr5M=
X-Google-Smtp-Source: AA6agR7bUypHmsphXO8NilGS9qGw0NlkE8KU7Q2a60xObA2hrtqGc0DZRyB0KTRH/0vpUZZvyJPAzA==
X-Received: by 2002:a17:907:2719:b0:730:a5e7:9da7 with SMTP id w25-20020a170907271900b00730a5e79da7mr17040579ejk.26.1660030405675;
        Tue, 09 Aug 2022 00:33:25 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906444d00b00731803d4d04sm794243ejp.82.2022.08.09.00.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 00:33:25 -0700 (PDT)
Message-ID: <19e6b5f9-31a6-33a5-84e2-d6e4e2f0613b@kernel.org>
Date:   Tue, 9 Aug 2022 09:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [syzbot] INFO: trying to register non-static key in gsmld_write
Content-Language: en-US
To:     syzbot <syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000434f7a05e5bab1ce@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Cc:     "D. Starke" <daniel.starke@siemens.com>
In-Reply-To: <000000000000434f7a05e5bab1ce@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc Daniel

On 08. 08. 22, 15:21, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    ca688bff68bc Add linux-next specific files for 20220808
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16c4c201080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4c20e006003cdecb
> dashboard link: https://syzkaller.appspot.com/bug?extid=cf155def4e717db68a12
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151f2b46080000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143a3171080000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cf155def4e717db68a12@syzkaller.appspotmail.com
> 
> INFO: trying to register non-static key.
> The code is fine but needs lockdep annotation, or maybe
> you didn't initialize this object before use?
> turning off the locking correctness validator.
> CPU: 0 PID: 3608 Comm: syz-executor156 Not tainted 5.19.0-next-20220808-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
>   assign_lock_key kernel/locking/lockdep.c:979 [inline]
>   register_lock_class+0xf1b/0x1120 kernel/locking/lockdep.c:1292
>   __lock_acquire+0x109/0x56d0 kernel/locking/lockdep.c:4932
>   lock_acquire kernel/locking/lockdep.c:5666 [inline]
>   lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
>   __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
>   _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
>   gsmld_write+0x5e/0x140 drivers/tty/n_gsm.c:3023
>   do_tty_write drivers/tty/tty_io.c:1024 [inline]
>   file_tty_write.constprop.0+0x499/0x8f0 drivers/tty/tty_io.c:1095
>   call_write_iter include/linux/fs.h:2192 [inline]
>   new_sync_write fs/read_write.c:491 [inline]
>   vfs_write+0x9e9/0xdd0 fs/read_write.c:578
>   ksys_write+0x127/0x250 fs/read_write.c:631
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f80104e30c9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f8010474268 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f801056b4d0 RCX: 00007f80104e30c9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
> RBP: 00007f8010539010 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f8010474280
> R13: 6d74702f7665642f R14: 00007f801047427c R15: 00007f801056b4d8
>   </TASK>
> 

-- 
js
suse labs

