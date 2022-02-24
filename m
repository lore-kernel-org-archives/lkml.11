Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0775C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 19:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiBXTSx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 14:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233565AbiBXTSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:18:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6C0B2D60;
        Thu, 24 Feb 2022 11:18:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8716261675;
        Thu, 24 Feb 2022 19:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E723AC340F2;
        Thu, 24 Feb 2022 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645730297;
        bh=bvJuOGgcV0Fdc1Qx5ON/8sJfaSUvZC0OjbxexBKrqls=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QS1tESOCJZ4rkmg9Ut/jk1Wnt9ILhLx+c45eIzb5b9XMOd+mpLBkUD7R2QLZ6La47
         xRAHsKCkTOFEU6n0DaLKdeX8rsHb56SHK6AVOpsydOJlkk5AU3uie1F2XeuXIVsGAv
         1dJYFVzq6L4m1bTHRex5NDPEqvK8KKHtdvuI+bXnFGSQpgvq9q9QWUlgYpwSyb/ZQ3
         pm6IlawEkmsj6UdVZM/gMgEdKl+06mqnEpGWBZ89va6z6qs7l2hHGSJlIgu5DltxMZ
         uSIQxuKnTpY2NVDSvMH9BNfad+kaTzWl8PKDhw6JjE1bYkpgynCmJ3oUKe+oPV6pqZ
         hNqP7ppfOxyYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3FC2EAC081;
        Thu, 24 Feb 2022 19:18:16 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.17, take 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yha/383yJgJFHqPR@robh.at.kernel.org>
References: <Yha/383yJgJFHqPR@robh.at.kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yha/383yJgJFHqPR@robh.at.kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-2
X-PR-Tracked-Commit-Id: 0c0822bcb73f154d96ee648644ec5a8628e3b864
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91318b29a81cf51451ecf1c0054898f67dc26d87
Message-Id: <164573029686.2860.6703762335601163588.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Feb 2022 19:18:16 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Feb 2022 17:14:39 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91318b29a81cf51451ecf1c0054898f67dc26d87

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
