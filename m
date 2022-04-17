Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A227C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 13:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiDQNjt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQNjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 09:39:47 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B96475
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:37:11 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id d19-20020a0566022d5300b0065499cd4a73so412935iow.14
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=wA0FmzGAcRTrX+FnNeAVQOC1kod7R+OPRg+GRTVqKh8=;
        b=uUpV6i3ugvMY+QoTvuqfZ80b19rd3TWH6a1Zr4qMgB94aozR94JNQIdFcOUCUo3Svf
         5uvh3rgxNF8FnmadUTKKDRDGdxSde8IR0whSZI94NLlhP0rZaWlmYzwfcob7dTNPVkQM
         6PrK4VeaRUwbaq3qQ4+T8m8iZsrStJxfg8RrZ6DwVYctrRsNdIBur81kZdKm5NOukdeX
         5wlXCMGn3bjhjtt+Fo7+Lu5asaUrBwxn5YiJEWjIsGUEa21MfQkZv+vJbXoiwW2Nlx9H
         FSQnnyviE3J8tyFPGlBgMMzHl13QC7o+iArRaAk4B0A8cwJ5QikkGv8cSh29yR3qOvjd
         eEEQ==
X-Gm-Message-State: AOAM532KcIhxZvSYXWH7iqXb6UsKrc/pQMpN3fBExHUzBVoePhL4J36F
        tSPPSFmzLRCTcFPY+4MwfCCkiqlhsHHMQx/I/inzRLhc+ds+
X-Google-Smtp-Source: ABdhPJzu8m14N1MFCoEmHDFz6ieSul9y+/6ERhmpPdxdOihDx3wppwzmzdQYIcOP91/UdZmPr8NDfGWK1J1CtfWUls48flDEJ4tM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:214b:b0:2cc:1c95:8198 with SMTP id
 d11-20020a056e02214b00b002cc1c958198mr1316033ilv.231.1650202630786; Sun, 17
 Apr 2022 06:37:10 -0700 (PDT)
Date:   Sun, 17 Apr 2022 06:37:10 -0700
In-Reply-To: <6ab618f8-f88b-0771-a739-04cd9cdc1a3c@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d92dd05dcd9bd1c@google.com>
Subject: Re: [syzbot] memory leak in iovec_from_user
From:   syzbot <syzbot+96b43810dfe9c3bb95ed@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+96b43810dfe9c3bb95ed@syzkaller.appspotmail.com

Tested on:

commit:         c0713540 io_uring: fix leaks on IOPOLL and CQE_SKIP
git tree:       git://git.kernel.dk/linux-block io_uring-5.18
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8f1a3425e05af27
dashboard link: https://syzkaller.appspot.com/bug?extid=96b43810dfe9c3bb95ed
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
