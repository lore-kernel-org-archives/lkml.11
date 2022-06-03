Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8927C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 10:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbiFCKCQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 06:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242870AbiFCKCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:02:10 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971E05F8B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:02:08 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id x5-20020a923005000000b002d1a91c4d13so5430423ile.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=CETyWVHu7ACjpSUlEO+0eiI0hfJXIrRX6DzyX/3YTu4=;
        b=Oe4sYwo2qPtwn1V2CqVNj5cilLfL4RIAjfRhhdWEL0jJ3wTFMpnSYf8sUNGmAohv3o
         yQ6FPARXi2sCJSxgbYjA5w/adWNBv/vtLL8KOTdFVza4bwhYhqzZuT1da5ZAKq/e1rQw
         Ggop+Xs726WxwxNbzdzm3X9GUdrwTmMnxdk+eaN51F/mHzV2zOg5aDPpp0dDthUaYTnd
         Z3Fa7hhxp3RUIxHMkaQejArOo7VsBNhCA33lPcvyTpH3gFvdKiA4sJedbvtHH8427GHA
         6V6+VMnLGc5gx5rUEs15420+5eZUa0FRUDDuFBMNCS1GU+Mm1RoDl95OiyC107C5VgBW
         Z9Wg==
X-Gm-Message-State: AOAM530ujZJcSkiaGBeQR5sMsrTZP4eS22+jUC74ujuNPHdKscO77984
        2ca3mQRJ8XpUDzFUPWQZX1Pw29qUwk8KV7tPxlZgK0dhrwoO
X-Google-Smtp-Source: ABdhPJzbSJVbRANJ4lX5DaQExVRaf/aESQ7vPiixhdBT1+wC8VMM8xNu/cX8tmXqyxgNCDxCmiEyLOkFSxd21nQbl7YGufSdIA/D
MIME-Version: 1.0
X-Received: by 2002:a05:6638:d01:b0:330:cdea:7084 with SMTP id
 q1-20020a0566380d0100b00330cdea7084mr5405003jaj.117.1654250527568; Fri, 03
 Jun 2022 03:02:07 -0700 (PDT)
Date:   Fri, 03 Jun 2022 03:02:07 -0700
In-Reply-To: <000000000000bb7f1c05da29b601@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010b7d305e08837c8@google.com>
Subject: Re: [syzbot] general protection fault in __device_attach
From:   syzbot <syzbot+dd3c97de244683533381@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        hdanton@sina.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        rafael@kernel.org, rjw@rjwysocki.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit a9c4cf299f5f79d5016c8a9646fa1fc49381a8c1
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Fri Jun 18 13:41:27 2021 +0000

    ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1040b80df00000
start commit:   d1dc87763f40 assoc_array: Fix BUG_ON during garbage collect
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1240b80df00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1440b80df00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c51cd24814bb5665
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3c97de244683533381
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15613e2bf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c90adbf00000

Reported-by: syzbot+dd3c97de244683533381@syzkaller.appspotmail.com
Fixes: a9c4cf299f5f ("ACPI: sysfs: Use __ATTR_RO() and __ATTR_RW() macros")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
