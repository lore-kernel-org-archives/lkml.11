Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B7AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 05:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiFHFWl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 01:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbiFHFU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 01:20:57 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B0F27559C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:51:08 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id j12-20020a5d93cc000000b006692aee869fso5473466ioo.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 19:51:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9RKAoJeiSZe3EQhiQtHMGEfkjZC8rMlcX/wtjfSGmZo=;
        b=cMv9fuTrrrEmmMPzV2E/4mzwQu6POGbwTSHavKXVfPGxDmBcOGYXy5CvjSrh7liA0t
         nlbkMIbABq5xrYlGZVrqiZSgjhVQ2/S7t5PNvKnTMBz5ypnyskBz3bwwisjMrtXJwhDT
         peXFdC3x+X1KhYsq3PXsEaTw7K05HTYT+fTpkHP692KBO1CFTsKM02XH1+8TiNaAOtIQ
         ZRYEnWlLsr2E1PM16k+w2SXyIw+oUgMPkU8UHzU11PYmZt7RDBd2fHOU1E2YcG37Z0nM
         XIw4ZSG1qmqci+yFigBfGECDqkG0ZSkgJGAghiGIr61bF5Jm6rL+Dap+BYgjRvIrzxI3
         mCVA==
X-Gm-Message-State: AOAM531WUobzM9e+BI2vgcLCSlw4MglJSYfgDsnAXSaRSBoich5kKpTe
        F8AbwwQrsnabcBaMaEcglMGxRyMUJorzPvF5NFAlbbV7AuT0
X-Google-Smtp-Source: ABdhPJwHWDSpCC0WchloMDJtjp2ekL7TNVVprJjUbPcnJTsuVKCcOficGv4YWiReILvGYDzovpuwpzGZF4W6lsmLboE1EZkSP2bI
MIME-Version: 1.0
X-Received: by 2002:a02:bb85:0:b0:331:7a13:201b with SMTP id
 g5-20020a02bb85000000b003317a13201bmr13410664jan.41.1654656667728; Tue, 07
 Jun 2022 19:51:07 -0700 (PDT)
Date:   Tue, 07 Jun 2022 19:51:07 -0700
In-Reply-To: <CACGkMEvtV+hVdpgpkYvAmkRteYDN+2dDacrfXsYDv0ZzjJU+ag@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7c46e05e0e6c6a1@google.com>
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

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file drivers/char/hw_random/virtio-rng.c
patch: **** unexpected end of file in patch



Tested on:

commit:         bd8bb9ae vdpa: ifcvf: set pci driver data in probe
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git linux-next
dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165a0febf00000

