Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCABC32796
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 02:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiHXCUU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 22:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiHXCUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 22:20:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93112861FB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 19:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D06617D2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 02:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8204AC433B5;
        Wed, 24 Aug 2022 02:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661307615;
        bh=A6IhjA/h9CqERUMVffhQMBceArkI0bSRI9qQCZos+Ww=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Wn1N+zYqgOFtVVK23TPWx2Em4pi+SmKLQdjveeGNRBuGGdyZm6kOvpi2kWt4nt5dM
         Ju3TN+52FCpPNuR77NivHBBeAUfmsBNWAytaRAmuEzVq6mYigi/p/zhoFhIVG0JKYJ
         y9bfr8iZzQdVEJ/AdkYYwStLvneKPnRlQ9zAU6srZNc9UJIJhGmRYbnzG5ZbXZjfXV
         XLkifnbhSMv9i5XpsL27OY2nxIEUPxsvFjUZ/eTOjH6sTv7qHkYYg/gjTcUjrBbodz
         ZqFVadpwIXlhaDbCZcVfz/O+xHRK/LY0CCLCyvgS9gxj5wEYxow0avbxrrBoLcYcYM
         /upt8oW1zirNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6473BC0C3EC;
        Wed, 24 Aug 2022 02:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] platform/chrome: fix double-free in chromeos_laptop_prepare()
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <166130761540.28253.2501419238988992082.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Aug 2022 02:20:15 +0000
References: <20220813220843.2373004-1-subkhankulov@ispras.ru>
In-Reply-To: <20220813220843.2373004-1-subkhankulov@ispras.ru>
To:     Rustam Subkhankulov <subkhankulov@ispras.ru>
Cc:     bleung@chromium.org, dmitry.torokhov@gmail.com,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        khoroshilov@ispras.ru, ldv-project@linuxtesting.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Sun, 14 Aug 2022 01:08:43 +0300 you wrote:
> If chromeos_laptop_prepare_i2c_peripherals() fails after allocating memory
> for 'cros_laptop->i2c_peripherals', this memory is freed at 'err_out' label
> and nonzero value is returned. Then chromeos_laptop_destroy() is called,
> resulting in double-free error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - platform/chrome: fix double-free in chromeos_laptop_prepare()
    https://git.kernel.org/chrome-platform/c/6ad4194d6a1e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


