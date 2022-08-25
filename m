Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB52ECAAA2
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 21:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244167AbiHYV4L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Aug 2022 17:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiHYVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 17:55:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23AB7DE;
        Thu, 25 Aug 2022 14:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97ABFB82EA4;
        Thu, 25 Aug 2022 21:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46651C433C1;
        Thu, 25 Aug 2022 21:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661464530;
        bh=X3bWbDSry+e7uc9DbquJWm0oIx95TLMrzzMRVNBSolo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qGeJNE9cKdT4TqNeKt9GZddmisRL0I7r47HodrcaMkfcWZbg55w1Gr1qSMVETGTAq
         0OiljfW40wBVYNqQLh5dXOLr0oitfYqQxtWBxzVsPABkj8ZdBvrTBQmqIQuIhvMoYM
         TtqBZD0Db4mwuq51IOI9Voxo3oOnQFon7fI9D8IGSQmkYqZNwjw9+hTtdVDXs9NmmD
         dqBPT3K0FtYqBO8uPxtA0RaXP8VUYjvH+uP8oYWdcetfyPPhe/vGhz7edvoQNmAn6w
         kMUeHC2ZKO8GoqEZD4Vrv+9k73nl9zqZE93GhEGVr+a7yv25tsmysT0sQj8po8TZf9
         yY8G5ZMpQI1Ww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34D0BC004EF;
        Thu, 25 Aug 2022 21:55:30 +0000 (UTC)
Subject: Re: [PULL] Networking for 6.0-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220825203819.2507927-1-kuba@kernel.org>
References: <20220825203819.2507927-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220825203819.2507927-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.0-rc3
X-PR-Tracked-Commit-Id: d974730c8884cd784810b4f2fe903ac882a5fec9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c612826bec1441214816827979b62f84a097e91
Message-Id: <166146453020.32115.7961228027709825217.pr-tracker-bot@kernel.org>
Date:   Thu, 25 Aug 2022 21:55:30 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 Aug 2022 13:38:19 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.0-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c612826bec1441214816827979b62f84a097e91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
