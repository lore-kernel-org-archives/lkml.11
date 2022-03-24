Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5048BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 01:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347064AbiCXBBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 21:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347057AbiCXBBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 21:01:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5513377CF;
        Wed, 23 Mar 2022 18:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DB80B821DC;
        Thu, 24 Mar 2022 01:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34811C340E8;
        Thu, 24 Mar 2022 01:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648083614;
        bh=6O2a4mFwMkFjgsy/rKluhoa4YACPj8I9TGSe9FbPi5w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=M+Qe6ZjULFRbDve8V73KGjI4ITPPMTdaIovOF+YofcL6dpDKpgoHkjaNkf+vTR9XC
         0drRmOxL+zhOaxGfIbfTZMa/0J4+wRduisq8dff/v3gXCXqE42dkBtOjk7rKA3mcJi
         LsZ3KBCDtkvXydOAA6WJIy+Jx9M1GXysZmSDAjkdtuS18ehtFYIrIC9fhCJJtji8d7
         JnpDzLcKt7EmZSspM/GGR9CehtGFo22fIc6oRWrnNCPhh5epWQRjC3k93U66d+8umO
         dNh6+QcS1HZQgXnu4g5m9RHImNd1kSTFl5o9bMIns/jzgUC2B55RBoxGG4n48zpsmj
         l2q3XKcURpQRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D8A3E7BB0B;
        Thu, 24 Mar 2022 01:00:14 +0000 (UTC)
Subject: Re: [git pull] m68knommu changes for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <472947d1-a827-a490-bd24-6ecb5a762047@linux-m68k.org>
References: <472947d1-a827-a490-bd24-6ecb5a762047@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <472947d1-a827-a490-bd24-6ecb5a762047@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.18
X-PR-Tracked-Commit-Id: e6e1e7b19fa132d23d09c465942aab4c110d3da9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e6aef3496a00a12e78a571f61d98300cf0a86e6a
Message-Id: <164808361411.21935.15716042657289354795.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 01:00:14 +0000
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     torvalds@linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 15:25:25 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e6aef3496a00a12e78a571f61d98300cf0a86e6a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
