Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF2C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Mar 2022 12:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbiCEMLD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Mar 2022 07:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiCEMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:11:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395440E51;
        Sat,  5 Mar 2022 04:10:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B787DB80BE7;
        Sat,  5 Mar 2022 12:10:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80BF2C340F1;
        Sat,  5 Mar 2022 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646482209;
        bh=POlbJ+3a+0ccS7uKBAWFPqA5GXG9dgf0YBx1qQKxGzM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DZY+59sp7fffH6fhjfe6Sx8Ae95LTXMiWduV+06/ey2DcQAu5N0o4oLPMiPrsd8w5
         7X6DwClq5TkO7nzdfLH8twDsvwxlNO2Z4Sg1ZcS6R23CkP/2bOP70gfJoDF3owOvjX
         6+JqzEw0F/pa3SykM4YudRV8ecFdb0NVdurBtWD10oNc5fuTZIXDxEf4XHw+lEyI66
         4+WTmo5WOcfheusU2KketcowtGhIWHGPtEYdH5VbVYazgeacvFZlTmBdT9uoJjEaQ8
         7ZQS9bpi/0qj/+MjzQMJgM4yX183GVPv/NRU/hlDaEpJNNnZGlqeV1+j+cOvDyAn1E
         shJ7sIli90Ngw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68076EAC095;
        Sat,  5 Mar 2022 12:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mISDN: Fix memory leak in dsp_pipeline_build()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164648220942.4612.11657656133766874161.git-patchwork-notify@kernel.org>
Date:   Sat, 05 Mar 2022 12:10:09 +0000
References: <1646418336-12115-1-git-send-email-khoroshilov@ispras.ru>
In-Reply-To: <1646418336-12115-1-git-send-email-khoroshilov@ispras.ru>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri,  4 Mar 2022 21:25:36 +0300 you wrote:
> dsp_pipeline_build() allocates dup pointer by kstrdup(cfg),
> but then it updates dup variable by strsep(&dup, "|").
> As a result when it calls kfree(dup), the dup variable contains NULL.
> 
> Found by Linux Driver Verification project (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Fixes: 960366cf8dbb ("Add mISDN DSP")
> 
> [...]

Here is the summary with links:
  - mISDN: Fix memory leak in dsp_pipeline_build()
    https://git.kernel.org/netdev/net/c/c6a502c22999

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


