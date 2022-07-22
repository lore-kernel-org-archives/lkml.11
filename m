Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EBE0C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 00:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbiGVAUU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 20:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVAUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 20:20:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B560767C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 17:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33CB2B826C1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 00:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D01C1C341C6;
        Fri, 22 Jul 2022 00:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658449213;
        bh=X8kbnXGpRXGFbOgAN4Wdoo6ID5fpTUuvBBGcH0b9Fbk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=thCkp2iBx7BJd3MhJSSgGs1yseXS1E0luD8jsI6QQJSKV9HdcyV1evTxC+6c1mKDR
         BqdpNEyJyGn+2H5U5B7tscchFXvseHqjVAxRFJn5/5oJvZtjm9eLyLmMHcrWS/BcD/
         ErWoOjg4gByfPGLTVkYHBEvg4PiS6kkfYq+JSLpf6oqGQ0tLWfx9smG1bKcnORdIhR
         vpDxyQG50eG6hYjwbJGcOxp7t41pjOduVPghzYopKngOTG87VKfPGawYIALQhbju+o
         U7mQlEgPQaoi5Ajl27Lz5eIDErUu0UThURtQAEpawxyCRxVbsHOaDBjZ2cNJmMbAsK
         DWt1hXhtJ3ylw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9172E451BA;
        Fri, 22 Jul 2022 00:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] platform/chrome: avoid garbage bytes in `msg->result`
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165844921368.22481.15292709192153390595.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 00:20:13 +0000
References: <20220720044754.4026295-1-tzungbi@kernel.org>
In-Reply-To: <20220720044754.4026295-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 20 Jul 2022 04:47:52 +0000 you wrote:
> The 1st patch merges Kunit utils and test cases.  The idea is basically from
> the review comment in [1].
> 
> The 2nd patch fixes that `msg->result` would be garbage bytes if the mock list
> is empty.  This is separated from previous series [2].
> 
> [1]: https://patchwork.kernel.org/project/chrome-platform/patch/20220718050914.2267370-2-tzungbi@kernel.org/#24944149
> [2]: https://patchwork.kernel.org/project/chrome-platform/patch/20220718050914.2267370-2-tzungbi@kernel.org/
> 
> [...]

Here is the summary with links:
  - [1/2] platform/chrome: merge Kunit utils and test cases
    https://git.kernel.org/chrome-platform/c/f92dd1475b06
  - [2/2] platform/chrome: cros_kunit_util: add default value for `msg->result`
    https://git.kernel.org/chrome-platform/c/afef1e1a0223

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


