Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDFBC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 00:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbiBKAHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 19:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346126AbiBKAHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:07:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEAD270A;
        Thu, 10 Feb 2022 16:07:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28D6BB827DC;
        Fri, 11 Feb 2022 00:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E86C3C004E1;
        Fri, 11 Feb 2022 00:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644538034;
        bh=fJnsFUrYP3Dw+LYdPUUB3Db1DAxhyValeRchLkMaP4s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sz+OT0GsaIS2mk5D2QiYDaLXr6RlIr3N6n3VHoO+OFiQ6Ez+ACuNptCOD4hBlg9KY
         HDCIPkzeK8zOj+kW4BOXCZKOP3xxDWiUNC1fV/8SLIP0HwoJvHhPzONlza5hPqsAXb
         a2eF4O44lv0+pqVT0C3s2U+dRB+xEowsugxMjs8xQv6rzwuDI3WdSB1FqOBI5eV16Z
         MpkdEID+AA+pvLhQx/HZIbV2/Af7gLEDX99c84yRYXJPRVeHSj9CK4s/NCD0uYmmQo
         I0Djnzzi6M5n3ZRdUyxMwBn0sr2FAm3qm9O1fcFixPrPtpus+OQnxtK9nonqr9brlF
         ZxpvQQX6ujcUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D34B1E6D447;
        Fri, 11 Feb 2022 00:07:13 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 5.17-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220210203258.2596078-1-kuba@kernel.org>
References: <20220210203258.2596078-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220210203258.2596078-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.17-rc4
X-PR-Tracked-Commit-Id: 51a04ebf21122d5c76a716ecd9bfc33ea44b2b39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1baf68e1383f6ed93eb9cff2866d46562607a43
Message-Id: <164453803386.1838.3327470308962393028.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Feb 2022 00:07:13 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Feb 2022 12:32:58 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.17-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1baf68e1383f6ed93eb9cff2866d46562607a43

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
