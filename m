Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B847EC32773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 21:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351802AbiHSVOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351674AbiHSVOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:14:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA2A719AD;
        Fri, 19 Aug 2022 14:14:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B1D961737;
        Fri, 19 Aug 2022 21:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF71AC433C1;
        Fri, 19 Aug 2022 21:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660943679;
        bh=gdoHNEL75+MVZBcr5Yhk+hJfR6N5vjhPex8MTgidlAo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kJ2hSp1/OwI9neSirzjKKXusl38J7nnBQWWSzx5lMKVw4mDeHcZ6iKxELVDyo3wpw
         XOYDGI11784Do6DYiEJyCxePtGpTt8Io5/Ywv1R0jttQAfkEqjHgtwWTt4+lCfyXmN
         +IjdyI77WdgkcSNiNe48UwUTO16RZ3PPSJXmtOWNuwG94oAYT60qDbKeg/Py4URATq
         TSvCSiq20WQX56YxlJY3q4n66qaiE5XYbF9qozWy1R9VgbbM1WwHW9Ndu6ChUi/1Da
         DO3Kzkm3NMac19lDLl2jOyRh2bWrGOcSkN8gQGQXxzf7+SnDyJ1sAN1+fwMkn2r+Ut
         a1IBBgV0hvW4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BC4A3E2A050;
        Fri, 19 Aug 2022 21:14:39 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 6.0-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220819103357.2346708-1-pbonzini@redhat.com>
References: <20220819103357.2346708-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220819103357.2346708-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 959d6c4ae238b28a163b1b3741fae05391227ad9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ca052cfd6ee5d3358f2929439e0c7f0424bedc9e
Message-Id: <166094367976.15089.1525473485551266176.pr-tracker-bot@kernel.org>
Date:   Fri, 19 Aug 2022 21:14:39 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 19 Aug 2022 06:33:57 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ca052cfd6ee5d3358f2929439e0c7f0424bedc9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
