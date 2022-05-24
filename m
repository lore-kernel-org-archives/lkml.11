Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478ACC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 00:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbiEXAuS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 20:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiEXAuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 20:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B670D7C153
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 17:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D597615A7
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 00:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D17DC36AE3;
        Tue, 24 May 2022 00:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653353412;
        bh=q+4XuDYRYjXM+ddv/G67liUYwdhEEPIpIxaOB/s9ggg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=l1ilgWcjBpcPDzJBL0Se68C4bjdAlcZQD0fpABTAETSMvq2WjG31BxwuxG0XkeRZF
         5D2jgHQ8NKt3CTMwShRF4nnCgQ8duB6QZp45P2PMm0nbsdjN0eO7/0rmWrGeDbWJsj
         InLn5drVWOXIU8/m7AzAS60bifI48wwJIu+lrI/BS/K0zTSlQMLr+u4f28zZfFLsTN
         M6ANUNzrgSPMOe4B0BsCja7Wi22VoOjO0u1iqtNvVJlfcEDlB8//t+nXSgbvzEzvJN
         myhZw0DQgdOpnaYUmKQygXSUgPupHhQ7gRM+1JVCDCCAG0dWpOM6M1sDYQP+aYnWXp
         mygBJkvv/5duA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81FACF03938;
        Tue, 24 May 2022 00:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] platform/chrome: cros_ec_proto: add initial Kunit tests
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165335341252.17704.18068101076229868652.git-patchwork-notify@kernel.org>
Date:   Tue, 24 May 2022 00:50:12 +0000
References: <20220518091814.2028579-1-tzungbi@kernel.org>
In-Reply-To: <20220518091814.2028579-1-tzungbi@kernel.org>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dianders@chromium.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed, 18 May 2022 17:18:10 +0800 you wrote:
> The series adds some early Kunit tests for ChromeOS EC protocol.
> 
> The 2nd patch is a refactor.
> 
> The 3rd patch updates code comment.
> 
> The 1st and 4th patches add Kunit tests.
> 
> [...]

Here is the summary with links:
  - [1/4] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_prepare_tx()
    https://git.kernel.org/chrome-platform/c/c185ba01c945
  - [2/4] platform/chrome: cros_ec_proto: factor legacy out from cros_ec_prepare_tx()
    https://git.kernel.org/chrome-platform/c/103c883f4ace
  - [3/4] platform/chrome: cros_ec_proto: update cros_ec_check_result() comment
    https://git.kernel.org/chrome-platform/c/3cd0cacd4b64
  - [4/4] platform/chrome: cros_ec_proto: add Kunit tests for cros_ec_check_result()
    https://git.kernel.org/chrome-platform/c/3c470e42dd47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


