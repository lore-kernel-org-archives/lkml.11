Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCDACCA47B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 18:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiFHSAb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jun 2022 14:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbiFHSAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:00:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F931A8992;
        Wed,  8 Jun 2022 11:00:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 730E3B829B3;
        Wed,  8 Jun 2022 18:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2769AC385A2;
        Wed,  8 Jun 2022 18:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654711215;
        bh=J/ICjrWbJle51L64qcqQVlPSKkpnJKN6TY6Gw8aX4Mg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sLdXC0xjHdyWiiTSb5DlGoTmmbp3JvVVzk29zPgUlQxYLmHvmHhgOnttR8ntJOrDR
         trtmb4ZjLhLAPVZyQQRIbn3JxhM8CKuEOBhajxE31w8jkQ8V9zCDr+MRl9G8j0wCs/
         JtdrGAFEIoAJSjbq9afeirKBnmzefhzpSYanBxNOfc3upuM/wjkxXtiRNjjeZCOOKH
         Gy50PWWc4gRFkACiipGipFZDk+BQJeDC0M8ltYX+nI+BvcWiIN4X3okXKfmKpDk46C
         lEJYZzwD8U7UCfy4dUREG0jlfaz9RhiDbQPHXe/rWCKV/0WW2HgpvAP7dzOFryv2/8
         /jT65RN3eusAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 107F5E737EF;
        Wed,  8 Jun 2022 18:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] nfc: nfcmrvl: Fix memory leak in nfcmrvl_play_deferred
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165471121506.25792.17494847450565348748.git-patchwork-notify@kernel.org>
Date:   Wed, 08 Jun 2022 18:00:15 +0000
References: <20220607083230.6182-1-xiaohuizhang@ruc.edu.cn>
In-Reply-To: <20220607083230.6182-1-xiaohuizhang@ruc.edu.cn>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>
Cc:     krzysztof.kozlowski@linaro.org, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Jun 2022 16:32:30 +0800 you wrote:
> Similar to the handling of play_deferred in commit 19cfe912c37b
> ("Bluetooth: btusb: Fix memory leak in play_deferred"), we thought
> a patch might be needed here as well.
> 
> Currently usb_submit_urb is called directly to submit deferred tx
> urbs after unanchor them.
> 
> [...]

Here is the summary with links:
  - [1/1] nfc: nfcmrvl: Fix memory leak in nfcmrvl_play_deferred
    https://git.kernel.org/netdev/net/c/8a4d480702b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


