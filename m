Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C401C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 15:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238613AbiE3PsQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 11:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242469AbiE3PrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:47:25 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C8D986E9
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:03:15 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id 129-20020a6b0187000000b00660cf61c6e8so5614446iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:03:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=qCWWCF3iGE9snJDuEQUknhEXfsnFNalg6uSnSdiX364=;
        b=x4suj7k0kUH+uqD4WnEqdc+jCp4PQqX/TmCKNqPY0KhJj9pO2LncO/k9XqVhRKRMGR
         I5j9C2DkxqD1M/0gbxSaG7VHts3FfapOgnIq51Sfa8PM7vBkB9x+pjYRjeigfptpMnup
         CClzqBKQ6DApIanNgq7aQifzfrjWaReASWWBCkuCHxohWEPB9SY7QR96a5HvGof3bptV
         s2fzdbXOvFF/KkBd5QtZQGkUGsJhhMgz+jUy1L2ET0cww5u52QnbCjy7wirBNw1wL/lc
         smK+5pjGlVKhDb7zyrpxUTVBspXi61oMw6+ftsOMdS3xrfiQOD0kQvYtCUU7/ebnDxl5
         m1lg==
X-Gm-Message-State: AOAM530eiqO8NAi/9Y9jkGDuIXbQWnU25216d4YoA5QDT1wqIrhUXugt
        ne9Eogeg17ibGFqUN9/autmI3NYmN73DXILTmmafqttDLD0n
X-Google-Smtp-Source: ABdhPJyyEwkiP80P1wwWzdsszTmNurl+BMw8u1hPt2c62Onlx/qapo18JyQ5+rTw9V+b5j1QRu4888BbvSODPNYjtIRbBltWEtM/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15ca:b0:2d1:9146:c79a with SMTP id
 q10-20020a056e0215ca00b002d19146c79amr23075308ilu.97.1653922994637; Mon, 30
 May 2022 08:03:14 -0700 (PDT)
Date:   Mon, 30 May 2022 08:03:14 -0700
In-Reply-To: <20220530144542.4382-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094d2a605e03bf455@google.com>
Subject: Re: [syzbot] WARNING in dma_map_sgtable (2)
From:   syzbot <syzbot+3ba551855046ba3b3806@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3ba551855046ba3b3806@syzkaller.appspotmail.com

Tested on:

commit:         7e062cda Merge tag 'net-next-5.19' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=e9d71d3c07c36588
dashboard link: https://syzkaller.appspot.com/bug?extid=3ba551855046ba3b3806
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=137777cbf00000

Note: testing is done by a robot and is best-effort only.
