Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DB8C00140
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 03:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbiHSDNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbiHSDMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:12:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227DADC0A6;
        Thu, 18 Aug 2022 20:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC247B82508;
        Fri, 19 Aug 2022 03:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73ECEC433C1;
        Fri, 19 Aug 2022 03:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660878764;
        bh=MRncaWLaXkq3YfWaty+OLZ5vEs1M5+qsyjv+UhLdEn8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EHvLGUy4XZoKKKubHn8y4BQdtoGWQyjbtpZtQTFzMFpMXkP83dBmJaskr3bV1b6/P
         L22VN0OpxRG4Nrw8in2jzpVTOihU6vGntPVmvLhc5Z3UOSx2hbM49YXEjPXY2O0Fi+
         QK2X0EYHCiWgzvPLAJOMU+aTC9DAdEcqDaOD2z7l7ofBKeQLJHNZmisQJ8SSht639c
         ByV2Wz60QpnmtjFtWF0y57spMhnLdx3EbRhyB4vuJNzp5jxqrm3NREoZgtfNPTjW1z
         NyqLXxZ9fG0V8CjocsOsVoyyzy/TciFZ4QiF7io4f9ai5aMgAlNqbTK1qavAf/ljhw
         nOKPZebqHUeAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63FB3C4166F;
        Fri, 19 Aug 2022 03:12:44 +0000 (UTC)
Subject: Re: [PULL] Networking for 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220818195549.1805709-1-kuba@kernel.org>
References: <20220818195549.1805709-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220818195549.1805709-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.0-rc2
X-PR-Tracked-Commit-Id: f4693b81ea3802d2c28c868e1639e580d0da2d1f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c2d0b039c5cc0112206a5b22431b577cb1c57ad
Message-Id: <166087876440.25117.1837147442234627236.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 03:12:44 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 18 Aug 2022 12:55:49 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-6.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c2d0b039c5cc0112206a5b22431b577cb1c57ad

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
