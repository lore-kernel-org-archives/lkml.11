Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE47C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 00:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241364AbiE0AdC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 20:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240998AbiE0Ac6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:32:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5FAE279F;
        Thu, 26 May 2022 17:32:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6507F61D2F;
        Fri, 27 May 2022 00:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86E01C36AEB;
        Fri, 27 May 2022 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653611576;
        bh=HSuH8lQkNnQvGfRavnp/3y3zXzXllGHmcd834/c/yBk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Lr5WuaeWBuCMbGojH1h0EPHBBoaQeh+t+QncjMqbzhSBrZrXBtIeTfP3lhyP11xQn
         oDhtEjqeksrnz71Lsd5curaNhC5Z3iBwAHeaNER+QLv8QYd9kjC9yeRAjrVmGZlmZE
         J7OWr1umkswLKOCSIAiu3VVeSXa0EwVOjnZC96IZpxoYQklrDRDCkV9lCgWP8qTJTr
         XTlXAPAnSHl7qNcfljIpCvg1JDyugCQDpT+fEsp6cQDNN+q+ZIBVsgYAjBnw8/7aT1
         C+PXAG93Z6JxrlHg3iHBkFpUituJ4jBJaTM0V1qF13fEuUS+zJI3xXwThhzaa+MT2b
         UWLHc+ZPuGcnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 71A80F03942;
        Fri, 27 May 2022 00:32:56 +0000 (UTC)
Subject: Re: [GIT PULL] sysctl changes for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yo6x6uatAbdsn0JJ@bombadil.infradead.org>
References: <Yo6x6uatAbdsn0JJ@bombadil.infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yo6x6uatAbdsn0JJ@bombadil.infradead.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-5.19-rc1
X-PR-Tracked-Commit-Id: 494dcdf46e5cdee926c9f441d37e3ea1db57d1da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44d35720c9a660074b77ab9de37abf2c01c5b44f
Message-Id: <165361157645.27205.15620664423908667724.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 00:32:56 +0000
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        patches@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhen Ni <nizhen@uniontech.com>,
        Baisong Zhong <zhongbaisong@huawei.com>,
        tangmeng <tangmeng@uniontech.com>,
        sujiaxun <sujiaxun@uniontech.com>,
        zhanglianjie <zhanglianjie@uniontech.com>,
        Wei Xiao <xiaowei66@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yan Zhu <zhuyan34@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        liaohua <liaohua4@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Vasily Averin <vvs@openvz.org>, yingelin <yingelin@huawei.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Konstantin Ryabitsev <mricon@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mcgrof@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 15:47:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44d35720c9a660074b77ab9de37abf2c01c5b44f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
