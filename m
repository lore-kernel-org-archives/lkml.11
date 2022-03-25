Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217BBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 21:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiCYVIt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 17:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiCYVIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:08:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DBF1EDA34
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A2B61D7C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:07:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7526CC36AE2;
        Fri, 25 Mar 2022 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242426;
        bh=bBUfK/ObRVGBJeEeygK/7J2ruVg9WWmVKJwoD5o+gT8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U4rinlOX4AAlQu+sec9P1Dbr8SWjwNsZ6DfVZM9uy3xT3LIbF/HVRqVlpJbng9bBI
         bVcFjMrSlI8I8xu9O/4ZoF62Bc0lqg8zg4VIupx2XE5ycYb4Y2JsLkhB3bzsSXXwJc
         xXlaZwtTNkbY0o3nYFUC0x+zeqDbnp2XLr3/3k61dJwNAp55dzd7GDEl6LVA3kCPBJ
         cQYdJVhOcQYyj5aH3kDqCaEl13RJ0cj+cHGs45g74kYhEFo0zv6nq2xOzkpJfiOHKu
         kqGjr3gvKTZh7N9bTu6dvkAumJDQwvHGyuD0eE3Qwp3WDd4Nk0yXc1EgenI+eEtAaO
         CPv/fzuHW18aQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62219E6BBCA;
        Fri, 25 Mar 2022 21:07:06 +0000 (UTC)
Subject: Re: [GIT PULL] MFD for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yj2f4VTOBd597Vm7@google.com>
References: <Yj2f4VTOBd597Vm7@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yj2f4VTOBd597Vm7@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.18
X-PR-Tracked-Commit-Id: d99460ed5cdcc28feba6b992630b04650e410902
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8350e8331b3971533d6e6112ab596eda2c2ffffd
Message-Id: <164824242639.8431.1618632956206126089.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:07:06 +0000
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Mar 2022 10:56:33 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8350e8331b3971533d6e6112ab596eda2c2ffffd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
