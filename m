Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA58C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 00:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836842AbiDFAkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 20:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359011AbiDELRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:17:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5A8AD118;
        Tue,  5 Apr 2022 03:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C6DEECE1CAC;
        Tue,  5 Apr 2022 10:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E845C385B5;
        Tue,  5 Apr 2022 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649155811;
        bh=uhc8Mlmd78pDEdVosg25RAR+DdaTCNKDnxuM3nRitqw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QIhnGmFojr4ml3n9dwy4WrYyN4OSyOOn+QhMMGvsj6T3yGOpwnaCN893cBn8NETwb
         26KRF5YhoYiD4BTg153rL43CQz6TP8jXlT390biCwaSLgb+LUNE/btinZdrshgvy1n
         eTI/gypYWT15+dkGnn5AW2ormaahDTc2oM8HN5IvqAZwKvscAXRH2lwASkcGYm0H2t
         AmaAROjraCapSVgSV6LcuOxgziCWTXkIVNUPPJJ4u9HEfhZ7bFRE9+mLSTaZGcurSI
         1JQRGADYVvqC1mObMFNaRT7Abcmu81JF7RYyzOeI4uuGZGBVeutjOJDDPadkAa1aaZ
         IYKzFK9ISBYbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12FACE85BCB;
        Tue,  5 Apr 2022 10:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dpaa2-ptp: Fix refcount leak in dpaa2_ptp_probe
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164915581107.22283.18195294133753582239.git-patchwork-notify@kernel.org>
Date:   Tue, 05 Apr 2022 10:50:11 +0000
References: <20220404125336.13427-1-linmq006@gmail.com>
In-Reply-To: <20220404125336.13427-1-linmq006@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     yangbo.lu@nxp.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Apr 2022 12:53:36 +0000 you wrote:
> This node pointer is returned by of_find_compatible_node() with
> refcount incremented. Calling of_node_put() to aovid the refcount leak.
> 
> Fixes: d346c9e86d86 ("dpaa2-ptp: reuse ptp_qoriq driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - dpaa2-ptp: Fix refcount leak in dpaa2_ptp_probe
    https://git.kernel.org/netdev/net/c/2b04bd4f03bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


