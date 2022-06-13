Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139ADC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 17:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236265AbiFMRt1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 13:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242906AbiFMRsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:48:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E9C3CA6A;
        Mon, 13 Jun 2022 06:30:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC783612D5;
        Mon, 13 Jun 2022 13:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A11EC3411B;
        Mon, 13 Jun 2022 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655127021;
        bh=3owKJmN+C3KrJEir3DsRctBw54DfOoSMlpRJuhdRiu4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kxGF1j+eI+5kQ9AwgEWJQbIMyKWMkuWMh2YymfsxLeoUcyHSfh+u9NaCjsZW5Ci27
         vTsJYsAU/bj5451JRBoiCIZY66di1Q7BS3fcpqI1qf+L14TbWqYWroAS+JnbNP6p4e
         uVnxGIRT3PO02aIGBewc+ipWcchbuoF4KC6L3GCg4kZ97nqXH0hjrsyj7n3atE4uAM
         QwoDlKRynboAxbw6gmIFCLp85vsf59Y0Vsx0u8kkqPOHvKxoUOuZ1PhF+DxRJGR15I
         w8W2Sc08wUbogEwgW9COSZFjWJkJKBxfWao4czQMmNyiu3wRuj/2ilOGB301DjKyza
         AwSOUq9BPr1qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 01FD217A1CBC;
        Mon, 13 Jun 2022 13:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: make __sys_accept4_file() static
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165512702100.2444.14881268183989098998.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Jun 2022 13:30:21 +0000
References: <20220610091017.1991892-1-yajun.deng@linux.dev>
In-Reply-To: <20220610091017.1991892-1-yajun.deng@linux.dev>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 10 Jun 2022 17:10:17 +0800 you wrote:
> __sys_accept4_file() isn't used outside of the file, make it static.
> 
> As the same time, move file_flags and nofile parameters into
> __sys_accept4_file().
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] net: make __sys_accept4_file() static
    https://git.kernel.org/netdev/net-next/c/c04245328dd7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


