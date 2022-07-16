Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E50C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jul 2022 18:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiGPS0Q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jul 2022 14:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbiGPS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 14:26:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC70192AF;
        Sat, 16 Jul 2022 11:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 672E3611FC;
        Sat, 16 Jul 2022 18:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C93DAC34115;
        Sat, 16 Jul 2022 18:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657995973;
        bh=N5Hi1aVwa+Lf/687QxjYjUcRD800NpqrugSRDMxNWQU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=nAbDbi/LkrlWrekLh4Bgt61u5FlPYZ+VxdYjUVmJN7Gf/wArxUimue/lyaqe+9p8Q
         zVcDA10fWJxsvNtH7/oQHbQ8mh1mQ1G4B8UwVLLZXBQ8uvkiAp7fwu8reApvo8SKMw
         9xvAB+A6cDdFX8VDkTF7MTPSIDtuanMFPMemKI9RZBRwbAbUbLC9GxaJ3uwuUStU7B
         8LZvQsH0Us4y+6cIPssQ9u45+uyzDIPYSXgiUPPB2lH/dfQmd6EI5n6x3pSSaXV1hc
         NkKEXHQHll8PZJdqVw51whVtEr7zxPqN0v1AO6236ZT20xGm7pVrl/u2soNvqvLfv+
         4CXsee3k4FSXA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B598DE45224;
        Sat, 16 Jul 2022 18:26:13 +0000 (UTC)
Subject: Re: [GIT PULL] USB driver fixes for 5.19-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YtJZlE1lf8EdUYRM@kroah.com>
References: <YtJZlE1lf8EdUYRM@kroah.com>
X-PR-Tracked-List-Id: <linux-usb.vger.kernel.org>
X-PR-Tracked-Message-Id: <YtJZlE1lf8EdUYRM@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc7
X-PR-Tracked-Commit-Id: 3486af89dd3c0b0bef194c4bccf17c31ef16b99f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ed714dbd574663c1fcb01dde07e949fe7473fa8
Message-Id: <165799597374.16639.2018440057003376837.pr-tracker-bot@kernel.org>
Date:   Sat, 16 Jul 2022 18:26:13 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 16 Jul 2022 08:24:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-5.19-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ed714dbd574663c1fcb01dde07e949fe7473fa8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
