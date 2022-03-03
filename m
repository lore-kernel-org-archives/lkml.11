Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4045C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 11:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiCCLbK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Mar 2022 06:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiCCLbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B009F1795FE;
        Thu,  3 Mar 2022 03:30:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FEE860F5A;
        Thu,  3 Mar 2022 11:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39626C34106;
        Thu,  3 Mar 2022 11:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646307015;
        bh=jnrle6jJxiHm+6f07oky9Uxo0yIL90UlMOyvDaWTzS8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jbkPaee8wUakiJk4dpjV1G2FkCC0xQOXRFFKk5QQL7YmBfloakCZgY4knJwGkbwoG
         /24NyOtQU2G/8bfVcToUAalLdCXDYmOvWTxdKrKaDXt2apT3TR9Gex0FVgMMjs5b27
         t4bBRXvOcoSghuLM29FG2GjptwF8r6oPQfXh2gLHw0nke9by06k6pfoAXuk0M4Mo0r
         nvMoUOhGjkEwcEQvsXvTO2Gv3lIzS+iUSsUShI4OYgOCEm7k+HnBm/aazZTSvQwRC7
         56SOHRsnizsZLbKaTJR7xkhPwkTaJe/8esxD1Ye4WT5PF3X+0LQrHU/h46LpwShkhO
         tzcn80gAJNHHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4612E7BB08;
        Thu,  3 Mar 2022 11:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v2 0/6] nfc: llcp: few cleanups/improvements
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164630701493.19662.16097017593505369271.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Mar 2022 11:30:14 +0000
References: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220302192523.57444-1-krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed,  2 Mar 2022 20:25:17 +0100 you wrote:
> Hi,
> 
> These are improvements, not fixing any experienced issue, just looking correct
> to me from the code point of view.
> 
> Changes since v1
> ================
> 1. Split from the fix.
> 
> [...]

Here is the summary with links:
  - [RESEND,v2,1/6] nfc: llcp: nullify llcp_sock->dev on connect() error paths
    https://git.kernel.org/netdev/net-next/c/13a3585b264b
  - [RESEND,v2,2/6] nfc: llcp: simplify llcp_sock_connect() error paths
    https://git.kernel.org/netdev/net-next/c/ec10fd154d93
  - [RESEND,v2,3/6] nfc: llcp: use centralized exiting of bind on errors
    https://git.kernel.org/netdev/net-next/c/4dbbf673f7d7
  - [RESEND,v2,4/6] nfc: llcp: use test_bit()
    https://git.kernel.org/netdev/net-next/c/a736491239f4
  - [RESEND,v2,5/6] nfc: llcp: protect nfc_llcp_sock_unlink() calls
    https://git.kernel.org/netdev/net-next/c/a06b8044169f
  - [RESEND,v2,6/6] nfc: llcp: Revert "NFC: Keep socket alive until the DISC PDU is actually sent"
    https://git.kernel.org/netdev/net-next/c/44cd5765495b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


