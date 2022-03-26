Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA25C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Mar 2022 20:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235411AbiCZUTm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Mar 2022 16:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235108AbiCZUTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 16:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAB9201AD;
        Sat, 26 Mar 2022 13:18:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27AFF60DE7;
        Sat, 26 Mar 2022 20:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89277C34110;
        Sat, 26 Mar 2022 20:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648325879;
        bh=t9TqTzHBMH9CC+VthsB8t8Y6SaXZs2Sfvo6XYeWkERI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=AI+8tw4ZgSQ8fo43Msvj7UkRwwDYGJuHsskUN6lYe2UDnXt4iFTe8Yn9leaGvJCQ6
         plXoEOkfwDaTBLM0FbIVucQCb+ozsF5snWaGOP+0I4EH7kVWQd0y0uGYuCWKLBBGAg
         Uy4Fq/FqDoNBOThg78fB5o/091WCalweF/y+TUkZeWUio4x4QWaVEWhYdOam4u1Dp+
         4xplMWEKL5bHTZe71jjPwno1Vk6IMhEb2CEf4LnynwtYudRYreDw3I6TRBVHNo9maE
         2NQuatoVJfHsMECDOZk4oCX6BY9WlcT6cDMby4BHwGOxNVEGpKYNQVD+8jgYnTWZ+I
         6pPgsD4JmqbPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 77A36E6D402;
        Sat, 26 Mar 2022 20:17:59 +0000 (UTC)
Subject: Re: [GIT PULL] USB/Thunderbolt driver changes for 5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yj7vGtn8fILavjyL@kroah.com>
References: <Yj7vGtn8fILavjyL@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yj7vGtn8fILavjyL@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc1
X-PR-Tracked-Commit-Id: 46d2c20b0b10cf07a2a24b047a09195ba96c84f7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 710f5d627a98e86f821aceb840b8f2f1fcc6cf75
Message-Id: <164832587948.7233.13743974093479078315.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Mar 2022 20:17:59 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 26 Mar 2022 11:46:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/710f5d627a98e86f821aceb840b8f2f1fcc6cf75

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
