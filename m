Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707A9C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 20:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiGVUH7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbiGVUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 16:07:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C768CE89
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 13:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 256DFB81EDB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 20:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2A3BC341C6;
        Fri, 22 Jul 2022 20:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658520471;
        bh=yvLUvjeW4JCCFMQx/C+ldKvP9tMF7d3pHBZD2YskKoU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pNXeGkhPBrf6C2GcZAh049d0OUjyBVeLLrmwnWYgvLVA9Q2vmNmO/eHFUTsJFTqrw
         sRzCec4ztqSHzW1JBw3nt8ORcJYVBicdb382aB4jjG+HfA2ddGo+SSk+PmhATvlZiG
         0X1YdCaChC4vEaR5CeD/bNvuiHVwiQ4kwqmXqdN9mf4MHsDNx/gYkQqISXheLwPkBU
         tjNipcBcemwZ81ZuyLmSMHZcHHoJaB5ZU86JRv93RZtlaTzGxS2Fvtu7StyQZQODMK
         Vt60iSpSKXIOEsXTrvVoylujtrjZiGPPeLAPoPovbAnZYnH6aHkJUOyeKWCn8gAPqc
         FD/T/4vrPODWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CFD0BE451B3;
        Fri, 22 Jul 2022 20:07:51 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 5.19-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx177pqAbBTC586NRwr+kbx=_pQjQwKpFjB+442m-uSdw@mail.gmail.com>
References: <CAPM=9tx177pqAbBTC586NRwr+kbx=_pQjQwKpFjB+442m-uSdw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx177pqAbBTC586NRwr+kbx=_pQjQwKpFjB+442m-uSdw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-22
X-PR-Tracked-Commit-Id: 7f5ec14a4e07a2a78fbde069709d5c8806882be2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8e65afba6baaa1317efc4038cbced1268c6e2f6b
Message-Id: <165852047184.15752.15754098115255802753.pr-tracker-bot@kernel.org>
Date:   Fri, 22 Jul 2022 20:07:51 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 22 Jul 2022 14:15:37 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-07-22

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8e65afba6baaa1317efc4038cbced1268c6e2f6b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
