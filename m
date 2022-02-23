Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7541BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Feb 2022 13:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbiBWNUm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:20:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240851AbiBWNUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:20:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA0AA02B;
        Wed, 23 Feb 2022 05:20:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3044B6153D;
        Wed, 23 Feb 2022 13:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A385C340F1;
        Wed, 23 Feb 2022 13:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645622411;
        bh=4MINalVsLypM4gQLR9Y0Ac8CSDvIEk7Or3pxAcAHrp8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HV3GKjiAoVKlfbobREUE3hGsHRDqzsmzlyL6o5mMSqbKX6IyY79VoWM3Qzs1adTt+
         LkM9R6Je7Nngy4QtNvhmvT6T7pNjV5Dy4/br1Sg3OxHES0FDEi37iLWe5U1nTm1A0g
         Fk+uWWn9uekrNHdyn3fqu17941JuiD0iZkpinXQipSKRkRk4EeTGTutow0eYKGip7Y
         Dttc+6C2xKBF1iq4wZWEaEQblmDcmje7g+sbNmyYkyNYfZbA3fhsoC2SMGwMAwXJJU
         PAx/RmL186qNt6pJUJvaSyI6CxDPgyimzTNvhDJLNHD1WnNdDOJ1fIGB3BLxn1xkAo
         XQ3XQgDRzy7Jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78F24E6D598;
        Wed, 23 Feb 2022 13:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] drivers/net/ftgmac100: fix occasional DHCP failure
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164562241149.17147.7259955928729255752.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Feb 2022 13:20:11 +0000
References: <20220223031436.124858-1-guoheyi@linux.alibaba.com>
In-Reply-To: <20220223031436.124858-1-guoheyi@linux.alibaba.com>
To:     Heyi Guo <guoheyi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
        kuba@kernel.org, joel@jms.id.au, huangguangbin2@huawei.com,
        chenhao288@hisilicon.com, arnd@arndb.de, dylan_hung@aspeedtech.com,
        netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed, 23 Feb 2022 11:14:33 +0800 you wrote:
> This patch set is to fix the issues discussed in the mail thread:
> https://lore.kernel.org/netdev/51f5b7a7-330f-6b3c-253d-10e45cdb6805@linux.alibaba.com/
> and follows the advice from Andrew Lunn.
> 
> The first 2 patches refactors the code to enable adjust_link calling reset
> function directly.
> 
> [...]

Here is the summary with links:
  - [1/3] drivers/net/ftgmac100: refactor ftgmac100_reset_task to enable direct function call
    https://git.kernel.org/netdev/net/c/4f1e72850d45
  - [2/3] drivers/net/ftgmac100: adjust code place for function call dependency
    https://git.kernel.org/netdev/net/c/3c773dba8182
  - [3/3] drivers/net/ftgmac100: fix DHCP potential failure with systemd
    https://git.kernel.org/netdev/net/c/1baf2e50e48f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


