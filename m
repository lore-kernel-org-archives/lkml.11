Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A61C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 19:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbiDNTXG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 15:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345558AbiDNTWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:22:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B36ECB17;
        Thu, 14 Apr 2022 12:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82537618AC;
        Thu, 14 Apr 2022 19:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E22DEC385A1;
        Thu, 14 Apr 2022 19:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649964001;
        bh=JQjt7cAysV8TAFVbH7B05zNc0p1yfzuAQ2dYZ0QW1Yg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ae/JhfCX8QCP7bWAjF2L66ZapTGzo/ZAopacSmdUR67id0wwMUmy6c4rzh6Q5m3VK
         SrqiJTBEkSWgnNhfEqnLMudRpemeJ+s71alEs/FB6f3fhiSo//xXgU/Tj/1yccUkUu
         c9VzccO1Iq8+HSX0LrVlNAWwfhrkH8ciIY7G05HlipVm+5EjrCyRP4l9aDaEyMeYzN
         WgXM/jaKLZqcKGhjsY8CyxmxI0+RCSicdc6G8rEPgXPp2UoWml/EY/umcKYcKr7vsF
         1i4zJntniQktaDFQyENb8oO4uDU91U7jECGG9+IEPPUvAJ/R6XPH67rY+k6O7wv23I
         l/Mg3N9EmZOtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CEE64E85D15;
        Thu, 14 Apr 2022 19:20:00 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for 5.18-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220414102641.19082-1-pabeni@redhat.com>
References: <20220414102641.19082-1-pabeni@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220414102641.19082-1-pabeni@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.18-rc3
X-PR-Tracked-Commit-Id: 2df3fc4a84e917a422935cc5bae18f43f9955d31
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d20339fa93e9810fcf87518bdd62e44f62bb64ee
Message-Id: <164996400083.26481.12722675352704266113.pr-tracker-bot@kernel.org>
Date:   Thu, 14 Apr 2022 19:20:00 +0000
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 14 Apr 2022 12:26:41 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git tags/net-5.18-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d20339fa93e9810fcf87518bdd62e44f62bb64ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
