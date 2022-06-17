Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058D9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 15:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382703AbiFQPAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 11:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382969AbiFQPAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:00:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC0393F0;
        Fri, 17 Jun 2022 08:00:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BCAD61ACA;
        Fri, 17 Jun 2022 15:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1003BC3411B;
        Fri, 17 Jun 2022 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655478010;
        bh=FzUIGxt79Fk2ddWDeOMMHRXgIZUq8KVOHqj6cKF2pAQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LMctRbce21P8PktfJss01bc/w4Bw9RjUgY9CGoxss9iB8yIuyWwiybiGXb6jp3e6v
         JEz2nh545VL9VlrFvw3sH5taHZE4OJMErs8XpxqDsOayYsr6X5F44rUL4EW2DC0D8/
         vB78AzCcFLD26P9Bt927+4KKmTxChcL73zuESliMjwetewanL3Mxfa42eP0JVoD7Da
         2EajWBHxw1xXnKBihWMFfcZqoLNzPUVbFestagpc3WJFAy4KP9ZHgp5Zl4rXd1segY
         m/b56wIB8aekqRa+ZK3Xnx26UdxK75dHv1H9USefVyjw64RVY8NiJvOOhrUKr4rV18
         97seizP4D4uaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EEEA1FD99FF;
        Fri, 17 Jun 2022 15:00:09 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.19-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yqw361X4Szdht3HF@kroah.com>
References: <Yqw361X4Szdht3HF@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yqw361X4Szdht3HF@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc3
X-PR-Tracked-Commit-Id: 0698f0209d8032e8869525aeb68f65ee7fde12ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9057a646446c7ff3f1e7a97d0039bde7e7936279
Message-Id: <165547800997.17120.11558122990521165550.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Jun 2022 15:00:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Jun 2022 10:14:35 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9057a646446c7ff3f1e7a97d0039bde7e7936279

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
