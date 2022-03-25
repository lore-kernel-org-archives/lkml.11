Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B17C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 21:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiCYVIv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 17:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiCYVIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 17:08:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3BF1EDA29
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 14:07:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93A8B61D73
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:07:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0188FC3410F;
        Fri, 25 Mar 2022 21:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648242426;
        bh=xM4j5R6SQgWLpQahLxDpqgoAyMszWavQHVFeNm/YywY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H9aS0ydvhJG8fdCJ+qGRcrz0bWwJAEBwxAc3060NwBikWXNNtei7+Di+wJaVFAgty
         7ErmSGCSmFSAztFZ9cY+OHJNbluLI6nlAQKml6qIMn2QNRmqutkJgVNIFhlq+jQaFn
         XNGLOxhMxSuheaA6j6CmAS4oQBHZkFvkn7YCPA1Y1PF6b2XZz9wQ/bUs4p6LMHHZjb
         o6m3Wz0mhzf0EqF2x2hhGjho6THVPezqBn0f2vxW0hgnitVeuVrfTV0OJ9xr7gaUL8
         4RnE6aqcNhgKD7GMQ7tCpFSrlpi4pW9YpAumQ3riR6RXijKOXldSCDLyRMoke17XZa
         t5wDvZEkZeb6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3061E7BB0B;
        Fri, 25 Mar 2022 21:07:05 +0000 (UTC)
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.18-1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <bd0e83ec-f42c-4617-5c1c-57501177afe6@redhat.com>
References: <bd0e83ec-f42c-4617-5c1c-57501177afe6@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <bd0e83ec-f42c-4617-5c1c-57501177afe6@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-1
X-PR-Tracked-Commit-Id: b49f72e7f96d4ed147447428f2ae5b4cea598ca7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1464677662943738741500a6f16b85d36bbde2be
Message-Id: <164824242592.8431.12838676369396773348.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Mar 2022 21:07:05 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 24 Mar 2022 11:49:48 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1464677662943738741500a6f16b85d36bbde2be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
