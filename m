Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3656BC00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 10:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiHAK3X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 06:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiHAK3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:29:14 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9740219C1F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 03:29:12 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id a17-20020a056e0208b100b002dc52b51d98so6439214ilt.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 03:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=Phl643nnc/FDyRycl+fWVvHz7FFpnTlNljAnj8E2g68=;
        b=o41BmLTruCNPiEj8p8atk/FXX1rBlYnXMAshv10IU80XxEU5EvB/QM9trJJ8eEv5fZ
         DVVc8BcDfBWaJO2Mrqx+V0enbWLcaw4zu7oyViAT1lY6RG5ENazjWzApQdDL5PssCnUE
         /cP0Nwr+yqHs5nzQvE3jBXDBYAuKtbFGJ9kpPuWB5VK/Nnu7DdQoUEfKvA5aSciBZILl
         0rOb83q8jZAV5+rLvZ0jECyxTsxZX3/fGWSWF/2GVbmSOza2xECjrEfEfq6+QUTBA0cN
         trq/7/jR3p0Y9vgQX8fQzWzKdqOrlkLfLISM5DQM3/DAUEDBxOf7u4+d9xVjebYVzFG1
         dI2Q==
X-Gm-Message-State: AJIora/+wuEnnbTzBzgrOZTzKj2Y17muKaAuG8oo2PNUAZDs13J19/Jh
        avusF7vUQQqZvfrUo4l0jtPiUESjczNZBUcl4FT1dpo/snJ6
X-Google-Smtp-Source: AGRyM1vl4xHfpqmTU76tijGfMYhdfQMe8gxHA3I4cWFMxPSp1vMy1HcQa7pgVpqLfHM6pm3hIU7Vk1sbXkri7r0ASrNwG4EsLjK1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ca:b0:2dc:90fa:af35 with SMTP id
 10-20020a056e0220ca00b002dc90faaf35mr5844322ilq.302.1659349751878; Mon, 01
 Aug 2022 03:29:11 -0700 (PDT)
Date:   Mon, 01 Aug 2022 03:29:11 -0700
In-Reply-To: <CAJfpeguM-DdeAL3cSJB3csD6VcaqQRiSmHvwPicQpKL5Wu6QLQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000084d95d05e52b7822@google.com>
Subject: Re: [syzbot] memory leak in cap_inode_getsecurity
From:   syzbot <syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        marka@mediation.com, miklos@szeredi.hu, phind.uet@gmail.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+942d5390db2d9624ced8@syzkaller.appspotmail.com

Tested on:

commit:         3d7cb6b0 Linux 5.19
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10aa0c2e080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5466231eb53fa40e
dashboard link: https://syzkaller.appspot.com/bug?extid=942d5390db2d9624ced8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e003a6080000

Note: testing is done by a robot and is best-effort only.
