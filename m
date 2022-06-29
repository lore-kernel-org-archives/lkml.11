Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8C7C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 09:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiF2JSY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiF2JSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:18:22 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F2030F4E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:18:17 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id j17-20020a056e02219100b002d955e89a54so8805447ila.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 02:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=IxcnEapRZn4Sxb13Fl/NcLDt9ABSHV+8rmmLmGVIe5BwpHHi0fwqk54UlX8/HaJdUW
         K4/TI4X+TreAuHwa1iOpKPd1rtZTBAU2Tf+BVNEmT9E+fuNdbshwvURpUtNBGTGQOp+o
         jkKeJ1gTsyzIe25Y0t2c4mGnEiAKeu3Iij5Uj+hApQ3ewgg0pyJg24TbA21xOrE0XHVL
         1QDo30lZBCv/mRmMpyDa980AevAk5gJNs0/JrCJ4SIAF3FI8kpqEfIcLbJR/Or6a4Jko
         slCwjHXdwGCqb+iaLP3cEQ90XNkGwWexE1PNIPvrZGCo/ZiDERq/69T6l+wX6HjZaODy
         rUSQ==
X-Gm-Message-State: AJIora9qP8iC3HCev2XSv2bQ+iZw2GpSb8nbAC0UfannXZcl1HUPDgAp
        pKylBEWz79w0npwy21gOaD3yaEAv1rO/hb7WakvXM8ivEMI8
X-Google-Smtp-Source: AGRyM1s6t+4IF+v7hbqi2PlMOZGH0tixMsiyQiUO7bNWMmDuM04SIpLSXFwFyeW9YoDZuVAqPmhDBkViVN49Qz++gBK/VKkn0WTb
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2183:b0:2d9:5c41:52dd with SMTP id
 j3-20020a056e02218300b002d95c4152ddmr1410606ila.140.1656494296687; Wed, 29
 Jun 2022 02:18:16 -0700 (PDT)
Date:   Wed, 29 Jun 2022 02:18:16 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000206fbb05e292a244@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
fscache: fix GPF in fscache_free_cookie
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
