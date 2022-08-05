Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5583C00140
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Aug 2022 17:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241109AbiHERxk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbiHERxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:53:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64C71C10C
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 10:53:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E01F61876
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 17:53:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C158AC433D6;
        Fri,  5 Aug 2022 17:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659722012;
        bh=ZRbRSvcO0JUBU9aE9roQc0RGwfBTeA2DZZma2RZia48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ANBV8cUxkRjj2ynEMVsydVpC6xpMklsIXwtJWlKkTnco71gZ05wA0+wEUKrcqzmhK
         aVgdznJOYsSNYEOmPEOR4NvkveANAMaq2heNY5EfW9ucssjc2Mo23Cg+BZgLCPVnWg
         lRy7TOA7T4LmKKDO16odWz54rkNsqtuDwADXA1VybwwG0AiHSmXb1BVoqKl9u8qIJO
         Qxc5mYFDFFmgWf3Qkgiwcec82vtzC5S/j687N9Btpk/2ds/DOwnYIExScpQQxxU1wk
         J4G8da7q+WjYdkIFn97Sglsd+wsNmpxSwB6UfQ7c+tQ2Fd3/3rU9+qpyTyxj8F5moC
         Gi7vG52xzYRVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A6E83C43142;
        Fri,  5 Aug 2022 17:53:32 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220803213356.3396773-1-dave.hansen@linux.intel.com>
References: <20220803213356.3396773-1-dave.hansen@linux.intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220803213356.3396773-1-dave.hansen@linux.intel.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v6.0-2022-08-03.1
X-PR-Tracked-Commit-Id: e0a5915f1cca21da8ffc0563aea9fa1df5d16fb4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9e2f40233670c70c25e0681cb66d50d1e2742829
Message-Id: <165972201267.24745.14389433501078419287.pr-tracker-bot@kernel.org>
Date:   Fri, 05 Aug 2022 17:53:32 +0000
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  3 Aug 2022 14:33:56 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v6.0-2022-08-03.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9e2f40233670c70c25e0681cb66d50d1e2742829

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
