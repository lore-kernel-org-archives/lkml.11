Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9411BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238672AbiBJJ3U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238558AbiBJJ3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:04 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97EDA1089
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:29:06 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id o8-20020a056e0214c800b002bc2f9cffffso3571431ilk.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 01:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=lbZClnawL85i6y/f1XZKEH3U2806L2hF7lFn0+Ro7Ew=;
        b=SmwGTsRJmb9NNN5twJxnWmKFX3XJ0OTZ7M5dcMG2qi6Px7dEvfnDpE89abLKQXaZqt
         li3JtXG0cW3ndTRrCxE1q+RACZ99wLv3Bj0EUABezDEj9vkP2OwwRcmKuutVHWALDXQx
         dFDQYpT6ymzN6XILXxwAACmLHkc+QT//D3/lbOkrBwDoPxTjpu4/bFE6X9HP7/MLIl/b
         2+0bmG39nceXi42VmnPtdS2PTOB8+9abP1cMVB2w6sdmgIfIZHMspdMQJk6QD5nKv00h
         GNNEIj1gJUbhAbQz8V2wx45mZR/dG4YnbKXswzZER5t6/lquAeZe7R0D1ZvAkF/13wWe
         knHQ==
X-Gm-Message-State: AOAM5306hjtCQTqgEYcA2B2SbgU6TsN/D0R+AYH7f09POsQ6VgL0VfZp
        5kHCFxm2Kjkd2/ODOQryIXKPgzERklmvtN+eod9b++eIwsAe
X-Google-Smtp-Source: ABdhPJx22vdsd9ZwS5xcJlnZq2r7nAA5BqmnE9xXQOkXPLW5oeCWMIkcNmqMItDy/Lg+pycfhLQYxawcp7pQ1kDwS81fqOWh7+0x
MIME-Version: 1.0
X-Received: by 2002:a02:aa0a:: with SMTP id r10mr3655553jam.246.1644485345948;
 Thu, 10 Feb 2022 01:29:05 -0800 (PST)
Date:   Thu, 10 Feb 2022 01:29:05 -0800
In-Reply-To: <000000000000a16ad7059cbcbe43@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e238bf05d7a69450@google.com>
Subject: Re: [syzbot] WARNING in bpf_warn_invalid_xdp_action
From:   syzbot <syzbot+8ce4113dadc4789fac74@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, corbet@lwn.net, daniel@iogearbox.net,
        davem@davemloft.net, dsahern@gmail.com, dvyukov@google.com,
        eric.dumazet@gmail.com, hawk@kernel.org, john.fastabend@gmail.com,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, toke@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 2cbad989033bff0256675c38f96f5faab852af4b
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Tue Nov 30 10:08:06 2021 +0000

    bpf: Do not WARN in bpf_warn_invalid_xdp_action()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10d50baa700000
start commit:   b3c8e0de473e Merge branch '40GbE' of git://git.kernel.org/..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a86c22260afac2f
dashboard link: https://syzkaller.appspot.com/bug?extid=8ce4113dadc4789fac74
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=113c8a3bb00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16eb4307b00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Do not WARN in bpf_warn_invalid_xdp_action()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
