Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567ABC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 19:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243584AbiBOTTw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 14:19:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243560AbiBOTTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:19:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7500010C525
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 11:19:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23F72B81C6F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 19:19:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E92C5C340EC;
        Tue, 15 Feb 2022 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644952770;
        bh=oRrqUrzxToPE80FjEeHTxSvofgEDQTs1nsd0dQ211yg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lnj3uSy/bWWIgIy57LxOAlXLry3p1fuYkf8tu/GI9skKaAzOZHg8ad6wOidZ0Bh0g
         HNL9BU6Be0nwer0buZKE8VmBDUVn0WopnuCambTQ0K6UUgacXDAgDzBDn9Jv8Go22v
         Xe2iBSQ65PmXSjhVhYURXGplhsd4DBTF4MW9ZvYlaoZUO0j85T4izGc/May85fkRcM
         4ouWLHSZ3UBPbJ+ctHwzDSHn24386HHSBpD3cODpWFMW25E/34vtlJrv3zzUVHlEd7
         7RV1V78NiXnWG0e2MZ9FIvBGaSU0AFSn/+duvlTIK45oWaW8PudVClTSW1U8RtALO+
         OjuF/0J4LaV9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6434E5D07D;
        Tue, 15 Feb 2022 19:19:30 +0000 (UTC)
Subject: Re: [GIT PULL] HID fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <nycvar.YFH.7.76.2202151633100.11721@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2202151633100.11721@cbobk.fhfr.pm>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <nycvar.YFH.7.76.2202151633100.11721@cbobk.fhfr.pm>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus
X-PR-Tracked-Commit-Id: 7f016b35ca7623c71b31facdde080e8ce171a697
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a254a9da455c171441ab3a76ed8f5d1e9412e15f
Message-Id: <164495277087.28413.368546602088820788.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Feb 2022 19:19:30 +0000
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Feb 2022 16:35:43 +0100 (CET):

> git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a254a9da455c171441ab3a76ed8f5d1e9412e15f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
