Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96038C19F21
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Aug 2022 19:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiHDT10 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Aug 2022 15:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbiHDT1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:27:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D6C6D9FA
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 340696170E
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93384C433B5;
        Thu,  4 Aug 2022 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659641236;
        bh=df/03loVxlorTieG9wxP71eq8MpkMGRv5lckju659Rw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CjpRz+fX/whD6D9XVkE8uPF6xU1wh6DYSF4zXs/l8gbXXZhTjMNAp+2gwoijT9Asm
         2B1mwgl6jPLzIL5lcJaS9teNxqaZU9zBZf0p7YcalJ2pfHIrikUNzKw+KVarHbVKMM
         gaVFS0BP7EN6wUKOH5fFrmIKNTnrrUYgjznLy3YyUgd787znbVxiFXJZbgE8n/myfG
         bsgRdMXBgvITNtrjQxGaFH7T2K7lADMCqHGY0DkcwqwvGQ02YXdUq379iJdq0MBp9j
         ZKJSlJl/TGedefvNen6nmPcGdaGyopAiy6CXKja3BlQai9W/cw5Dx8kUct0fh1CrWb
         qeyArAYEXOMdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 835D3C43142;
        Thu,  4 Aug 2022 19:27:16 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core changes for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YuqDMLF2AQyj4+N1@kroah.com>
References: <YuqDMLF2AQyj4+N1@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YuqDMLF2AQyj4+N1@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc1
X-PR-Tracked-Commit-Id: 273aaa24369cb8d0f246bb16f7122b91a1ef5188
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cfeafd94668910334a77c9437a18212baf9f5610
Message-Id: <165964123653.8981.11316916554539708453.pr-tracker-bot@kernel.org>
Date:   Thu, 04 Aug 2022 19:27:16 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 Aug 2022 16:16:16 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cfeafd94668910334a77c9437a18212baf9f5610

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
