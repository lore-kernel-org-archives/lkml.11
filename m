Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0A2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 07:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237693AbiFGHa2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 03:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237672AbiFGHaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 03:30:19 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF38553B5B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 00:30:17 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id u8-20020a056e021a4800b002d3a5419d1bso13262445ilv.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 00:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=DOtOjJzKQIf+e7c9BZc5SKCyPkF/h42VSWyH6TDcFY0=;
        b=gAfdXD1l1+mbxDYFxnHCpadPzjWOnprEFFgQT09EiFoF7NrRzs8dK1a1i/Xtt4mHsF
         J3mna6i9As/ebv03dlv2fA7Ov80wx2+ajoB6g3dwa0JVy7leQxhjvDpNd8DneClasM/y
         WxCXJW1YiEEDgZ8TdacyrjI7YBLAAvW6SVRR50YzxKOtN9bbhAx5ttkogZWx0VRg9ccl
         kKiOLqdchrlzYAVsS98R7Rcsv8WjLxaX2ANmGnQKVNg05TXB0Kmg86U8E8tWOJYUnc5+
         eap6pKn8AojUycIuR/VQkNpOY9rNBgCZSdoRoY4I+vWARClREc0isLW91x2a0zgbX6pg
         AI/g==
X-Gm-Message-State: AOAM533aUATycLkWn1EUubVxsjH12GTeNNaocMdVSmwk9wzN4NQPsM1E
        Yn/JiJwqjz3sOVWoEw82WfHDVFAtpypywoHMVxFXU0+FPTx0
X-Google-Smtp-Source: ABdhPJzo6FrSSHm2sTN36Tfz0L2n39C3ItG8XK9VzZq7PigjQFYZjm3jG8lO70nk3/HNEig9mUPqfWduDsbj3Pa6xR2GQ6oYKwDR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:2d3:f72e:eaf1 with SMTP id
 s14-20020a056e021a0e00b002d3f72eeaf1mr13523737ild.260.1654587017150; Tue, 07
 Jun 2022 00:30:17 -0700 (PDT)
Date:   Tue, 07 Jun 2022 00:30:17 -0700
In-Reply-To: <000000000000fc128605e08585c6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068486805e0d68f94@google.com>
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
From:   syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>
To:     herbert@gondor.apana.org.au, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@dominikbrodowski.net, mpm@selenic.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, xuanzhuo@linux.alibaba.com,
        yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit 8b4ec69d7e098a7ddf832e1e7840de53ed474c77
Author: Jason Wang <jasowang@redhat.com>
Date:   Fri May 27 06:01:19 2022 +0000

    virtio: harden vring IRQ

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1175c3c7f00000
start commit:   f2906aa86338 Linux 5.19-rc1
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1375c3c7f00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1575c3c7f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd131cc02ee620e
dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104f4d4ff00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d6782df00000

Reported-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
