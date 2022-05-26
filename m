Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FAFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 00:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348115AbiEZAJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 20:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348090AbiEZAJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39A644F9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 17:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DA1460F9E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 00:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11D66C34118;
        Thu, 26 May 2022 00:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653523754;
        bh=dg0cMATWEEeBg9rG4Uve1+Cswpobi3GWRVoLrBPHiGw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u24Lwt1KAjMm7MZuNETGfQeqTEeFuzzWaFqj/UEpRi8muh7W5oqE2H59+9Apbtot1
         Pd9l8vwotSEHMUdPGiA0+SDfgQzeD0I6xG/Bn9TwTaj3sEbYVY4fjdpk61VGrChs3B
         kz8AIpE1FpIn5JF3EVvGigfbSWylZ0QcpMixl9x1ujJHIvTsGcTr4C538tVn/TJXEX
         /QbcfUYVU50PSDKRNI9H6OLn4pHeTQDIevHRx51JeL56R+2F6ybmD/q5Uaviu4NKKv
         QEIFG+oudLc5aERuk8xwLxbOwCpJzrhPFz9x6fXzVR0Exh1umWAznETv0Sdqf/5Fmc
         lG3eNbMBiY6Lg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 00F90E8DBDA;
        Thu, 26 May 2022 00:09:14 +0000 (UTC)
Subject: Re: [git pull] drm for 5.19-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
References: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tw62EZfAm0PbiOPmMrpfR98QMFTWGEQcA34G4ap4xxNkA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-05-25
X-PR-Tracked-Commit-Id: c4955d9cd2fc56c43e78c908dad4e2cac7cc9073
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2518f226c60d8e04d18ba4295500a5b0b8ac7659
Message-Id: <165352375400.5177.660648340109162209.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 00:09:14 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 16:06:58 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2022-05-25

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2518f226c60d8e04d18ba4295500a5b0b8ac7659

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
