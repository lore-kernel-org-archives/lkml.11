Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F288C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 21:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349598AbiFCVtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349483AbiFCVtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 17:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7A7580DB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 14:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CF2F61B44
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BF05EC3411D;
        Fri,  3 Jun 2022 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292964;
        bh=8JW3yHHDo+iosrYXKelq21iYRDKOzX7yI7KH08KX3Uo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=RHccCFak5hdfxQp01WR2P9EN+mRD0aDwrKpW8tqoSkbXBjSIzIUTgAl+dZaYT3vXh
         O2gsfB0Zdwo3iEBDhowzO+xfIBvzK7m9Di8JtwNr/yC8EldPERUaS4jjyNDSr78jpV
         SfhjjNFO8+0Lo6LKqkcY2zZgzqS+ebUEBhPM16GRE0b8bsCU8+eFeNYIPGZiOq8h5h
         RAl/qyTG0Pl+nhbAm0cZCI+q3vsYCpc+V47uYmhTR4YIJ1fVZXO0EYzdZeSRmyiQIv
         5cLoXeqkYGADcpNxglmCERcDZD+y9LbEC61+6h3PHE4p/m72sE7ZwmS24x6wxZyiLs
         SI6J0Li+hEdaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ACB5AF0394E;
        Fri,  3 Jun 2022 21:49:24 +0000 (UTC)
Subject: Re: [GIT PULL] UML updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1471475855.130153.1654260450880.JavaMail.zimbra@nod.at>
References: <1471475855.130153.1654260450880.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1471475855.130153.1654260450880.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.19-rc1
X-PR-Tracked-Commit-Id: 2a4a62a14be1947fa945c5c11ebf67326381a568
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4e583ff9df9126e275c32c6ecff54b0316fe1dee
Message-Id: <165429296469.7657.17002862535144154299.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 21:49:24 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 14:47:30 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4e583ff9df9126e275c32c6ecff54b0316fe1dee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
