Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5472BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 10:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241194AbiFTK7Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241116AbiFTK7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:59:09 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C721177
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:59:09 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id g8-20020a92cda8000000b002d15f63967eso7233691ild.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 03:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gmiHrG7AcXh3/tITNWynMJAiaeeqqBA+HCgt9kHTQNA=;
        b=WP8U13yY1fENEkOm5ezw7VvJF+IwwbrXVJBviAp/8Ktvu5pxgYW9hh+aNWBHDKr4Al
         zM56yUgzNVBxhDUR5bFaJq54Y1PaqYURUK9Jk6Es2c0+1NNK7hOkkfWBYQGppoTk0Ds5
         XDH0xS1z7VZljALujGvgybRMOlxj2dxGj5LvN5RT5guSW7v9xAlCcM9xKUlAdM2crX1i
         2NkHOWWuMhYifvgd3j6gCMNvlunNGJAugUAl50MIoL7C8uOTVp05TUwEf+Q3PV9IR5ze
         tOAN6+OJosaqTbAefkOEqw8Uyfk/gdKL9QBqzLb1URqEgu/zFtyPx5hCIHR1Glh3ts+J
         801A==
X-Gm-Message-State: AJIora98i4v8apDpA6ynV+h6UhSVyjQgUlE8mU9JFjAvATpMyz7/WV3T
        YlD7XFNpEEQAFrOOX4t6cmN1E+fyjAthhCfe7/BxojgVdY58
X-Google-Smtp-Source: AGRyM1s/pD/h5v27g7oixRSZYs3veVbJs+UfzWlPALCHrvnDDSGD3dZcHEtGjFA2km6jIg2qVQdJBv6CxiVqdBSfNMoNtcfi7iCX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6b:b0:2d3:ae9f:112f with SMTP id
 w11-20020a056e021a6b00b002d3ae9f112fmr13253844ilv.187.1655722748573; Mon, 20
 Jun 2022 03:59:08 -0700 (PDT)
Date:   Mon, 20 Jun 2022 03:59:08 -0700
In-Reply-To: <20220620103954.441-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004680c905e1defece@google.com>
Subject: Re: [syzbot] kernel BUG in binder_alloc_deferred_release
From:   syzbot <syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+58b51ac2b04e388ab7b0@syzkaller.appspotmail.com

Tested on:

commit:         60122738 Add linux-next specific files for 20220615
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1110d24bf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b4154677977b1776
dashboard link: https://syzkaller.appspot.com/bug?extid=58b51ac2b04e388ab7b0
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e9aed8080000

Note: testing is done by a robot and is best-effort only.
