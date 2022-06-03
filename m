Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BFEC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 21:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349449AbiFCVtS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349198AbiFCVtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 17:49:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2422E56F86;
        Fri,  3 Jun 2022 14:49:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DADA4B824CF;
        Fri,  3 Jun 2022 21:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 879AEC385B8;
        Fri,  3 Jun 2022 21:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292952;
        bh=cTISJQdh4qqLaNgRLXUFPZhDagazoee3+BOHcpj6KWk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jliesisNHdnCXFfk8dgt6E9wHjnKCytU2DQUJjrPx1jetCSZcwbSnT4QbCtQssSJP
         bbdRX6U1JCfuExMVG6ndUqhVOsbZeozeiM4FfL/T2wDhkppukNgn4vJ9Pd+PQlhwYN
         f+HStz9MWBdkePU9zohnJqYX/exi9YGbxWvRFqz8Y3rOk+wCYQtgwf/4rpnwFHsOCu
         NBzumeSokM4qArSziGVbi/fifIQR57wWen6RyFCvdFfgvvOuFK96JEVte5i5VsUko3
         b7+dFXrE2sYwaeanNIDYnhB7aWX4ll2P0tIpkUnRC6lpSY+PywZmtKZGk5WdeIjg24
         M2knHAzS3i8PA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72729F0394E;
        Fri,  3 Jun 2022 21:49:12 +0000 (UTC)
Subject: Re: [GIT PULL] Devicetree fixes for v5.19, part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220603174702.GA614240-robh@kernel.org>
References: <20220603174702.GA614240-robh@kernel.org>
X-PR-Tracked-List-Id: <devicetree.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220603174702.GA614240-robh@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.19-1
X-PR-Tracked-Commit-Id: 987cf300e76d30b1bdad88d2a662b948ead6fb21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a01fe7ec42b7fcd4201084dc56a2372f7b101f99
Message-Id: <165429295245.7657.13685756925840920591.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 21:49:12 +0000
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 12:47:02 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.19-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a01fe7ec42b7fcd4201084dc56a2372f7b101f99

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
