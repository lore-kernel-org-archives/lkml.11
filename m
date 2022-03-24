Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E830C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 20:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355222AbiCXUwG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354044AbiCXUvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:51:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4B83299E;
        Thu, 24 Mar 2022 13:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E1A1BB82613;
        Thu, 24 Mar 2022 20:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D10BC340F0;
        Thu, 24 Mar 2022 20:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648155005;
        bh=bc5zhCF8RTCL4oO+idDDgCpcsbsLmSBh7R9VcoBmLLg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=STzO3hmx0obd42L31W9UYBfFYpxPR3s2Jy8xVLNPlhjh8oyeF0cH4+o5tk1S+KMhh
         TO3OcSOTewt3AmZHToMbazWcrB8OKZtOxNMcKMDqKGTfTAETHyEFDbN15wJf/uyKUZ
         HpB0RCR/onMzwo5Lrpv8b/eHmKjrfLTBDCD6UDukn/YtEJTSk27Z70AXM3ZP2Yl9fT
         FzDoMiPWEpSQnno5pV6/9QM1BrwDAnVqOH8JryXePqZiIQlo6Fmgwj1YAeSWXkEyr1
         Gmm/dOddqzMCrxk2Lwh9gl2eux+XpsBk6xkiYiaTC0kDpToqcTFS5pl0cW67KJi3vn
         L7t9YooqsTMwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85B22E7BB0B;
        Thu, 24 Mar 2022 20:50:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220323180738.3978487-1-kuba@kernel.org>
References: <20220323180738.3978487-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220323180738.3978487-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git net-next-5.18
X-PR-Tracked-Commit-Id: 89695196f0ba78a17453f9616355f2ca6b293402
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 169e77764adc041b1dacba84ea90516a895d43b2
Message-Id: <164815500552.16044.10254978984783989754.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 20:50:05 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 11:07:38 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git net-next-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/169e77764adc041b1dacba84ea90516a895d43b2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
