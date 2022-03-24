Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B21C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 19:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236793AbiCXTqK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353113AbiCXTpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E0037003
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:44:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D9661B97
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 19:44:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EA2AC340F3;
        Thu, 24 Mar 2022 19:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151061;
        bh=ybtNivCfkMay4XOtlaXyVjbTzJBRfzFWEFDFuxcNGrA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l+qbqasQuL+HhxaIovrUs5jKbleQ+coU2HNt+Hlf68EBUlp88tz78sbAuvFfq+whj
         IM6JOjVuhtYGzcRUFIlevNdZPvq0hVFvzyX2SMEo24rbUnMQyBNvBJcUe9090X2R5d
         qRQGIl7HfN26T8Aiw8VYf5RLBvq7pElN3jBExWzuXt5vhm25+j+xbRNBjhKOLZMSpq
         Uzwx38D/CwZNG+F54o888McIs95r201Qev4xzwhPtFdqSGz5gSWpjvktoeM+DdffS4
         JiLjkQhPFFejTgTpkP6Dgsf2wNaVnVGWRT3xqJG7jEAKTHaVPdJHnz87pG1UYxi8Wo
         suVZsFW1+O5Vg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47D8FE6D44B;
        Thu, 24 Mar 2022 19:44:21 +0000 (UTC)
Subject: Re: [GIT PULL] prlimit and set/getpriority tasklist_lock optimizations
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87ee2sfmtk.fsf@email.froward.int.ebiederm.org>
References: <20220106172041.522167-1-brho@google.com> <87ee2sfmtk.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87ee2sfmtk.fsf@email.froward.int.ebiederm.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git prlimit-tasklist_lock-for-v5.18
X-PR-Tracked-Commit-Id: 18c91bb2d87268d23868bf13508f5bc9cf04e89a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cd4699c5fd66b00211f4709b9957bfd7b0a02ddc
Message-Id: <164815106127.31218.8361962569340680873.pr-tracker-bot@kernel.org>
Date:   Thu, 24 Mar 2022 19:44:21 +0000
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        William Cohen <wcohen@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Peter Collingbourne <pcc@google.com>,
        Xiaofeng Cao <caoxiaofeng@yulong.com>,
        David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        linux-kernel@vger.kernel.org, Barret Rhoden <brho@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Mar 2022 15:14:47 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git prlimit-tasklist_lock-for-v5.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cd4699c5fd66b00211f4709b9957bfd7b0a02ddc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
