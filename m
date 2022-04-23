Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A6AC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 23:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiDWX3i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 19:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiDWX3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 19:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA5814B66B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 16:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA47360F63
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:26:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 54B57C385A5;
        Sat, 23 Apr 2022 23:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650756396;
        bh=NzV77wL8e7TdREri3RwdLCioCvs6/MFWXdC62Iy5Uj4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dmNk/fGD5lsJ5T7ItWMkDsSgCPX6k5as/x1A2te7PVMd0XRmekXdu9ClgHx7eTaUZ
         O1iLI8mkD6CSVK+XCE2pL38WJdwDBARmmfxTXwoUo3zwm9dcV5+OqIzBkQD8JXiXGe
         uGd/DGkBk5fLmYNf/bbng9EQNDrlh0nMmJmsrcE2mMEDocnhAiDElZr/6Jave66pnf
         jm8324WGggeHqX97P++jDqmGs7DMZKT1GWkxNBReKg3X43Zw+pP8+qBBrba/51nzZs
         4w5J3DnOYqHYqZt3N2Rol90dq9TaEFj/O59LWEqu2K6NBQKd4vNHu3Lwsy3nT4FRDv
         ved26XLUdiNLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4028BE8DBD4;
        Sat, 23 Apr 2022 23:26:36 +0000 (UTC)
Subject: Re: [GIT PULL] ARC fixes for 5.18-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7b513e98-0cc4-13b9-a26b-d281314c0f74@kernel.org>
References: <7b513e98-0cc4-13b9-a26b-d281314c0f74@kernel.org>
X-PR-Tracked-List-Id: Linux on Synopsys ARC Processors <linux-snps-arc.lists.infradead.org>
X-PR-Tracked-Message-Id: <7b513e98-0cc4-13b9-a26b-d281314c0f74@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.18-rc4
X-PR-Tracked-Commit-Id: c6ed4d84a2c49de7d6f490144cca7b4a4831fb6e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f39359260e39fc45008c1140a84497ffde193fa7
Message-Id: <165075639625.11450.582643110063316987.pr-tracker-bot@kernel.org>
Date:   Sat, 23 Apr 2022 23:26:36 +0000
To:     Vineet Gupta <vgupta@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Bang Li <libang.linuxer@gmail.com>,
        Sergey Matyukevich <sergey.matyukevich@synopsys.com>,
        "geomatsi@gmail.com" <geomatsi@gmail.com>,
        Rolf Eike Beer <eb@emlix.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Julia Lawall <Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 23 Apr 2022 15:23:45 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-5.18-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f39359260e39fc45008c1140a84497ffde193fa7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
