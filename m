Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03447C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 13:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237531AbiERNKX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 09:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbiERNKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 09:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F63517B871;
        Wed, 18 May 2022 06:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10AB26178C;
        Wed, 18 May 2022 13:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6990DC385AA;
        Wed, 18 May 2022 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652879413;
        bh=S0c/U8TGnMAYSAUg3XSouU7ZNEiDpnBInkFtKaT+sRQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mV2EhdMhLnlFAInQUoHPWybAImi4yxkvVC7qIPn13+P44jHIX0En7ZLT+aEZ68QQq
         OSrmJ1Uz1vSGv48PATGkcE2WBvyDvWMK3zhlX8JtPX3PqiZh1TFnA7Bt6TKJ7Nqkjt
         uGnVvriJVSGBYJYQuNS0ApKbX8Y7iVgvyxF7kpY1WX81qeKOfoocfkv/fE+6fNvyc+
         NCNbPoABXNNc+f2RlLaR6hatIcGmXT15V0AIWApLI9/4N/qAFw0QMnMnhh1sT8OLeC
         C7gE90z//IgKq7WTL0wn6lrrlskrX2XinEoq7togUcllCyeThsWq0kKNq+lEaZwS0L
         XW3fJAjWFmUnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 558E3F0393B;
        Wed, 18 May 2022 13:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] eth: sun: cassini: remove dead code
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165287941334.26952.3275082787982617735.git-patchwork-notify@kernel.org>
Date:   Wed, 18 May 2022 13:10:13 +0000
References: <e3cf25ce-740a-c9eb-0d30-41230672b67c@suse.cz>
In-Reply-To: <e3cf25ce-740a-c9eb-0d30-41230672b67c@suse.cz>
To:     =?utf-8?b?TWFydGluIExpxaFrYSA8bWxpc2thQHN1c2UuY3o+?=@ci.codeaurora.org
Cc:     kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed, 18 May 2022 09:18:53 +0200 you wrote:
> Fixes the following GCC warning:
> 
> drivers/net/ethernet/sun/cassini.c:1316:29: error: comparison between two arrays [-Werror=array-compare]
> drivers/net/ethernet/sun/cassini.c:3783:34: error: comparison between two arrays [-Werror=array-compare]
> 
> Note that 2 arrays should be compared by comparing of their addresses:
> note: use ‘&cas_prog_workaroundtab[0] == &cas_prog_null[0]’ to compare the addresses
> 
> [...]

Here is the summary with links:
  - [v2] eth: sun: cassini: remove dead code
    https://git.kernel.org/netdev/net-next/c/32329216ca1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


