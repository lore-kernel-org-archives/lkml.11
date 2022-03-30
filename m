Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F16C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 18:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349965AbiC3SWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350299AbiC3SWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:22:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9184553C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:20:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA1DA60F47
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B5ABC340F3;
        Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648664413;
        bh=x0UHvUuC38g+S2tNI2ndVR4Ci9dODceoAMqXgTAxMik=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kRFL4adU99autJJ9gjOQA7AUFVARfmCZwHyOnQtvy9nxr7+Ma29cRtDeYfsljLg1e
         /UxNtlQLGuhI9a0QVF6yhTJ7w0ex/D0oWztIsGfzdaWflcEJOpAFlE8g3UPXalXElr
         3HodPs4f+BgvdIRw8Oe77FyDIxCWPN+FLjYqkaGf3aHzw1hqoI9xhPk9ytsrrvBXT+
         65vVvqjv318b9X2KizxpaRkhHwAHmpOelyu5Y+xJYUdGOFNTrCTOGdY4OyqNEaX7K0
         g6IVfZTc16gRlZuNz31Kc7LRoqKs9/CNrX/QwOaeHUOw7ggPxagZnLnN9MuLxBNcNo
         LaF1qlyYPe+ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 361BFE6BBCA;
        Wed, 30 Mar 2022 18:20:13 +0000 (UTC)
Subject: Re: [GIT PULL] LIBNVDIMM update for v5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPcyv4hydiSDFXVVBtYyuUgutTca6eL67s7txkSgzGzW1VGT0A@mail.gmail.com>
References: <CAPcyv4hydiSDFXVVBtYyuUgutTca6eL67s7txkSgzGzW1VGT0A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPcyv4hydiSDFXVVBtYyuUgutTca6eL67s7txkSgzGzW1VGT0A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.18
X-PR-Tracked-Commit-Id: ada8d8d337ee970860c9844126e634df8076aa11
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ee96dd9614f1c139e719dd2f296acbed7f1ab4b8
Message-Id: <164866441321.5472.9111993236292688161.pr-tracker-bot@kernel.org>
Date:   Wed, 30 Mar 2022 18:20:13 +0000
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 29 Mar 2022 13:54:41 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ee96dd9614f1c139e719dd2f296acbed7f1ab4b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
