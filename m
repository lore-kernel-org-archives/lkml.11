Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51619C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 07:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240328AbiDNHct (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 03:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240346AbiDNHci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:32:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4DC338AF;
        Thu, 14 Apr 2022 00:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBA5DB8289B;
        Thu, 14 Apr 2022 07:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 700FCC385A7;
        Thu, 14 Apr 2022 07:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649921411;
        bh=OuNLvEJ8aXMqTJPv7jVEIV7+W6+riGS+XbsjZV8uTL4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GZ8nxhM0UxgDVBIo3qzVBxVKyFF9gnn+e+BtnrxoGHZIoRNAsgvqY2SrxJsQOFNOr
         CtYG2oWUFMqyAE1y1amWltHFJdh/8bdSOePY9eChLAKlLIqUx7iL/rM8J3qXig3mCK
         3FAlGAHUtjadULG0IGTDZ8E9ZI2l+OwHuU9QkIdQXEV2GBQKM1QFBmPFCEyUrRUjmX
         T47NVwWAeED/qUhd4bAuVpbEe74IknXXNGq4b1tc4cXRX7gKTX9UhkL0e17VUVhjcZ
         zq6tnHfPBYvCqrbeE2pzIRhmnnT701upwXYi2BCDXD68OwdCMxydi5xeeRzzFw6prh
         g9mL9wbdewrkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 511ABE85D15;
        Thu, 14 Apr 2022 07:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: bcmgenet: Revert "Use stronger register read/writes to
 assure ordering"
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164992141132.21485.14435114290874521938.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Apr 2022 07:30:11 +0000
References: <20220412210420.1129430-1-jeremy.linton@arm.com>
In-Reply-To: <20220412210420.1129430-1-jeremy.linton@arm.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     netdev@vger.kernel.org, opendmb@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        pbrobinson@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 12 Apr 2022 16:04:20 -0500 you wrote:
> It turns out after digging deeper into this bug, that it was being
> triggered by GCC12 failing to call the bcmgenet_enable_dma()
> routine. Given that a gcc12 fix has been merged [1] and the genet
> driver now works properly when built with gcc12, this commit should
> be reverted.
> 
> [1]
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105160
> https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=aabb9a261ef060cf24fd626713f1d7d9df81aa57
> 
> [...]

Here is the summary with links:
  - net: bcmgenet: Revert "Use stronger register read/writes to assure ordering"
    https://git.kernel.org/netdev/net/c/2df3fc4a84e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


