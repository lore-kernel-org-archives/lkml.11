Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD6BC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jun 2022 18:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiFYSaX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jun 2022 14:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiFYSaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 14:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A00140C3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF1D5B80CBE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72A50C341CA;
        Sat, 25 Jun 2022 18:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656181809;
        bh=PoJvmiI2UqLeMPkSorRResOV16LpEmaGe8o/U0iuIdY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=W6oUwzvBGe/eyptzm5Tt5UgyOVw9UlSQmTPE/e+MpQafrqN0AeivsyEonHib+2C6L
         x0wCaDNtO5c8mNopPn329yKYXn9yd3eaxQtsVs180dlOvw820k0jDj04M6h3Tph7oD
         v9QnitEEjhBbk9VAOZCEmwKvZVqKMip0KqVwDLf4ALDKLIn4ckxWib5gAfnOWWaIMT
         REG3rsL6+sr/xrjvrnRSQxf5DUW6CBI6/YoSfhvzuruk1pVVA36gbgtuxwPTEiPIpJ
         RwgJjdrM05OwWCdfasgCKvcFq3y8iLHbzDvmeU4ib2yzbexXKR2Na+J48jM7N5dU5r
         ZJ+zqELoINh1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F885E85DBE;
        Sat, 25 Jun 2022 18:30:09 +0000 (UTC)
Subject: Re: [GIT PULL] IIO driver fixes 5.19-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yrce2fjrifRMqjBb@kroah.com>
References: <Yrce2fjrifRMqjBb@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yrce2fjrifRMqjBb@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc4
X-PR-Tracked-Commit-Id: 315f7e15c261167ea71c1a4cce2a18ca30e990ea
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0840a7914caa14315a3191178a9f72c742477860
Message-Id: <165618180938.26648.11528867629686108219.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jun 2022 18:30:09 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 25 Jun 2022 16:42:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.19-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0840a7914caa14315a3191178a9f72c742477860

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
