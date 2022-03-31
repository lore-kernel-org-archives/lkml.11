Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65017C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Mar 2022 21:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbiCaVXj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Mar 2022 17:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241835AbiCaVXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1EA2359E5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 14:21:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4EA61B54
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:21:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1B7CC340EE;
        Thu, 31 Mar 2022 21:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648761704;
        bh=X2pKQUXXwyvomAytblE0pn+hFX83ejJZGZQQFmAXJ2s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hvt/5rljg2xxPrC+FIJyoCcE8usa3rv7DNygz7blB89MRYylr20IrAQzEzidAUN3H
         r8xWhfo2vlLJ6sY5DZjtA6nrU6MP7YJYSsDtSMIwDTjG5K5D1aumF35LxRrNDljAui
         97uBmFYodTuIvmUcCVQ5qDrWk48h2FS8G0OvqAaGOh7Ruwcpca9001w+K7IplHu+7Y
         CJEiwKwraHDQ8JZguNj9uUX29r7zsteW2wXqr9dJFGrcnCIK5uvOezu4/2xoVEVkfe
         +2tZAmP0oTl8FsYjrm3u58a70Exp+ZRd2biiltn35P4W7DOJNer+NC4dqdOfpmtdXo
         CTyH0+PQuqvkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8B0AEAC09B;
        Thu, 31 Mar 2022 21:21:44 +0000 (UTC)
Subject: Re: [GIT PULL] auxdisplay for v5.18-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220331164446.GA21062@kernel.org>
References: <20220331164446.GA21062@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220331164446.GA21062@kernel.org>
X-PR-Tracked-Remote: https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.18-rc1
X-PR-Tracked-Commit-Id: 13de23494f387315c6cfab6fe78fbed7d1b25586
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4f1db771599852713fc2bbb7d3cc6cf9ace3b54
Message-Id: <164876170468.29828.8691997955465392025.pr-tracker-bot@kernel.org>
Date:   Thu, 31 Mar 2022 21:21:44 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 31 Mar 2022 18:44:46 +0200:

> https://github.com/ojeda/linux.git tags/auxdisplay-for-linus-v5.18-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4f1db771599852713fc2bbb7d3cc6cf9ace3b54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
