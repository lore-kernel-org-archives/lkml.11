Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37F2C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 08:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbiFNIUS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 04:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbiFNIUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:20:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEFE40E4E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DEDD6147F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B945C3411B;
        Tue, 14 Jun 2022 08:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655194813;
        bh=8MsNyz+yGakuP3pzPHffPGmJE0ToLHr30QsOg7vXY2Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mzHMPLVwayVfkeCnBje6+v3ta/o1SmwQvMoS5uaKdZyjQsRLVvjwn0wGsQcntAEpp
         mZZL/19d/BC8MGBgs1qX0b8F5bg7EXC7pUb9y0jvUAF0kQ2nwAaf0vEKjnz0+lr68+
         skgG5qW5RFne+xUtZKl4yBx+VEB7pOjY/my/KFNBnSAuXw/I0097kpJlFqKOTP+7yb
         03AofCZuy835X6RGfccPsGXlBK9nAO2u/YzX2zsZSxO9BUHBWYN1QIloSp8NcQOfce
         W9AExj7H8yShPhUaKjoqUlEsnYmNIXsE7czYIifck9EFIlXOyOshl3f0UjbYD25vtJ
         /jT+3BwI4LBTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56678E6D482;
        Tue, 14 Jun 2022 08:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] platform/chrome: cros_ec: Always expose last resume result
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <165519481335.20230.14481630033176207455.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 08:20:13 +0000
References: <20220614075726.2729987-1-swboyd@chromium.org>
In-Reply-To: <20220614075726.2729987-1-swboyd@chromium.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     bleung@chromium.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, groeck@chromium.org,
        chrome-platform@lists.linux.dev, rajatja@chromium.org,
        mka@chromium.org, hsinyi@chromium.org, tzungbi@kernel.org,
        evgreen@chromium.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Tue, 14 Jun 2022 00:57:26 -0700 you wrote:
> The last resume result exposing logic in cros_ec_sleep_event()
> incorrectly requires S0ix support, which doesn't work on ARM based
> systems where S0ix doesn't exist. That's because cros_ec_sleep_event()
> only reports the last resume result when the EC indicates the last sleep
> event was an S0ix resume. On ARM systems, the last sleep event is always
> S3 resume, but the EC can still detect sleep hang events in case some
> other part of the AP is blocking sleep.
> 
> [...]

Here is the summary with links:
  - [v3] platform/chrome: cros_ec: Always expose last resume result
    https://git.kernel.org/chrome-platform/c/74bb746407bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


