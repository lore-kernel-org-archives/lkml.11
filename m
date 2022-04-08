Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA66BC4332F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 05:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiDHFko (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 01:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbiDHFki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:40:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C1E188548;
        Thu,  7 Apr 2022 22:38:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87A72B81AB3;
        Fri,  8 Apr 2022 05:38:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3347DC385A6;
        Fri,  8 Apr 2022 05:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649396314;
        bh=24Sb3ZcIJnkjwvcjjDFTephAAeeer44PDgDhiSfA+Xo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gcE5j2iWFNtDByMP38airNW4bdsP6OTe38cghPbemWJj5UV9QVEI02EmJ2MI27y3N
         2NV24MYFFjCgrcRq4wtGw3HzABZW3nOinxsSkz5iyjvmll+UVFq5QPNl1JSDiuUeg9
         ftsKjHDgJsceEzXk43c0KuJYEp9yfHg5r7KKvGKSLvOfO50sG5sWghMUAFntba7w00
         1toIRnqY/eYpHrvcpXz9LmCRxNtHCKxCyKz3AZG7yf7Ot0hBpu0BGyHT538kN1jE77
         YAvSmQcwcP1f5aPvshwKoLnbTT+ry5OMx9V2GDtsHY9Kgfps0Z2khT4jVneapXiI3f
         z47sFH8ChqeKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 21B6BE85BCB;
        Fri,  8 Apr 2022 05:38:34 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 5.18-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220407182127.55769-1-pabeni@redhat.com>
References: <20220407182127.55769-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220407182127.55769-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.18-rc2
X-PR-Tracked-Commit-Id: ec4eb8a86ade4d22633e1da2a7d85a846b7d1798
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 73b193f265096080eac866b9a852627b475384fc
Message-Id: <164939631413.5614.6072454805076431525.pr-tracker-bot@kernel.org>
Date:   Fri, 08 Apr 2022 05:38:34 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu,  7 Apr 2022 20:21:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.18-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/73b193f265096080eac866b9a852627b475384fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
