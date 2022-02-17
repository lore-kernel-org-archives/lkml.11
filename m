Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425ACC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 04:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiBQEkd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 23:40:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiBQEk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 23:40:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C269A284225;
        Wed, 16 Feb 2022 20:40:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70AA9B820FA;
        Thu, 17 Feb 2022 04:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3779DC340EF;
        Thu, 17 Feb 2022 04:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645072810;
        bh=iVmhDKR8iD6al2fm45Ji8pYosNaaGy8hMBSl2CX/dmg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XwnHwsHuIb2p3FISax614iWcqv1DSyO7IR1RstLZG9y9zz4ltzroeVsMBrnrV3Vjv
         jrNFD8HWjs7uQ8AeOSb0NqM6ftzDaxeNDXgQZw3VFVCVdI+znoo/MkamKR8NE4zhHs
         6+GrcDDfyYEUGb40rg9fKhm2giXG6fvy5O2uC6/QNqfHVKRrAUk7P4nJBX3NZrzq7Y
         4jsTZSMUi1mfFN3J+ZIgKcEvfBMBAXPgwCAs96d81+VZm1Zt1E45EFW0x0LfsE4g5J
         O+cQDKcBlsvvJ1IynEA/L1faZpIP9LEr56emJIgnt5pyoyki0IttL5wxRbzsNNzISh
         094ou5nyNTxpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 264D7E7BB07;
        Thu, 17 Feb 2022 04:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hns3: Remove unused inline function
 hclge_is_reset_pending()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164507281015.19778.12365831478687327546.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Feb 2022 04:40:10 +0000
References: <20220216113507.22368-1-yuehaibing@huawei.com>
In-Reply-To: <20220216113507.22368-1-yuehaibing@huawei.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        davem@davemloft.net, kuba@kernel.org, wangjie125@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Feb 2022 19:35:07 +0800 you wrote:
> This is unused since commit 8e2288cad6cb ("net: hns3: refactor PF
> cmdq init and uninit APIs with new common APIs").
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h | 5 -----
>  1 file changed, 5 deletions(-)

Here is the summary with links:
  - [net-next] net: hns3: Remove unused inline function hclge_is_reset_pending()
    https://git.kernel.org/netdev/net-next/c/8aa69d348261

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


