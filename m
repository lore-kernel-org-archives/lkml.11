Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B98C433FE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 May 2022 19:05:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239537AbiEHTHe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 May 2022 15:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379961AbiEHSov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:44:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB1B85F
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E97161225
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 18:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C361DC385AC;
        Sun,  8 May 2022 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652035259;
        bh=LBec9Q4x0I+hgg8iZumGkIvC4abGfEW5goBzTShxtMs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hwRzwH9GRlzDzfyAYV+uXWigpRVCPSCBxeDwdYzoXVReSpIqp2SbDHBGLx8aNJ5kD
         7ZIL7mBq2am3twTI2enefOt10kLghjk+PfckoS63DN8KPr+4hnaF+nbfntdO5Tt7Aq
         cJ7iahkVmJsq8bmZJRO45aYOc7vy08h2MbX0DmynxUx6Zf0samkoaAlBkemwLBrsWf
         Wbmejc1JsK3PAjvUQz97LOQoWf2KOdVxTmZK5aIqiyOdrKQQ3FtV0B2tQB2+0zA6dh
         WcsQHNp7m8I3YnRShy4/nF2T5Hcshk8ZmBf9d10HFevq2isLfQfwXdnd3nPS7EiKho
         /2mAXz2i7oU8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A65B0E5D087;
        Sun,  8 May 2022 18:40:59 +0000 (UTC)
Subject: Re: [GIT pull] core/urgent for v5.18-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <165201148069.536527.1960632033331546251.tglx@xen13>
References: <165201148069.536527.1960632033331546251.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <165201148069.536527.1960632033331546251.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2022-05-08
X-PR-Tracked-Commit-Id: 2667ed10d9f01e250ba806276740782c89d77fda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f8c5dff000d96b66273a0bf57dbf4d505c730cc
Message-Id: <165203525965.974.16862885725044829572.pr-tracker-bot@kernel.org>
Date:   Sun, 08 May 2022 18:40:59 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun,  8 May 2022 14:05:19 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-urgent-2022-05-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f8c5dff000d96b66273a0bf57dbf4d505c730cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
