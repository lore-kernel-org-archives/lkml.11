Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C885C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 00:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242516AbiE0AdL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 20:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiE0Ac7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 20:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A411E27A0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 17:32:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9796D61D1E
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 00:32:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C754AC385A9;
        Fri, 27 May 2022 00:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653611576;
        bh=KvSPMQIykRMdyjnTd5Ib7q9nFZwrFXGBZDk8gRCsW3A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GHbnDJ+S7mfdXyaqMWXEFp/0cozpPQgC67fignj4mleSMmF4CjSe/Tv1nHnmjijrm
         fxDtT2AANOXjO9/loIvbld+GG1S9S4JXU/OQObMqedtX0xc087Snjwh3F/NOvyzTIA
         K03GQhXHCtjRJBQA2mvCwgFZ8whorNj3Oa5R+4b3RgE1lf6TV5S9o18ohR9Qp5Ii1J
         Nelfgud/AZhj08ETSPa1jEXvEvmCdCUbdgUWVMdVDaeqk1GlIDza4+tNvjsj3stLzq
         GsLU/egry7fWphk2MrBN1DpFn/eeA9kKZvVxR/KkGmOiFddeIoz8nX1xNS6Cqkjcp7
         DScD7+OEyGhSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B4198F03942;
        Fri, 27 May 2022 00:32:56 +0000 (UTC)
Subject: Re: [GIT PULL] OpenRISC updates for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yo/955uRNSaSMBqn@antec>
References: <Yo/955uRNSaSMBqn@antec>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yo/955uRNSaSMBqn@antec>
X-PR-Tracked-Remote: git@github.com:openrisc/linux.git tags/for-linus
X-PR-Tracked-Commit-Id: 83da38d82b2f7ac207646e55be94e8bd642e2c39
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f50d4dfe816dd916a7cbf39039674825c2b388b
Message-Id: <165361157673.27205.13660904432958080717.pr-tracker-bot@kernel.org>
Date:   Fri, 27 May 2022 00:32:56 +0000
To:     Stafford Horne <shorne@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Openrisc <openrisc@lists.librecores.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 May 2022 07:23:35 +0900:

> git@github.com:openrisc/linux.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f50d4dfe816dd916a7cbf39039674825c2b388b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
