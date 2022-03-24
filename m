Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A35C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 19:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353303AbiCXTqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353270AbiCXTpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:45:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20B73A5CC;
        Thu, 24 Mar 2022 12:44:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7ECBE61A8B;
        Thu, 24 Mar 2022 19:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4E8FC340EC;
        Thu, 24 Mar 2022 19:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151059;
        bh=LPGY6Cy9z15/WJvo+eMj1onqzaDsepEvhlcd/FLEMUs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HhFk1OpIRUTGwXVnMcdlrYwStgu4qCadN/oijBLVFZMgSTQ/7ah4i8voKKIpq+SPJ
         Pl899V76VWdZKMlLfxM/GD6Wo8DhQq+bskmwmlCkjSb8eLvDXelCwNUovu6i3jDB+i
         UNvLbm8d7Crwh8d1FXw7Tcs1pTluLIwjFLZR4ikVonkuyWBeD8YA66aPGPppa06XrB
         neF76l52B875ah7TYbICp65u0831/AkKPacCNWeGkG7hjbQeuA5SowQucIV/vvueq6
         V8SvPm0VrHpP9e4b+JOCSbdo1VlIYjJ5ywIlbn3lP2g66yIegq0fDrmIXKH7GwCRkb
         OmGj60ZOHN1DA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2AFDE7BB0B;
        Thu, 24 Mar 2022 19:44:19 +0000 (UTC)
Subject: Re: [GIT PULL] First batch of KVM patches for 5.18
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220321173215.2824704-1-pbonzini@redhat.com>
References: <20220321173215.2824704-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220321173215.2824704-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: c9b8fecddb5bb4b67e351bbaeaa648a6f7456912
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ebdbeb03efe89f01f15df038a589077df3d21f5
Message-Id: <164815105985.31218.7933228410541713310.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 19:44:19 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 21 Mar 2022 13:32:15 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ebdbeb03efe89f01f15df038a589077df3d21f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
