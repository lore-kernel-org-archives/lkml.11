Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C701C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Apr 2022 02:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbiDXCjL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237658AbiDXCjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 22:39:07 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDA054FA4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:36:07 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id a17-20020a056602209100b006549a9cd480so8687005ioa.15
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 19:36:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=Aczz37y7/vyiY9PHUljZbBJ0hzfDnKG+j8Kygc6QbUw=;
        b=H2piF2ESjjH2BMu8RIdUXj/YqhDOg24Jg/V1fQzdLdBZp6e34AXW8BkGIOQ3GrAHvE
         QrlkTq2C5OwQvnh08Fh/hq2r9SNqMq+4CwZZQU45yOyl2p0CdTrTnNO4y0/9RVNhTs9j
         0LLOvWkF82yrAkKsYXWgN4/iVEYMnc5EGeBliozj8e3zI7srWbLTXuvIrpTq90AlsAP3
         K52CA/CS21eWEqEpf2LleeXHE+EVHra7EsucRWxqMQQ5UU0uXGwF+Zk2MuJ6WbCcWNrn
         oywaa+k9aU/VZZ8FdvURdbKGzvjXQO06B0mhNcr1txIx99ztK6kJe8P+FtH8qET55jM6
         TlRg==
X-Gm-Message-State: AOAM5302q8Fg/a2/fpSQHP7r/sRYodNCNq7fxGxDobLxR1y6DnrzSgvB
        Dms/sWaFLdXDTY3VX1rWM6NchyguMwsExSIfBsou8pm4XPJ/
X-Google-Smtp-Source: ABdhPJy/Cm2yA+UEM2HUtGrCAEMJqeoPXv0DgZYuJzh5ODYfbdITWbci2LFb1tJrF75Dm7mNGHX7ku8RL0IN7OdH/nUoX52XZ6tt
MIME-Version: 1.0
X-Received: by 2002:a6b:ed06:0:b0:649:d35f:852c with SMTP id
 n6-20020a6bed06000000b00649d35f852cmr4916494iog.186.1650767767182; Sat, 23
 Apr 2022 19:36:07 -0700 (PDT)
Date:   Sat, 23 Apr 2022 19:36:07 -0700
In-Reply-To: <20220424010128.3062-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ea32305dd5d529a@google.com>
Subject: Re: [syzbot] possible deadlock in _snd_pcm_stream_lock_irqsave (3)
From:   syzbot <syzbot+58740f570d9b0dacf2a3@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+58740f570d9b0dacf2a3@syzkaller.appspotmail.com

Tested on:

commit:         13bc32ba Merge tag 'drm-fixes-2022-04-23' of git://ano..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=71bf5c8488a4e33a
dashboard link: https://syzkaller.appspot.com/bug?extid=58740f570d9b0dacf2a3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17585ddcf00000

Note: testing is done by a robot and is best-effort only.
