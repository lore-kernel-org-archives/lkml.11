Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3C5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 04:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiBVEHz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 23:07:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiBVEHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 23:07:54 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5054B6AA78
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 20:07:21 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id a4-20020a5ec304000000b00640b8ecfcceso5190141iok.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 20:07:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=vOx3Im73SFmnbz+1mrp8SMMKdHhayl6mutBW62cmCZA=;
        b=GPRUwFRNtbDxZGGycO3QYCiq2iT8/VStv+Ym99rbtviqzR6ipbzCvses7h4RdSjYjc
         pgs7Gz8Uq4obAi/1DvOKA9bXPrOK+XRev94YLHlsAjtBNWRqTdMza79nyijTtW/0C2oR
         S99v2+jvjGtPefONmEghEtN7nmMkT8T4TnR0RjM0l503vxvtG7AttkPsOYMfI6cHf+jP
         iEUxKHXt+DcvFjUphUYNv3IWBDez4AQ1Gb3s+fuCkNsTqJWLPQPG1nC9Xc3QhokGcBY2
         xCYRMJd5sa7WVbS4PFpZJ4s88SiZKzNYPqILg1h3vnZS/b2jJgGxizjDnqXGdi2UZOpz
         YKDg==
X-Gm-Message-State: AOAM532nqiafjNhLHphjIjrMW27nXSeJxgwv4VrtxFDqe9rgDieqVqMl
        0ddItLX0sj9nIE0zc2a/aHB7NIzv5UgKmv4pRI9FQ5s5i79P
X-Google-Smtp-Source: ABdhPJxlF2Fcrhc0f8fUORlCLcps0rHWVvMxMdQ3PVyedmOqj0xUuN0OGJwdw8BIwPr5SecJ0OgFJb1BHwoTNPjrn5sXAPc6/ANL
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c26:b0:2be:a5ac:2985 with SMTP id
 m6-20020a056e021c2600b002bea5ac2985mr18147813ilh.125.1645502826221; Mon, 21
 Feb 2022 20:07:06 -0800 (PST)
Date:   Mon, 21 Feb 2022 20:07:06 -0800
In-Reply-To: <20220222031128.1850-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f14f805d8937b26@google.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
From:   syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>
To:     hdanton@sina.com, jasowang@redhat.com,
        linux-kernel@vger.kernel.org, mst@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com

Tested on:

commit:         f71077a4 Merge tag 'mmc-v5.17-rc1-2' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78b064590b9f912
dashboard link: https://syzkaller.appspot.com/bug?extid=3140b17cb44a7b174008
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c604ca700000

Note: testing is done by a robot and is best-effort only.
