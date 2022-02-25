Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295BDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 22:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbiBYWQH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236620AbiBYWQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:16:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B5318F222
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:15:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8763561C44
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 22:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC1EDC340F1;
        Fri, 25 Feb 2022 22:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645827328;
        bh=hTLfwQc8nehctyoC4tw4J+qi2GfalTGxbcAf+wgp/ac=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gQxP0a1ENcIuacMTWPVkpOVIqAmNal8AtCZrZBUxO/GlWd7eguA90B964qyW7bkWe
         hWJAHnQiKY/UkBfa9QsJDwjkho34CRtdGnv/anMsOc0gr/Q/5OeM6W8n+yvHUjjCwm
         tz/9ow6d9ZiERP4p8XH5onZkDwA0UCNXz8HXRhxsJWnyN0hr1oVBD5qndq1OUlDT1t
         GLQwyWfipMbxrEwRER06P7YfnHBA/inw7WjoNmdyAGvIcXo0WfSsUI11o151M+stTA
         XhwG3XzVKdu23kf7SXLcp2LOnKlrUeGnp99QA9lVqCgJpTjCLB3226CjwUiP5+c/aY
         g6sMaeutXpsdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D59C9E6D4BB;
        Fri, 25 Feb 2022 22:15:27 +0000 (UTC)
Subject: Re: [GIT PULL] configfs fix for Linux 5.17
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhkkKzBxKql579HU@infradead.org>
References: <YhkkKzBxKql579HU@infradead.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhkkKzBxKql579HU@infradead.org>
X-PR-Tracked-Remote: git://git.infradead.org/users/hch/configfs.git tags/configfs-5.17-2022-02-25
X-PR-Tracked-Commit-Id: 84ec758fb2daa236026506868c8796b0500c047d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9137eda53752ef73148e42b0d7640a00f1bc96b1
Message-Id: <164582732787.9849.5956511345526898135.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 22:15:27 +0000
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 19:47:07 +0100:

> git://git.infradead.org/users/hch/configfs.git tags/configfs-5.17-2022-02-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9137eda53752ef73148e42b0d7640a00f1bc96b1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
