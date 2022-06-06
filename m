Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FC4C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 09:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiFFJw1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 05:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbiFFJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:52:20 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE152AE3E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:52:19 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id l10-20020a6b3e0a000000b006694bc5a982so1156868ioa.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=m0ILrg3XORkWFQx3MWk/V4useGB3zYjmelGsIjNHJpssVDniD+CcEG6zOS09ife+xg
         EYkdj/HgRMIKa4+MYgX2lsZEvfcXg9aOyjf3pMAlgGfr9AqxHaCtndahIO/O0C/VwBZt
         fJc3ShZeHfE2rCPUJqJ5aL1xLe3BvoHyE0DOn6WGuddkif/NwG5Rpeu0kcuBnntRtP+d
         HorJditlrl3dus8xfIanvjZkNEljhf4rquGMqyoIvlwqbtE5rHibHuKst5HAH7VABQFB
         HDPLmWDId3jbgWBQnuLfiBImCFPM3aLTJro5eil1NYvLpwHIXrloKFQ+qUWAzRup0AFT
         GIVA==
X-Gm-Message-State: AOAM531vqcx9axPIuD/8RrHWu5+alrwRw7tYkhihmv8v0vT4b68nOCey
        On7p+qfj+aEmCYG/TDD2z+NRkWSydflRkVEbPnsmJ2x81rvL
X-Google-Smtp-Source: ABdhPJzMcfdshAMR4/41NwWk7h2niybfbLAyNCHU4y8xAGtBTFW8LLbM3njADMk5p8lwRUTkcttApy1luZYi9RizLd5I/OH1FM7L
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:8ae:b0:2c7:90a5:90b8 with SMTP id
 a14-20020a056e0208ae00b002c790a590b8mr13851678ilt.19.1654509138328; Mon, 06
 Jun 2022 02:52:18 -0700 (PDT)
Date:   Mon, 06 Jun 2022 02:52:18 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000077c3fb05e0c46d94@google.com>
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
