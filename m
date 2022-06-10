Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258E8C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 14:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344568AbiFJOdK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349581AbiFJOcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:32:52 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0861715A774
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:32:08 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id x13-20020a0566022c4d00b0065491fa5614so13359466iov.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 07:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=dBwT/GewIb4u/iM9PTgYVKCQr4XeG2XuGw8gqgFMWzo=;
        b=7Z72dWVnSEkOEkfPz/1Erc/WZbTHI9TaoBOYUuY0xeFtQMl6zfssxUsUsiZG3YgIe9
         IJsnm18eARhLA5ib0S9Vfdl+Ke4ZcNIxvvN/13UdPoyqw8t5ymy2vorc01gLyWNrUV0j
         h9zSkxckNgLsXnHj2KX7ysi90B+p47Qo3j0ybXa43ZWrBL5f2/8mBPWBgKOK9JBVCeEe
         db9nBAVNeQuLl8JBOzNtPr7nAg1j24QUcuGlYyrznkM4qxjgYKgN8Z6o26dkk7N5Mpdq
         N54s6BeyUVs7A6O/FjmgviWk4jiK9+zYE2GiW75kgRn3A08en5IPVxiMxP3eUZrK0quO
         4i3w==
X-Gm-Message-State: AOAM53046cHgK17VKj03HJ+PfVxqqz0a15wjEHzbKv9fSnbq6Wdu/XOx
        P/oO7LuoHU1PKzvmaUwhHGenmiuULJMOuJNDklUJeX6tahXY
X-Google-Smtp-Source: ABdhPJxZC7xLFJwZPQpK28/wlVTKx8U4aObsuf6r6sNYsMk+4XSkmM+KJia9oHhaqiBdSsxIr1q6P+1MUGVKAca5nBLajkDgIciS
MIME-Version: 1.0
X-Received: by 2002:a92:ca08:0:b0:2d3:c490:40c3 with SMTP id
 j8-20020a92ca08000000b002d3c49040c3mr26018727ils.167.1654871528295; Fri, 10
 Jun 2022 07:32:08 -0700 (PDT)
Date:   Fri, 10 Jun 2022 07:32:08 -0700
In-Reply-To: <20220610141252.1266-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097d22505e118cdbf@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in inet_bind2_bucket_find
From:   syzbot <syzbot+98fd2d1422063b0f8c44@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98fd2d1422063b0f8c44@syzkaller.appspotmail.com

Tested on:

commit:         664a393a Merge tag 'input-for-v5.19-rc0' of git://git...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13c9c95ff00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9b19cdd2d45cc221
dashboard link: https://syzkaller.appspot.com/bug?extid=98fd2d1422063b0f8c44
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11405720080000

Note: testing is done by a robot and is best-effort only.
