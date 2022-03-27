Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76234C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Mar 2022 10:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiC0LA6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Mar 2022 07:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiC0LA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 07:00:56 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF89B26560
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 03:59:16 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id h10-20020a05660224ca00b0064c77aa4477so75454ioe.17
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 03:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=JHGXyOygk/7q4MtXArnUOUFIWvMGw5cJdsungG4an+I=;
        b=1JEncpwfPqNUApqbM+MlIQA3/IlZuEgQtIj+mcOYPfRvNhGIDJVNEArgjbR+9ywH20
         zLul3+N0Daum/NLkHSr8f336e5zYUuJURy78UdHL2RbJz+xStDiRuLePvFURtTy+xgh7
         K2uzQzzv5WQzx8feGQWBDuhqRFxPMANwxTmHXmhZ2J6EVmZEdbeQO1xYpjUO2vJReo6v
         wr8xQ92tgKXvPsxNZ5Bi4ISGKn5mPZ56C657OevF6WVQU7bRVwTRpfPTsyoaSntQixAH
         bB2QXjWm1vvP06/xZ5KYtozx6Q8c8LM+vNTTqkHvwXhj8oZEOKYZ5N6fqDOlhaabWIW0
         FfDQ==
X-Gm-Message-State: AOAM532SWFqgs2DD1WX+Ad0Mvjigi9F4VCnyntCtUHlBqtXaSyhkeB9k
        FABbYRKrAirnU8BJq20w3z64autpKkeOJp+xBuJK0rhpVqpm
X-Google-Smtp-Source: ABdhPJxh5lnmgI4/Hz0Yc7PjlUITBlstrgP8S6r2VwMjfC8Zx9NPBMLARVUzwMwHE6lqUQbGhWr8KNIVXXrH9Cxw+E+eQTzU6XcD
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caa:b0:2c8:811f:56ba with SMTP id
 x10-20020a056e021caa00b002c8811f56bamr3202440ill.90.1648378756053; Sun, 27
 Mar 2022 03:59:16 -0700 (PDT)
Date:   Sun, 27 Mar 2022 03:59:16 -0700
In-Reply-To: <20220327092631.4171-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035bee505db3116b7@google.com>
Subject: Re: [syzbot] INFO: rcu detected stall in __hrtimer_run_queues
From:   syzbot <syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+de9526ade17c659d8336@syzkaller.appspotmail.com

Tested on:

commit:         f0228146 Merge tag 'trace-v5.18-1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=abe260d3ec31020f
dashboard link: https://syzkaller.appspot.com/bug?extid=de9526ade17c659d8336
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
