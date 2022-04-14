Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 23:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347623AbiDNXdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 19:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbiDNXde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 19:33:34 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAE5A76F3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:31:08 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id d19-20020a0566022bf300b00645eba5c992so3915916ioy.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=cacxPvYX+7YoVTe1rbwEqAdwSgHbgFcryjKRqnj4k6o=;
        b=Ztt8oG97gzB/D4ZSJdjdD3KmUo85hx7e9/axpKRFHz8rMaYoBjN3u5VzDVdMyhjdhF
         Kd8xQSb3X1sdc/fhyupxiSkjtnFr24RDJQChLktbWnWhe6QnlEgO7SMG19yEheef3Xh2
         3sgPEz0kC4Mfhcd/Ee2fhFcwL69yvcX/saGa2B46vHi0bBDV6p4gv4FrzbZtopUCxkBA
         YD23vYKyt3Jm11I2k+vifF4srgP7TSUYOu5mLps7aADJqwY0+KPA3WO3399gCQoR1rUI
         od7vwI97y3YrZn4vrPAu8jYwOLgVi61mpIATL4QKhH9JC9YCRhv3HA+ELwEvUy44+wUf
         Tqmw==
X-Gm-Message-State: AOAM533fPkaPq9rZsuQnIC99m6LE/xn9kqkBqLcinOosg7/sb/mRaD+f
        GAOZR0blu3qkP0Q9cqFbyDk2T3ZvdjHMAnnx0lO9IhNsTLCq
X-Google-Smtp-Source: ABdhPJyIevyU0774Z/8ufRGfExJNo+ANrxot63r6R9B7mINzokzQuOulhQeJNK64zaCiOhEPwslyPLTq+36eX8PN6//sDidtLde9
MIME-Version: 1.0
X-Received: by 2002:a05:6638:16d2:b0:323:7285:474b with SMTP id
 g18-20020a05663816d200b003237285474bmr2431975jat.61.1649979067429; Thu, 14
 Apr 2022 16:31:07 -0700 (PDT)
Date:   Thu, 14 Apr 2022 16:31:07 -0700
In-Reply-To: <9ff91977-a6b5-90f9-3502-58ac641e1307@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003378b905dca5b0e6@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in pvr2_i2c_core_init
From:   syzbot <syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com>
To:     isely@pobox.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, mchehab@kernel.org,
        paskripkin@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1a247e36149ffd709a9b@syzkaller.appspotmail.com

Tested on:

commit:         115acbb5 Merge tag 's390-5.18-3' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb177500e563582f
dashboard link: https://syzkaller.appspot.com/bug?extid=1a247e36149ffd709a9b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=113c24e0f00000

Note: testing is done by a robot and is best-effort only.
