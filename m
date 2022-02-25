Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33179C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 20:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiBYUSd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 15:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236241AbiBYUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:18:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528E363BCF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 12:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 958ADB8334D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 20:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C956C340F1;
        Fri, 25 Feb 2022 20:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645820258;
        bh=JD9XaFtBkdR+dWfjXJnZ0dmHkoIkj4QeH8pjWhfR/jk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k1thMhb9KYYQmmAS7XDFrTiasUChuplLjUYeajmlBSK3f50fXdJMNfDN6iHW2fFJp
         UkzZFSpzigPZnbArCijsgWcXSo0lvJqb/QYcl4Z5+2xLxzrVW32ndl3Cz7EGrznmm8
         05UZa60hbIYw1+O68hXrX6hn089P2xwkGgtBO8OBLS8WHUGd/77TRvMKPC9SNHCMM7
         SY2SZkhRgX4SRjHFNabAHySKAfsW8sQR6vjG+bi8eiuOLzm1j44TiH2P7ZLqrEGn2l
         6ER3yoT3akBoykoSDycBG8TB4BSfb8rcFq6hPRBHWA+K2qmTEVnNIadSkeXD3nnQ6F
         EOCGbgotO8D2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B355E6D4BB;
        Fri, 25 Feb 2022 20:17:38 +0000 (UTC)
Subject: Re: [GIT PULL] Driver core fix for 5.17-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YhjYV3rG8Qy/oc0y@kroah.com>
References: <YhjYV3rG8Qy/oc0y@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YhjYV3rG8Qy/oc0y@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.17-rc6
X-PR-Tracked-Commit-Id: d8f7a5484f2188e9af2d9e4e587587d724501b12
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d68ccfdbe5205c746c6ad145c771a4db19fb8dc0
Message-Id: <164582025817.12222.3776299900223582601.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Feb 2022 20:17:38 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 25 Feb 2022 14:23:35 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.17-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d68ccfdbe5205c746c6ad145c771a4db19fb8dc0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
