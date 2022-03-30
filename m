Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE89C4332F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 12:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346707AbiC3MSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344530AbiC3L4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 07:56:16 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A922B250
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:54:07 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id g11-20020a056602072b00b00645cc0735d7so14285028iox.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=7IAPIDGtmGB489oXMPL27ZU1v8uRIqGprJ9/altofEg=;
        b=noOxfZt0+kF9+VuoRNWclse8/lRwXMzwrK4eG4r6lYD4zOzPvdKGAadLQBAOLtVU0l
         HOdbeLhp4aIqRSneoO8pXpRFdRqpwBHu72/wnWb8WiVA3mV7Q9/p9IBbBloTeGYvn61p
         kI7P9KHujH8DAxlLFT0xLK8p0F7E2ksVxwHmUBn3CSCG1SBOJN34wQfZop36mFqBlzS+
         PQ4QENDKCRDs8kBdVi+aySlukN/wLejVd4dLETOYs2ERkN1Ucoec3gdNPFZDMr9V8eFD
         tHNcRw1HD5UWYH4tjNPAgO8V9OOyGxUi731cUNCTEe54/twzvJXM4DBj8/DeWg5fmtH+
         4iiQ==
X-Gm-Message-State: AOAM531TPPn03rUNXFBf+lqcTUWTT9xezuKMM+Q61ZCSqbw4mnefqwrG
        gxpgGC5K50rn2M18ui8D4WN5v7Fj1QQ7maJiWGk8INPGabbW
X-Google-Smtp-Source: ABdhPJyzMtzg+RsVrfzALmOTVu+lxxuCEr7IxF5qsQRRcQz7yCrIwDU3BNAHfsCOWOmB9lRBRPKK6cG/dVi53OV154TR3Cp5IwNV
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3395:b0:323:8a00:7151 with SMTP id
 h21-20020a056638339500b003238a007151mr3829675jav.93.1648641246340; Wed, 30
 Mar 2022 04:54:06 -0700 (PDT)
Date:   Wed, 30 Mar 2022 04:54:06 -0700
In-Reply-To: <20220330102644.4510-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d9aea605db6e33b3@google.com>
Subject: Re: [syzbot] INFO: task hung in rfcomm_process_sessions (2)
From:   syzbot <syzbot+d761775dff24be3ad4be@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d761775dff24be3ad4be@syzkaller.appspotmail.com

Tested on:

commit:         cffb2b72 Merge tag 'kgdb-5.18-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
kernel config:  https://syzkaller.appspot.com/x/.config?x=69c8957f4ac2dea6
dashboard link: https://syzkaller.appspot.com/bug?extid=d761775dff24be3ad4be
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121c55b9700000

Note: testing is done by a robot and is best-effort only.
