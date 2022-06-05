Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEADC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jun 2022 14:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbiFEOfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jun 2022 10:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241224AbiFEOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 10:35:15 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC97F1F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 07:35:14 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id b12-20020a6b7c4c000000b0066570f0b704so5089775ioq.7
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 07:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=BfcO8yUDCnaPPfJd3VskRcTkPfhefBFyKUaIOrme6t0=;
        b=bqDG5c+GfHDWz0bWZpGG0r+l+qg4833nMVeL9XE40YauG+zn0lmcP7zuC4QKouVBqV
         9LgKo8khqiBEtEtDI9x83+01Og6DPoDGNcvqJvz4awauv7NmEsj+tGqmoEd6ya/gUKer
         CXBKCAlL0DA4P+4oyFDNs91pL3tQ9bvrAUOvCmPh2UlkQN2Pslq2qwYtBJxFlmBcABs0
         cWVMaqlgo8Sj/wQe839XEZsxykDNPGpbRzAzzSn46OjAYXMysgA8x2sb5joKppunPGYw
         EnfO8OrEuzp2TuMjsaqcXiX5vMzVWJlNvoN9NfLS94rzA+l5TW3468PApTLvg6/X4pHr
         500Q==
X-Gm-Message-State: AOAM530Go1424ZwnpUsnk0iz0vctHlFf0yRJRaCMmrN7VJh3CXlEtjmu
        Z2F+fD4tG5XBfgFQJHV6AtpswYSR9bppQzvcllcGcRfPRAwa
X-Google-Smtp-Source: ABdhPJyyDzgycv6U6D9J6wWOdrX0qamIuk+2FGdOGF1Dieh3b/YM8792LHJ5yWnwAGUwxEf4IfPUcj4lJYsrFwE3IRw4z7yUjIeR
MIME-Version: 1.0
X-Received: by 2002:a02:8543:0:b0:331:6142:d305 with SMTP id
 g61-20020a028543000000b003316142d305mr11442440jai.318.1654439713549; Sun, 05
 Jun 2022 07:35:13 -0700 (PDT)
Date:   Sun, 05 Jun 2022 07:35:13 -0700
In-Reply-To: <20220605113753.5943-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006db37405e0b443c8@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in filp_close
From:   syzbot <syzbot+47dd250f527cb7bebf24@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+47dd250f527cb7bebf24@syzkaller.appspotmail.com

Tested on:

commit:         952923dd Merge tag 'pull-18-rc1-work.namei' of git://g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=3096247591885bfa
dashboard link: https://syzkaller.appspot.com/bug?extid=47dd250f527cb7bebf24
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16bae7f5f00000

Note: testing is done by a robot and is best-effort only.
