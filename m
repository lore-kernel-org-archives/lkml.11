Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 224BAC25B0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 09:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242198AbiHOJ5R (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 05:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241988AbiHOJ5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:57:15 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C9E1CB08
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:57:14 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id d6-20020a056e020be600b002dcc7977592so4688113ilu.17
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:57:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=FnKKacMbiDxpSpEreS74JN1xL/0l9SZqe7Vvsl5KJyBNFJZotruItXIyT4RC0XjOfd
         gWooeNFdL68xfT73h9Zcfaq6KJEJmZ6wVTl4eA5/rfsxWDgPd7rJrQg+mN1jDJE8jAyX
         IGmDctEuFoB2XVGfGbT3ru5idhUBpOjvg9fPjF00nc7rpjVlVrMOfpi94pUVl7qQFaJR
         dGD9BFKsSzute0KYk1d4Haj0mL2i55PlcEThjhLXc30mokOP7V1P5H68S3NIn5Zhe3Y0
         YAFJS8qHO5GKIT8RVLpRnf1j+yQmddgAy/X56XQdPBYeiHPWFOEQhY3SNtFiEhu2RXO5
         KdtA==
X-Gm-Message-State: ACgBeo31P6gG1aT2C4LmqzMhbS8pecYB+IoOizzyte7fkCsQS51oR2+T
        d7FC+VcxvJ4DqylxprMzWWO8RNtpVN2PrayKeqKjvuafFrjo
X-Google-Smtp-Source: AA6agR6AbAVlhZsTe15PSmlUkdGs1oiHfzDhUBfqN/Iw6/VkrP1/SraWLukIzOPserQ0yidjd/GxK8mzoAQFc5rXxYclEj0NUuNo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2109:b0:343:59d7:3815 with SMTP id
 n9-20020a056638210900b0034359d73815mr7473895jaj.116.1660557434005; Mon, 15
 Aug 2022 02:57:14 -0700 (PDT)
Date:   Mon, 15 Aug 2022 02:57:13 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbab2f05e644a744@google.com>
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
