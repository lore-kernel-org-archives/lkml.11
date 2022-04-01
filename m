Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A39C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Apr 2022 11:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbiDALCE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 07:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiDALCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 07:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D40CE887B;
        Fri,  1 Apr 2022 04:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D1561876;
        Fri,  1 Apr 2022 11:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 043E3C3410F;
        Fri,  1 Apr 2022 11:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648810812;
        bh=mAFyZ7sYanbUgNiILCWfapJOiBZueRKvASrfCV1bhx0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M9xQByThkCBTQoxnFaRFJwG6OKnQrKUnm3dV4EOcVaxsx5A1dB2AK5X0Pt9QpZExX
         eoNZVcgRo0WJpmDQvYYuwfwJnE4EAlDpioYDgGO0LF+ZdUfj4tp3q6UuiAR6Vcitq4
         e7/p9bTX+R1c/u0ne0LJyrqCaJh/xkTPLlW2ZGJTBzRESQa+PDcidZuPeI67h1p3Zj
         nigBy6IH18N7QHGrwUwJxRo6/DfhyPY2MEPNRTu25PECOoKTnKISa+tyuOnwDr3Xbv
         XnPL+1fhHNkG8fMDGiXtq8sdws/po6VapV944J6zck+uS2ySu3Toj0O/PQjEh4mEEw
         vCHt9TVjBokfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAD73F0384B;
        Fri,  1 Apr 2022 11:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/tls: fix slab-out-of-bounds bug in
 decrypt_internal
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164881081189.13357.4560664989806441504.git-patchwork-notify@kernel.org>
Date:   Fri, 01 Apr 2022 11:00:11 +0000
References: <20220331070428.36111-1-william.xuanziyang@huawei.com>
In-Reply-To: <20220331070428.36111-1-william.xuanziyang@huawei.com>
To:     Ziyang Xuan <william.xuanziyang@huawei.com>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, daniel@iogearbox.net,
        kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
        netdev@vger.kernel.org, vakul.garg@nxp.com, davejwatson@fb.com,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 31 Mar 2022 15:04:28 +0800 you wrote:
> The memory size of tls_ctx->rx.iv for AES128-CCM is 12 setting in
> tls_set_sw_offload(). The return value of crypto_aead_ivsize()
> for "ccm(aes)" is 16. So memcpy() require 16 bytes from 12 bytes
> memory space will trigger slab-out-of-bounds bug as following:
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in decrypt_internal+0x385/0xc40 [tls]
> Read of size 16 at addr ffff888114e84e60 by task tls/10911
> 
> [...]

Here is the summary with links:
  - [net,v2] net/tls: fix slab-out-of-bounds bug in decrypt_internal
    https://git.kernel.org/netdev/net/c/9381fe8c849c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


