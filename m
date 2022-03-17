Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1264C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 12:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233629AbiCQMlb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 08:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233620AbiCQMla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 08:41:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4111E95D6;
        Thu, 17 Mar 2022 05:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1D2DB81E86;
        Thu, 17 Mar 2022 12:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D985C340ED;
        Thu, 17 Mar 2022 12:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647520810;
        bh=VTMMpw0s+cXz9DTBEHX6o/Y+VT1YN7uXrMm1FmMVLtY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=e/CEWHiJp1j19M22+rzCdjGIY7YwKmzbWhG9eo3WH/vun/UEjo6d9lZdsnxKio+Fo
         CVpTbXBoQCsJTu7U1es6tzqsXLjmr0A172igY94NI+RJ/QEHyHsNmCMFddvcElprkr
         OkLFdaVIJavk6dZD7ePyVkeJtcCJx1gnHg2akif/8amv7yxkc2DIg+5z773gdj+CQi
         Id2DUzGBHnnPvJKseYcxBukfv693vL6m7U0aL/j0613QrbjO82UfLV4wNyscPE1Wys
         tXB2POhLJlSs7xItq80Wpi+6dO/C5WlUA4AICzlyoE9wvPMd+R8/xZSXSwMFqliIvH
         EYEvVmMpNenvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 213AFE8DD5B;
        Thu, 17 Mar 2022 12:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: Add missing of_node_put() in dsa_port_parse_of
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164752081013.22810.17954436878989879996.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Mar 2022 12:40:10 +0000
References: <20220316082602.10785-1-linmq006@gmail.com>
In-Reply-To: <20220316082602.10785-1-linmq006@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     andrew@lunn.ch, vivien.didelot@gmail.com, f.fainelli@gmail.com,
        olteanv@gmail.com, davem@davemloft.net, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 16 Mar 2022 08:26:02 +0000 you wrote:
> The device_node pointer is returned by of_parse_phandle()  with refcount
> incremented. We should use of_node_put() on it when done.
> 
> Fixes: 6d4e5c570c2d ("net: dsa: get port type at parse time")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  net/dsa/dsa2.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - net: dsa: Add missing of_node_put() in dsa_port_parse_of
    https://git.kernel.org/netdev/net/c/cb0b430b4e3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


