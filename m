Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1904C32771
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 08:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiHPI04 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 04:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbiHPI0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:26:00 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420F41405DB
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:58:09 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id q10-20020a056e020c2a00b002dedb497c7fso6491178ilg.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 22:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=lUHutYvTWkC02k1JHzLmqGKDgiRolEQq5obnJ8zZPao=;
        b=aR0EAEQ5XnN3O5tuXiiOr7Q6LWISdpQhJ6FHS5oKdA8tgWdZ0SHYulotTbBK8EvTZ1
         UIJg+h3XPNUnLR0HEMNiFJkfARDwqbKHIKm68Q0S0H3MHzP4ldE0YZasE2X6IY7OdsFB
         Wzo6O0wAVU2tSYOIlYsXRqT1f7kfiaNSv1O2we0/7ANCeb5K2AVol0ZwdL4Uqkdq3jMx
         m4yo7gX/b5HRaLLKszJpC9XV8OB0Ht42dRQCxVB5HYJY958C7FqHIOFOU3jfjN80ahVI
         RWgqF9mZE3SRJ31dBjkctbPrRY7yS3dKCdrZdWw1CbQLvHT7FUt4cTLqwuFcmhvvSFUp
         076Q==
X-Gm-Message-State: ACgBeo1UiMH5YuCCjCpizqDk6AXhZNAwISk4EdeBYxc9UfwClRUqHldU
        tonR7Xu2RUVVqPHVYZVn8FwoojK2cnQnr2jsXttLoQwrRp8i
X-Google-Smtp-Source: AA6agR5xlqIUCDW7/LHVLDMOCEAifJLoInIbGB8XrCdW2sWYNDqAtG4CM3T91W0o7i7Os/k2xLXXOpNa8DlLGy4FJj8FrzXAZVhs
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194d:b0:2de:a54b:2e51 with SMTP id
 x13-20020a056e02194d00b002dea54b2e51mr8736771ilu.257.1660629488569; Mon, 15
 Aug 2022 22:58:08 -0700 (PDT)
Date:   Mon, 15 Aug 2022 22:58:08 -0700
In-Reply-To: <000000000000aaac8505dc135b07@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c518d505e6556ed8@google.com>
Subject: Re: BUG: corrupted list in insert_work
From:   syzbot <syzbot+e42ae441c3b10acf9e9d@syzkaller.appspotmail.com>
To:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brauner@kernel.org, cgroups@vger.kernel.org, daniel@iogearbox.net,
        dvyukov@google.com, hannes@cmpxchg.org, hdanton@sina.com,
        john.fastabend@gmail.com, kafai@fb.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, lkp@intel.com, lkp@lists.01.org,
        mkoutny@suse.com, netdev@vger.kernel.org, oliver.sang@intel.com,
        songliubraving@fb.com, stable@vger.kernel.org,
        syzkaller-android-bugs@googlegroups.com,
        syzkaller-bugs@googlegroups.com, tadeusz.struk@linaro.org,
        tj@kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d007f49ab789bee8ed76021830b49745d5feaf61
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed May 18 06:13:40 2022 +0000

    percpu_ref_init(): clean ->percpu_count_ref on failure

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10c66b6b080000
start commit:   ebc9fb07d294 ANDROID: random: fix CRC issues with the merge
git tree:       android12-5.10-lts
kernel config:  https://syzkaller.appspot.com/x/.config?x=32c952ff4a8ff8c1
dashboard link: https://syzkaller.appspot.com/bug?extid=e42ae441c3b10acf9e9d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172a9074080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10456caa080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: percpu_ref_init(): clean ->percpu_count_ref on failure

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
