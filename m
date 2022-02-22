Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF0BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 03:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbiBVD2k (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 22:28:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbiBVD2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 22:28:36 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D5622B22
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:28:10 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id y9-20020a927d09000000b002c24b428ff4so2239039ilc.18
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:28:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=jn1v1wrtUy0we1aF2ni8zoooQ45E+ro5had3wgyBV54=;
        b=5c7o4o/JibOqKmEUv4YQCcgXKyvbp3eiKFpQ5vkJOA1V6PLrvdqwaE1s2Y2eOLPt9E
         wNl6xt5A9LQwA9SnU6pi85Vov8SsKudl6gxQM0sGogXlyI/fMRi4z35xQQ7FdPAqWanP
         22egYNwfSDZQjTbKfPtblmSfDOT7ZG1nGzESi0+KryrqhODTNSVwTYwxjerhvObgmkd4
         u8mGmOPFijbpTSg+TcL6akJs4JJ/1s9n8isUAAxCe4K5egyzdCTimKZEAQDIlBuyQ01k
         5Nq7fFDuvn7wSpzEjKtguhIvgF8kLNluK2Q8RbpJT3oSyhlgS4nErcXTZg6bo5CNcN4n
         22Ew==
X-Gm-Message-State: AOAM530RhVPoIaJSl2cQVVg18xUj7yFIBvfPDPLFO+JT8yU12ORgf/gJ
        kA0yKJqwt3yFajWoTE1bSI5YM2Z9I/e1I8yI3hHHEuwN/ToG
X-Google-Smtp-Source: ABdhPJwvcdGWpoK/XmWmrt/RJmM7zJMzG1YEJtPZ2U2O45PYEbMt2BhVRCfFBhCzCJlCLVEnBbK1cFfhGL/cB+uriO9DuGX7UU0r
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:2be:1b0:bd05 with SMTP id
 s7-20020a056e021a0700b002be01b0bd05mr19161773ild.211.1645500489485; Mon, 21
 Feb 2022 19:28:09 -0800 (PST)
Date:   Mon, 21 Feb 2022 19:28:09 -0800
In-Reply-To: <000000000000264b2a05d44bca80@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002752dc05d892f094@google.com>
Subject: Re: [syzbot] WARNING in cpuset_write_resmask
From:   syzbot <syzbot+568dc81cd20b72d4a49f@syzkaller.appspotmail.com>
To:     cgroups@vger.kernel.org, changbin.du@intel.com,
        christian.brauner@ubuntu.com, davem@davemloft.net,
        edumazet@google.com, hannes@cmpxchg.org, hkallweit1@gmail.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tj@kernel.org,
        yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit e4b8954074f6d0db01c8c97d338a67f9389c042f
Author: Eric Dumazet <edumazet@google.com>
Date:   Tue Dec 7 01:30:37 2021 +0000

    netlink: add net device refcount tracker to struct ethnl_req_info

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15c42532700000
start commit:   e5313968c41b Merge branch 'Split bpf_sk_lookup remote_port..
git tree:       bpf-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17c42532700000
console output: https://syzkaller.appspot.com/x/log.txt?x=13c42532700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c40b67275bfe2a58
dashboard link: https://syzkaller.appspot.com/bug?extid=568dc81cd20b72d4a49f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bb97ce700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12062c8e700000

Reported-by: syzbot+568dc81cd20b72d4a49f@syzkaller.appspotmail.com
Fixes: e4b8954074f6 ("netlink: add net device refcount tracker to struct ethnl_req_info")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
