Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C874ECAAD2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Aug 2022 09:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiH2J52 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Aug 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiH2J50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:57:26 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A6F5E328
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:57:25 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id g5-20020a92cda5000000b002e954ecceb0so5561816ild.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=DcgrQ7vZGgd3ZWDwFQ/e0Mygdn7y5DC6hYP+M5pMMaBSB3ab4DU62ivsVbATE5/ru4
         2wTK2FegKbtDfy/IYqThgbRLiYURDn2rMvCYQRj3skHhGio61V+353YeHqxfeby/XJVt
         AeF20DsAwMcGSX7qgJIrshIXlGzq+QDJQ5IFKdbHb0Ta8D/f+yT23gxAKHwqPL/ZgtbX
         dkIWHF3038Bwt0/hY2U/l+ReAjj3kTzRs87TdzqeUBre8jUtKeSIuFOZ6fz6z+Qz29KZ
         ymxePrC/b/hmsobuD7mCabQhJB1ZYR1Bx370UNrwje5pOX1cAZcxIMxGmGQPy/JUWWo+
         JOyw==
X-Gm-Message-State: ACgBeo1rjNqGVa4Y5i5bqw6Jf062m7ZqObO+boFs7KweLuoWkerT3FLN
        5mSDfIOaEfH36bDEgpRZMM3x9P9opejZDTdL07hrBYgXwRUY
X-Google-Smtp-Source: AA6agR4047SUJ1BLtOuBVO5UEYKaNvW+AYfU2ca+vudLKRQqkT0iYQAwoPhxw+l2bKYQdrlt0TJE9b8wp2UaQpbPo9e6zD+ZnsF5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:dc4:b0:349:f86d:d29a with SMTP id
 m4-20020a0566380dc400b00349f86dd29amr10201198jaj.256.1661767044603; Mon, 29
 Aug 2022 02:57:24 -0700 (PDT)
Date:   Mon, 29 Aug 2022 02:57:24 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000064a39405e75e4aca@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
net: core: netlink: add helper refcount dec and lock function
net: sched: add helper function to take reference to Qdisc
net: sched: extend Qdisc with rcu
net: sched: rename qdisc_destroy() to qdisc_put()
net: sched: use Qdisc rcu API instead of relying on rtnl lock
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
