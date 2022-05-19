Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81EDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 00:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiESAfy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 20:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiESAfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 20:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139E819579A;
        Wed, 18 May 2022 17:35:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CE58617D4;
        Thu, 19 May 2022 00:35:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6465C385A9;
        Thu, 19 May 2022 00:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652920517;
        bh=/Tm11RFlNKmtY2ZepP5yUL0xMrhzGYOVHBkmCUnjqsg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Imtmf12XZ6SN/0fQnIzFMV4ix/W3SoEf9rCkuzXX+1TpPKRliO7krhuH+qi7TYOqp
         oxiyiQv3m4tgvGWGE/16K6GkgMiqi4JJeIL8lSB4ZyGohayb0swXnKy59+p3unEuAH
         BTOQKn2vj5hfqQLmmwYq3ONvtqf6OiZ1lIoUl8LXkqefItK2FVp/KSiVIo5ZswXKZ0
         plu9Kk8R/lvGl/A53gc447sJFo/usYScnOXt0CuQxOqwu5QMiqopnMaBhJ++sbPQLR
         mbeRiqQAHKxtuiSJowv6Vd+DwlM9yyJBSnYJmVHp1Ka5rHOjzDPHCj8WV0Zia9cRKs
         Cm1mCplLYPpNg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE8B8F03935;
        Thu, 19 May 2022 00:35:17 +0000 (UTC)
Subject: Re: [GIT PULL] mlx5: last minute fixup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220518123304-mutt-send-email-mst@kernel.org>
References: <20220518123304-mutt-send-email-mst@kernel.org>
X-PR-Tracked-List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
X-PR-Tracked-Message-Id: <20220518123304-mutt-send-email-mst@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus
X-PR-Tracked-Commit-Id: acde3929492bcb9ceb0df1270230c422b1013798
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: db1fd3fc06420e983c2854c09f0260a66aa8dcc0
Message-Id: <165292051784.29647.16410056914812712498.pr-tracker-bot@kernel.org>
Date:   Thu, 19 May 2022 00:35:17 +0000
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, elic@nvidia.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 18 May 2022 12:33:04 -0400:

> https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/db1fd3fc06420e983c2854c09f0260a66aa8dcc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
