Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF901C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 02:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241201AbiEYCRF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 22:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbiEYCQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFDB22BF4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:16:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3ED0C6153F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0CF9C3411E;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653444993;
        bh=0giMPf1zj6L8fuMbB3tKGpfvBbtCD3z3fIBI7NC5X4Q=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=fe0ddn4TlAvgIEyKu83vK+H6GbOt1JlUkprMusUtp9yAettPSErpOXbPahFKC4s1p
         1G7dWQd9zeEMwEp83wB2UPx/bbBhskektBvZjn1jK7UoppDGtsf7Xsv7FaUgazRm3P
         UtwcfGNR0dQ+Q1LJq1przB7W/+UCNmJpzP+M/b9Si9lBB6cr+sYDdo4RYlehjWHvEG
         TnEnrcAxBcWaiARTsyOxLfOhRC5Jy2TpxgOR7oKwfNIcGo5vxtrP+YnszF5lNFo41t
         N2vLK5eSZRTSXl/NqZprXFYihzAae4ogpOcRCw6xwod5S77VZTrjYoBBhXdbFA0qCX
         KRxgxNxpOXVDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FB30E8DD61;
        Wed, 25 May 2022 02:16:33 +0000 (UTC)
Subject: Re: [GIT PULL] dlm updates for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220524203155.GA4585@redhat.com>
References: <20220524203155.GA4585@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220524203155.GA4585@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.19
X-PR-Tracked-Commit-Id: 8e51ec6146fdec82f7308f89113497631013f16a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f289811258552a8a8c15d2446f9ead1d567357f2
Message-Id: <165344499358.22339.11342820924163109555.pr-tracker-bot@kernel.org>
Date:   Wed, 25 May 2022 02:16:33 +0000
To:     David Teigland <teigland@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 May 2022 15:31:55 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git dlm-5.19

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f289811258552a8a8c15d2446f9ead1d567357f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
