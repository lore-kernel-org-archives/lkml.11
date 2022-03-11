Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FF9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 00:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345240AbiCKAzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 19:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345135AbiCKAzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 19:55:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F576A2797;
        Thu, 10 Mar 2022 16:54:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA35EB829A3;
        Fri, 11 Mar 2022 00:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70B0BC340E8;
        Fri, 11 Mar 2022 00:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646960079;
        bh=m0r9HuCb49YnQUW6GAIMeJ1t0TNvENV22bDIKcU1vMU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UisG592AoeVD8gB75o5RSHPNNPYPF4svx7L0bqGEGM5vvJGeid+GLNOownz2yUJup
         +KqB6N5uBQ/5L+pIldFZFi3ibtQ/GtGTKb9w3GKzKN2802ENezSXWl2RGrq1TUgfsU
         XXL3ZxFPzqYcsX6rxd2z0SHNhQpOd+AD8WZHoq56Suvbc99aOut51qmsjEzwo8Diaq
         CSw0JbEg3QurMDw/dVZDpFNjABTZ6IumjSI0igxGQSYrjR/RF3tkLpweiO6qzCdmxq
         xmdcIeKVmNrxLMJM2AmwR2gY3G3KvlQpwsDzawzqFIcL5sG11r8T+1w0CjzLuf0OB4
         NlgUhguCiLjWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D481E5D087;
        Fri, 11 Mar 2022 00:54:39 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 5.17-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220311002912.437871-1-kuba@kernel.org>
References: <20220311002912.437871-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220311002912.437871-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.17-rc8
X-PR-Tracked-Commit-Id: e0ae713023a9d09d6e1b454bdc8e8c1dd32c586e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 186d32bbf034417b40e2b4e773eeb8ef106c16c1
Message-Id: <164696007937.2789.7626749718559304102.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Mar 2022 00:54:39 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Mar 2022 16:29:12 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.17-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/186d32bbf034417b40e2b4e773eeb8ef106c16c1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
