Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E40BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 22:05:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349992AbiEZWFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 18:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349981AbiEZWEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 18:04:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1FC62A0C;
        Thu, 26 May 2022 15:04:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2399B82219;
        Thu, 26 May 2022 22:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BDE0C385A9;
        Thu, 26 May 2022 22:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653602684;
        bh=ECgkSFExHsqzKzy858DFNxfa09+NDtw4qUcJMjqu2Ek=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EnrS6YwNzdjYkewbpKhw1g9QE3ZFqsCwTczBBaBFKbJOKexGx5ib2RJfW434+TT0t
         TSqooSIoZ3hcaLf5Do7gsGZ3+cR1D7RrwqnUUzX7HaI3FvmFwnMfb/LvFjz47zzLp7
         v2t3DhNzy1nXVhHWZnIHON+Av0NqceGBK1+PyAisRz1ZcJIK5h2j5gj+FBVuDmxIvN
         pgO1G2hXVrNp3eKK5Juh/KUOav0odBUkGwDxHPA6z1qzAnb92KvfpCkE9vbSqLMLtz
         bMjmZZ8yJYN8uhN5tMkfYcBR41iNr21DHsUPMZkvwm8aZSGz9RSrd1fW2LRMnn0TAJ
         usx0o0LG1ZkrQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79541F03938;
        Thu, 26 May 2022 22:04:44 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 5.19 merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220525152650.250776-1-pbonzini@redhat.com>
References: <20220525152650.250776-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220525152650.250776-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: ffd1925a596ce68bed7d81c61cb64bc35f788a9d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf9095424d027e942e1d1ee74977e17b7df8e455
Message-Id: <165360268449.24340.12208072038298092748.pr-tracker-bot@kernel.org>
Date:   Thu, 26 May 2022 22:04:44 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 25 May 2022 11:26:50 -0400:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf9095424d027e942e1d1ee74977e17b7df8e455

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
