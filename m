Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F8DECAAD5
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 22:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiHaWAb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Aug 2022 18:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiHaWAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 18:00:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB56DAEE;
        Wed, 31 Aug 2022 15:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F42ACE2371;
        Wed, 31 Aug 2022 22:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19728C433B5;
        Wed, 31 Aug 2022 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661983217;
        bh=D2hckKTWv4BB2ko/rlSdTwsjSj88gseeyvmPpsyYjY4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OBDpf6NekLJPoBGwSFts/vCEIXfXQ+t8afU++8QV+ZM6wMapDpgV/55jr8/umjNNz
         nwdZdc0tuQ0UjsNOFU6npmuI7XiByTI/lSL/SPGw4p1TjDgWE5LwspHiPBUfKNB0nr
         3xC/orlQ5jyxKie1tcQfIpu/j90SBA/4bVby/4ewxGvGhke7Qa5J3/YaJd4iQjgvwa
         95n4Mz44YO96Lpcw+NAJy5IseI13V71GbgvX+bBs5HascffJOiIDsVWOYXJ1mgRlns
         Z/g5dI6rCHcqE2bGuJKH3o8m8YEql71KpYjN42Ps8b1hCA3YLQN9YsFTxLbg6cOoGo
         +nhqd2DFaWmxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0259CE924D6;
        Wed, 31 Aug 2022 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] r8152: allow userland to disable multicast
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166198321700.20200.2886724035407277786.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 22:00:17 +0000
References: <20220830045923.net-next.v1.1.I4fee0ac057083d4f848caf0fa3a9fd466fc374a0@changeid>
In-Reply-To: <20220830045923.net-next.v1.1.I4fee0ac057083d4f848caf0fa3a9fd466fc374a0@changeid>
To:     Sven van Ashbrook <svenva@chromium.org>
Cc:     linux-kernel@vger.kernel.org, levinale@google.com,
        chithraa@google.com, frankgor@google.com, aaron.ma@canonical.com,
        dober6023@gmail.com, davem@davemloft.net, edumazet@google.com,
        chenhao288@hisilicon.com, hayeswang@realtek.com, kuba@kernel.org,
        jflf_kernel@gmx.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Aug 2022 04:59:39 +0000 you wrote:
> The rtl8152 driver does not disable multicasting when userspace asks
> it to. For example:
>  $ ifconfig eth0 -multicast -allmulti
>  $ tcpdump -p -i eth0  # will still capture multicast frames
> 
> Fix by clearing the device multicast filter table when multicast and
> allmulti are both unset.
> 
> [...]

Here is the summary with links:
  - [net-next,v1] r8152: allow userland to disable multicast
    https://git.kernel.org/netdev/net-next/c/7305b78ae45f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


