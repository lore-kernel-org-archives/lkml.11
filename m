Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105C1C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 17 May 2022 10:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344082AbiEQKXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 May 2022 06:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344777AbiEQKV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4874BFC5;
        Tue, 17 May 2022 03:20:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4538A61618;
        Tue, 17 May 2022 10:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A053EC34100;
        Tue, 17 May 2022 10:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652782811;
        bh=BUD4r1MMf7bLNfrk0SfAHleGlJ8FC5DwoTAhxrlUJpQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=loZWEGCt+kdC/FCtOKp/12uCTC4RkozlzZE+OLZDj0spGT0333iwYpgzRntfmsJjS
         H6NbzvmWwtVAOthYJe5G8YhvQRrifLffDkZEBG3IHzgrp/VPkuuGKWTeS7pwaE9wyE
         qgdi9sIf17HTqBH2pAum5MEJv+qlC1ZzScZir1PrbkBj35XqGMsKKAW4SAHkMCjJJN
         +m4f2bnCVWIECmViptfuh+uy1x0PSdmQHoapUYe9GDFkasa0lcyTUAV3SmA7mLFr8h
         1CRxUx/x/s5eVENSu46nUdE/mvocrjcdRIbuj4clvntRqCPOnZ5fSgAeyElk5PLSQv
         uUI4ZQTAjDkdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85012F0389D;
        Tue, 17 May 2022 10:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: vmxnet3: fix possible NULL pointer dereference in
 vmxnet3_rq_cleanup()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165278281154.16356.16285033174782177161.git-patchwork-notify@kernel.org>
Date:   Tue, 17 May 2022 10:20:11 +0000
References: <20220514050711.2636709-1-r33s3n6@gmail.com>
In-Reply-To: <20220514050711.2636709-1-r33s3n6@gmail.com>
To:     Zixuan Fu <r33s3n6@gmail.com>
Cc:     doshir@vmware.com, pv-drivers@vmware.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        baijiaju1990@gmail.com, oslab@tsinghua.edu.cn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 14 May 2022 13:07:11 +0800 you wrote:
> In vmxnet3_rq_create(), when dma_alloc_coherent() fails,
> vmxnet3_rq_destroy() is called. It sets rq->rx_ring[i].base to NULL. Then
> vmxnet3_rq_create() returns an error to its callers mxnet3_rq_create_all()
> -> vmxnet3_change_mtu(). Then vmxnet3_change_mtu() calls
> vmxnet3_force_close() -> dev_close() in error handling code. And the driver
> calls vmxnet3_close() -> vmxnet3_quiesce_dev() -> vmxnet3_rq_cleanup_all()
> -> vmxnet3_rq_cleanup(). In vmxnet3_rq_cleanup(),
> rq->rx_ring[ring_idx].base is accessed, but this variable is NULL, causing
> a NULL pointer dereference.
> 
> [...]

Here is the summary with links:
  - [v3] net: vmxnet3: fix possible NULL pointer dereference in vmxnet3_rq_cleanup()
    https://git.kernel.org/netdev/net/c/edf410cb74dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


