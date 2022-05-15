Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B30C433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 May 2022 07:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiEOH3U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 May 2022 03:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiEOH3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 03:29:14 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FFD13CC1
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:29:13 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id l8-20020a056e021aa800b002cf778c63caso6487608ilv.10
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 00:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=odEcK5lFa5mJCte0c3eNEJ2xjgp3/O7yqETrrH7RhUc=;
        b=YO95UwsfKHLKN4ojHkdXDiz5mFdrv0yGgblTlF4Vj4fejESJEHddozLU+vNQCEQDrC
         80mtf7UHpfDKcU6xikQf6lD8yV7XWZ3MetucvCExta2Bhbg+5UJEL1HHP3d/XJxkgUE4
         JT6I2RLbhh2jK0h0SF7HMi0k9Mzo9vBGnTXgx2VTjzTQjBGf5tijSVzzvEIE0EvswwDZ
         Iyk+EFoym5XFM//4moLMJ7ZsO8FR85QxOaz2FQh7H3gSe7nU9B8MA+ZDxhJnTyFxOOB1
         8QLWFHJQt092OYqBXsokmJFHR6t/IY0pFpbrIy7H06VcYyUnYxRvYqY90ZVzsh8DAXkc
         Dg2g==
X-Gm-Message-State: AOAM530ZuAJcGfdllXSrTfbFxct7gfy7Qgc8/7YpkgA3nzUPkIwBxDXX
        HiZjzFPbvDAZ9j1hVLWd8v7tEoX+Fgcf1bIM3DEhdvHANhkn
X-Google-Smtp-Source: ABdhPJyALqjL6v16Y4IMeCzezgXjUGrvf72sn8KmJC1WoY8/otjLzuQBAV4ZxIDoBY4ihnx6C9LS0ap8LZehypT6P9MCP1ab7b3X
MIME-Version: 1.0
X-Received: by 2002:a05:6602:15d0:b0:65a:a94e:8814 with SMTP id
 f16-20020a05660215d000b0065aa94e8814mr5717505iow.11.1652599752703; Sun, 15
 May 2022 00:29:12 -0700 (PDT)
Date:   Sun, 15 May 2022 00:29:12 -0700
In-Reply-To: <20220515070049.1718-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003744d205df07dd52@google.com>
Subject: Re: [syzbot] WARNING: refcount bug in l2cap_chan_hold
From:   syzbot <syzbot+fd86a41b17a416a37a75@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+fd86a41b17a416a37a75@syzkaller.appspotmail.com

Tested on:

commit:         9be9ed26 Merge tag 'platform-drivers-x86-v5.18-4' of g..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe599903e2c6b6
dashboard link: https://syzkaller.appspot.com/bug?extid=fd86a41b17a416a37a75
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12d8a5bef00000

Note: testing is done by a robot and is best-effort only.
