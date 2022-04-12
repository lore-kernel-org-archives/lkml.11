Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 402EAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 04:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344632AbiDLEDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 00:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239821AbiDLECd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:02:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B02DD72;
        Mon, 11 Apr 2022 21:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83412B81B14;
        Tue, 12 Apr 2022 04:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 267D1C385AE;
        Tue, 12 Apr 2022 04:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649736015;
        bh=34Ml6GzHkj3zF6xanNUVROhywpBQ0j8Ex47ZQ60nfSM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=W1CNhPWJI82u3kxt3ANsWQG/V0eR/Dio/ClKBz1hrLZMnRddgpRpC25BR7ia4SrjN
         OC62XrjJsZcqCfU5+vBQjhJ7ubpgH6BJQ9PIQ0x9eh1tMpbJ4oWUVZEpL2sqvqVkvP
         HziM1hKBdV2/AXVXbaNwo47C92PpNgaHIlWPjLl21PLkn2BubZKo8cvgvbqswAiso9
         PQCeIH3DKIyLDa03iZxTCRziRNXkYlYE4JIgHUYM3iAtYviPlfRDD2rW9ANIL6hJyK
         GseXEBlTko9GOVmCMi/1brKa8N0nMZMs1DgN5Q6YZjg2qyAc1EmVkXd+kSnz84LtGC
         Fok4wV9dNoqyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 09A2FE8DBD1;
        Tue, 12 Apr 2022 04:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] sfc: ef10: Fix assigning negative value to unsigned
 variable
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164973601503.30868.3317524742602882068.git-patchwork-notify@kernel.org>
Date:   Tue, 12 Apr 2022 04:00:15 +0000
References: <1649640757-30041-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1649640757-30041-1-git-send-email-baihaowen@meizu.com>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Apr 2022 09:32:37 +0800 you wrote:
> fix warning reported by smatch:
> 251 drivers/net/ethernet/sfc/ef10.c:2259 efx_ef10_tx_tso_desc()
> warn: assigning (-208) to unsigned variable 'ip_tot_len'
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: to assign "0x10000 - EFX_TSO2_MAX_HDRLEN" is the actual
> semantics of the value.
> 
> [...]

Here is the summary with links:
  - [V2] sfc: ef10: Fix assigning negative value to unsigned variable
    https://git.kernel.org/netdev/net-next/c/b8ff3395fbdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


