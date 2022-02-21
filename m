Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E84C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 14:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378071AbiBUOhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 09:37:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356282AbiBUOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:37:30 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458AD1EEF9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:37:07 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id n5-20020a5e8c05000000b00640d0a712d3so3465392ioj.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 06:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=UXuZuAFf06AjNDv96AIjaTSOnvpwB56946KWBbv5zI8=;
        b=FO/IhiZOnLRJP6zdUEbcapOi26HjW2M7LrYWUrzKAbHQAoPGM+Wg3FB4erxWrSrDSM
         7uxR1InFa5EB1gI0nNSoEIQjTPm05QsL0yv2kCVb/hIOl6OG8v5pYlJP6ZBsguWLR6aI
         YS53w85jha5/asZj7yCuzkLdP7rPJC2feoBBzifSzHdPsAqQJJ5qEn+BfpD5fSKQFvmw
         tC7neX/QpXOKAsFMr1oXheie1JY8XQssfsQsxzvychwzYAKSS7Vh24TAZ+dHzourVlsg
         /xd/ned0is6EgJcR6HcHwQcXN7uLupNXwNFPRmTp329U8ccKmw60X/+taIi8HPmtyajG
         MxTw==
X-Gm-Message-State: AOAM5335CogynE4HbFXsFSigv9Rbd2JIykYArAOjEdLKsi28gQz+RIVg
        C9WwlxoP+HyQ9/3oUDWE7MCN/JZJPHDa9QDm6DHTrOrbcIh8
X-Google-Smtp-Source: ABdhPJxI9n7981umWgxAkYi8nKTFYbbnjwZVOUXk22WmatR+LG0H0VtkRrDs5wSXcX4+ImWNsFu8NNEDe6+uhDX1c+HlQGRQyJSt
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d86:b0:2bd:ef9f:cfa6 with SMTP id
 h6-20020a056e021d8600b002bdef9fcfa6mr16231349ila.314.1645454226686; Mon, 21
 Feb 2022 06:37:06 -0800 (PST)
Date:   Mon, 21 Feb 2022 06:37:06 -0800
In-Reply-To: <CAGxU2F4nGWxG0wymrDZzd8Hwhm2=8syuEB3fLMd+t7bbN7qWrQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad0c4005d8882aa8@google.com>
Subject: Re: [syzbot] INFO: task hung in vhost_work_dev_flush
From:   syzbot <syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com>
To:     jasowang@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        netdev@vger.kernel.org, sgarzare@redhat.com,
        syzkaller-bugs@googlegroups.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0abd373e2e50d704db87@syzkaller.appspotmail.com

Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=0abd373e2e50d704db87
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1502488e700000

Note: testing is done by a robot and is best-effort only.
