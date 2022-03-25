Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B6EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 19:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiCYTzG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiCYTyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:54:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1830E2DC03A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:43:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 425D761AFE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 17:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A75F6C36AE3;
        Fri, 25 Mar 2022 17:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648228683;
        bh=xWndAjtzXElfKh1kSJGSvkeiA9j0twuZ4q7vaiTDrFk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HfPCOf3ALZUz5c5GetfKhVgEtr3bKU8NMOTDKnsS9BmVal4r8cGg7lrCSJ2ACEtY9
         iVelFc1IkbdLaJ0DvguJPxAGlEEuVf2OY4smOKYUzcM5BOob2WmcoMVBLQVIEOCKgi
         ZgZb4ul9HcVfDayZ05vABksVxyor60Mbs4VZapdmkEhU+2eJOQ5omCdHRPl5tkJIIT
         CQKrPzDUiReHXmKBx7e1Yl6jsusmCNjD4XWV/aJ2HEC5ZcW2JGdUGOsZIh9Kh4Kdaq
         gqGWfKlEpt0osSdzEQ2TO5KvRmXd64gg/VtYpveaTIAVnVghvNdknMRodz51Kg3QRO
         yv1z7wbQSaEdA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9404FE6BBCA;
        Fri, 25 Mar 2022 17:18:03 +0000 (UTC)
Subject: Re: [PULL 00/18] xtensa updates for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220325154848.107863-1-jcmvbkbc@gmail.com>
References: <20220325154848.107863-1-jcmvbkbc@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220325154848.107863-1-jcmvbkbc@gmail.com>
X-PR-Tracked-Remote: git@github.com:jcmvbkbc/linux-xtensa.git tags/xtensa-20220325
X-PR-Tracked-Commit-Id: 1c4664faa38923330d478f046dc743a00c1e2dec
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 744465da705f7d8cd893e97738a47b91f3321ce2
Message-Id: <164822868360.13188.13159486129428363014.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 17:18:03 +0000
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 08:48:48 -0700:

> git@github.com:jcmvbkbc/linux-xtensa.git tags/xtensa-20220325

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/744465da705f7d8cd893e97738a47b91f3321ce2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
