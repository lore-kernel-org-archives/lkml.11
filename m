Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9853AC25B06
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 21:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiHKVcY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 17:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiHKVcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBE46A484;
        Thu, 11 Aug 2022 14:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF38E614A1;
        Thu, 11 Aug 2022 21:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 581F8C4347C;
        Thu, 11 Aug 2022 21:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660253534;
        bh=ykcLoTfOrFiZ0kPyhlH07MUHCbEjDuw6ues/qtAfAAE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pijd1Uq0GuUwwgeUDRGSqLR0g3mBGNa5JSyt89r2orSA1QIiKFttaN2pOdf/NNw9t
         nHy9MYhT+pevqdsMzVBaqZ3bmbNDgyagxNsMWlaQ+lh2WpTIVGz4c0SJc4FSBkoTZJ
         6St+egL9IBRGisiXNar0Q9WHKZ++fMqyS70nLn90QOr/8we/qUm63jJnGm8d/xy5h+
         0bMCrGDlkq9ZVanQUmexmXRsxX8a/JW695qgUa4CaHUQ2YjHygUeRQoJFZxEVReNUC
         dXXw02W/MO4gWvNazCFgAWd1SnZ6g2lZIoAMJ6j0XP59mzwM/YVVUcNwuiCDdh4Pns
         dd5vdyyA5W9AQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43F68C43143;
        Thu, 11 Aug 2022 21:32:14 +0000 (UTC)
Subject: Re: [PULL] Networking for 6.0-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220811185102.3253045-1-kuba@kernel.org>
References: <20220811185102.3253045-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220811185102.3253045-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.0-rc1
X-PR-Tracked-Commit-Id: c2e75634cbe368065f140dd30bf8b1a0355158fd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7ebfc85e2cd7b08f518b526173e9a33b56b3913b
Message-Id: <166025353427.15191.2894879759209830677.pr-tracker-bot@kernel.org>
Date:   Thu, 11 Aug 2022 21:32:14 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 11 Aug 2022 11:51:02 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7ebfc85e2cd7b08f518b526173e9a33b56b3913b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
