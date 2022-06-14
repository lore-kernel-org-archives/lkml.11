Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6B2C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 07:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353264AbiFNHKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353130AbiFNHKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:10:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BEE3B546;
        Tue, 14 Jun 2022 00:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25382B817AF;
        Tue, 14 Jun 2022 07:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4268C3411E;
        Tue, 14 Jun 2022 07:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655190612;
        bh=dmLK/nv/5tU6QIzmumMJ4+PJxQGt6Fs+tQ8YqCoef9s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FqEpGazLYG99s1qJxLIHyH4zTvbzTDn059Jh0jCEFv+ZaBJ2xpavrA85h6p4lH2DA
         knaQNUZjB2Iv5epJQMt9Gm1gL6islj4pW++kmBjKKKpXx8CjJOirLEi55Ri6tHkRMs
         pKRI51E/dzXk8MXj8XXbdddQKIMOdADMAWEkqcNSsbMq+/XJlVwhG/z3r0n10y8Pug
         enuWSk7H4NfL8gdALQAHgW6ICSKaoVLvHuswp0hh1PXmOVcipOit95WEb8oLMgkVQq
         4JxfppspLPpcpI/LpdmOZlEUhw9CLl/DKPnp5ngOpNItN55niGyrSUZbjSb3T8pL/0
         3l72SkyBm2Tdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A88F3FD99FF;
        Tue, 14 Jun 2022 07:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] platform/chrome: Fix spelling mistake "unknwon" ->
 "unknown"
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165519061268.15395.1045812031095952804.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 07:10:12 +0000
References: <20220614064909.47804-1-colin.i.king@gmail.com>
In-Reply-To: <20220614064909.47804-1-colin.i.king@gmail.com>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 14 Jun 2022 07:49:09 +0100 you wrote:
> There is a spelling mistake in a dev_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/platform/chrome/cros_ec_proto.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [next] platform/chrome: Fix spelling mistake "unknwon" -> "unknown"
    https://git.kernel.org/chrome-platform/c/203b2aff4786

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


