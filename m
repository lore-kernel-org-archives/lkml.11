Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5A2C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Mar 2022 13:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbiCENtG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Mar 2022 08:49:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiCENtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 08:49:04 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414E41991
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 05:48:14 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id r191-20020a6b8fc8000000b0063de0033ee7so7390101iod.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 05:48:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=pk5i+sOPNXGGBb0bRxTeZIscW27o2u6cpIxn3IP3DjI=;
        b=r+ggQruVSF5PPMCdrkNSRQCbXLCGtyI8L4FPL6b1FQMKSGox5J8warqFe1FGTVixWz
         nmQuUOT6l0RU8pv/ou9qpNXILZ5Fo01BfnhdIizuwgXy2slDN7fzir1bJ86A2X4uxOAE
         WSqJ4ryuhr78thwEmScoOdn+3+RaNmhxoFd7vovrpPskAy68GgbY/0Y5/wlUzjafsgd8
         f0otfzQJV1ukL5ulGCVOaopowAutTLSWNI85ibVGOoiLMZBFzjbuQMSE7Dt7ExPCWkE7
         pgXtUVQXFJtbYM9cryBTGLmr6AxA82Ox0mIONHHY9Gub59aCJPtdHLVnR6AOFOYTEbAy
         NjlA==
X-Gm-Message-State: AOAM532BVESUapqaaLHkI3wc+8eT61ubiVgkLJibfJqzmqOYK4lGQo7w
        42iPYnhcvlEw7KDVJFkJhj2JWkMzfzhIQKFIDbiw7xLp4bMx
X-Google-Smtp-Source: ABdhPJwFokXr7PNDlAhr5YTXrfGJwclIsk7jdhrcR6q7AYq7uZuP2/Pw/iovnLwCRfTkfZQLaa9C8ZvbWLcE2WMPYwPkuL1FiVXU
MIME-Version: 1.0
X-Received: by 2002:a5d:9301:0:b0:614:549c:4c40 with SMTP id
 l1-20020a5d9301000000b00614549c4c40mr3047461ion.50.1646488093616; Sat, 05 Mar
 2022 05:48:13 -0800 (PST)
Date:   Sat, 05 Mar 2022 05:48:13 -0800
In-Reply-To: <20220305133546.2971-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f2732b05d978e176@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in smc_fback_error_report
From:   syzbot <syzbot+b425899ed22c6943e00b@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b425899ed22c6943e00b@syzkaller.appspotmail.com

Tested on:

commit:         07ebd38a Merge tag 'riscv-for-linus-5.17-rc7' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=542b2708133cc492
dashboard link: https://syzkaller.appspot.com/bug?extid=b425899ed22c6943e00b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171228ee700000

Note: testing is done by a robot and is best-effort only.
