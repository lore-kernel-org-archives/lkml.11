Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE15C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 21:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349599AbiFCVtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 17:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349590AbiFCVtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 17:49:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F01E580C2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 14:49:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 219C061B39
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 21:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ACB3C385B8;
        Fri,  3 Jun 2022 21:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654292964;
        bh=Ra/1vMUODVaI6X6h0mV5GWOubOGFzt15KpoDc+wQNGQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lUHwEWzZdkl5yASd4IPe4w/2Aq4tvUryOFRy4zNZENYtclnVlxb+c1mqii8t7dmMf
         7eNjUJ94A/axeDc4j88KCo6IorGHVpA1bFP1dm5XA4lIoUAm+IcJcdezVCOUJXc7fB
         y3JlttMzK7mN+lYnTQUjvY9OS3/cjgRV+Olo5jxRPDNG++FUuki4gVG2+pjnkl9/RQ
         h9tPCkHszEtiPqvxD1l/adyiNSg8UJYf/cLyajdU79TYvRhI+9CQrD5mEg+vCaeOxc
         mpyQ2T9+oPDVPvVNIYKNcmLNV6g6wmSCnQYhSizgJANrbB2iRzYWHsKpZ1EXWa5Cvg
         FW7Ls3+ElMAgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7852BF0394E;
        Fri,  3 Jun 2022 21:49:24 +0000 (UTC)
Subject: Re: [GIT PULL] JFFS2, UBI and UBIFS updates for v5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <735024820.130152.1654260428562.JavaMail.zimbra@nod.at>
References: <735024820.130152.1654260428562.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <735024820.130152.1654260428562.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.19-rc1
X-PR-Tracked-Commit-Id: 8c03a1c21d72210f81cb369cc528e3fde4b45411
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 744983d8784214c4f184be7448efb216315b48ae
Message-Id: <165429296448.7657.17494611384445521933.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Jun 2022 21:49:24 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Jun 2022 14:47:08 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/744983d8784214c4f184be7448efb216315b48ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
