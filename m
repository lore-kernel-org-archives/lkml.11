Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F92BC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 19:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244888AbiBQTAb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 14:00:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244873AbiBQTA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:00:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9937C7A0;
        Thu, 17 Feb 2022 11:00:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DB65B8240B;
        Thu, 17 Feb 2022 19:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EC61C340FA;
        Thu, 17 Feb 2022 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645124411;
        bh=kGPxrGPoSV+MzCa+HHQJ2D0ZehDmKbDU7byj+HXvUdY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=osCvaHejSHXRkuU641nKiMZisfzEd4ZQooO+JDJYf1rv+ARK23q+U5zW4jLu6RNxO
         iKqGYwxlRY4hCRte0crtEcdkB2KNdocc3h3YlIbFO0UusfKXHhOtk0OWtvL86Z0EMa
         nB/xHjPy6EsCgM1/GjA6S+6vwwRMEZ5Uhdxl8G2NJmC5ZI+dYcVLRnprKdVAJnE9cF
         BzbVudEu3yupuVVvkcCt3/NoTfXCIGoBGWe7QyD/e3EpKFZvIpqLjhNGWKiZE5fuw4
         tkDBlcgrsVbmDzvBmSKooOX5Qmx4Ri4SuxoyKv0icB+Bd59e3cPwLKwNHoCi+88T67
         3ODWGWpaVfLLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D7DFE7BB08;
        Thu, 17 Feb 2022 19:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: force carrier update when releasing slave
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164512441105.13752.5587064860176917194.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Feb 2022 19:00:11 +0000
References: <1645021088-38370-1-git-send-email-zhangchangzhong@huawei.com>
In-Reply-To: <1645021088-38370-1-git-send-email-zhangchangzhong@huawei.com>
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        davem@davemloft.net, kuba@kernel.org, jeff@garzik.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Feb 2022 22:18:08 +0800 you wrote:
> In __bond_release_one(), bond_set_carrier() is only called when bond
> device has no slave. Therefore, if we remove the up slave from a master
> with two slaves and keep the down slave, the master will remain up.
> 
> Fix this by moving bond_set_carrier() out of if (!bond_has_slaves(bond))
> statement.
> 
> [...]

Here is the summary with links:
  - [net] bonding: force carrier update when releasing slave
    https://git.kernel.org/netdev/net/c/a6ab75cec1e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


