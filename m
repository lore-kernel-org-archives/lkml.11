Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D784C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 00:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiCVADG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiCVADB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 20:03:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA584B410;
        Mon, 21 Mar 2022 17:00:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2CE35B81AD0;
        Tue, 22 Mar 2022 00:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5480C340F0;
        Tue, 22 Mar 2022 00:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647907210;
        bh=7mbnWhk2gsDvVNZ3Wk1nPfvu+lgkukTfJP6wkI3XKXc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u3BBCmsiv8fqWpc8tMo4CTu5KuyH2c/dsGx5RFw2cOOkxSdJfaPv9cBjoC9TrjTly
         6uKmgS6hZldcOZv6cOrHwa2T+Z4yi+cfwiSAfloSeVPfhE+gFpvdD3Cn5zhXgUNx5+
         F89mFpR0bbHnLW8P9BL7DcGABgZFmCDlP0bM1FLKPZz3uow4/ye7uJiif3MXzKbYSR
         Zejjf5SPUFXnpE1WHLJLmXu7CENP3k39X5jgoPLkOljrORhDDQJm7CnbQ058Z+SNvA
         TC+PqIZxIBKoqks7OU1c+4iwG/QVn2giSRLlDUvybrQFYGI4knmKDxkVMvgebwxe1A
         3wEWL4XOpKlyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3349EAC096;
        Tue, 22 Mar 2022 00:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: mv88e6xxx: Fill in STU support for all
 supported chips
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164790721066.15202.17830576160916908515.git-patchwork-notify@kernel.org>
Date:   Tue, 22 Mar 2022 00:00:10 +0000
References: <20220319110345.555270-1-tobias@waldekranz.com>
In-Reply-To: <20220319110345.555270-1-tobias@waldekranz.com>
To:     Tobias Waldekranz <tobias@waldekranz.com>
Cc:     davem@davemloft.net, kuba@kernel.org, kabel@kernel.org,
        andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, pabeni@redhat.com, linux@armlinux.org.uk,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 19 Mar 2022 12:03:45 +0100 you wrote:
> Some chips using the split VTU/STU design will not accept VTU entries
> who's SID points to an invalid STU entry. Therefore, mark all those
> chips with either the mv88e6352_g1_stu_* or mv88e6390_g1_stu_* ops as
> appropriate.
> 
> Notably, chips for the Opal Plus (6085/6097) era seem to use a
> different implementation than those from Agate (6352) and onwards,
> even though their external interface is the same. The former happily
> accepts VTU entries referencing invalid STU entries, while the latter
> does not.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: mv88e6xxx: Fill in STU support for all supported chips
    https://git.kernel.org/netdev/net-next/c/c050f5e91b47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


