Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045B8C04A68
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 01:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbiG1BuU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jul 2022 21:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiG1BuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 21:50:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8531928D;
        Wed, 27 Jul 2022 18:50:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1E80CE241C;
        Thu, 28 Jul 2022 01:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37175C433D7;
        Thu, 28 Jul 2022 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658973013;
        bh=TPPEGMm0hdNBEom2DUfGcgh/59bArrwqfsc9IJBgQgE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=u343eWu0xEhKDDgyyzA0aDlzjCxhuFTq8b5F0ujVM5pbpfqmSeIqqZ2QnhgPW2Kb0
         BTp3tzXgaZMWva8aX9gC8NI04CeQ/13GbpiVbIeE0ZzCTZPtaTqU3KqOpwSOXyBQGy
         x86YtGqcxKJfgn1nGuHzaKNnOp10V99P0H4JDGZzmEyArNOxPF1U5gT/4CKzb06pdD
         x1ZBcYzBp4537mqwmCgqwO00+/LVhbzHGmV02uHWWEyY3+FrmM1uKS5/E1tFcPGln4
         bAqLX2aVRezRuViKhjczCEF1pDtSlVO2DWRDWxZEChprNmi3JFIUzea5ey+VEptGVD
         eOT9STVb4O9mQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1AD49C43143;
        Thu, 28 Jul 2022 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: hirschmann,hellcreek: use absolute path to
 other schema
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165897301310.12814.15652986557134762426.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Jul 2022 01:50:13 +0000
References: <20220726115650.100726-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726115650.100726-1-krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     kurt@linutronix.de, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Jul 2022 13:56:50 +0200 you wrote:
> Absolute path to other DT schema is preferred over relative one.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/net/dsa/hirschmann,hellcreek.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - dt-bindings: net: hirschmann,hellcreek: use absolute path to other schema
    https://git.kernel.org/netdev/net-next/c/a683dc5c148a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


