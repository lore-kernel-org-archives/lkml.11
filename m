Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F4AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 19:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243578AbiBOTTp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 14:19:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbiBOTTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:19:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B536A109A7C;
        Tue, 15 Feb 2022 11:19:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F1F0B8124E;
        Tue, 15 Feb 2022 19:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26A39C340EB;
        Tue, 15 Feb 2022 19:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644952770;
        bh=SjgUfYoAHJ6QtTcEN+ytJZZA0fhHscUqgcUoynC6xqo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QrDVQINQri2lHJQ57nfla/VkEJapkU6x5DQa0P6GefF5jJbhX5LtruP3A1xqA9JJ7
         tj5CSYNCqpCmAH2A+5sDIbBqHSnnKstr/ldfe9FFmN0dpcnhqcQuZfq/y68o9X0yHD
         mp75CSr8HzLV0RhZxorOQFB8cqFdYPDHDzBBtFKcsAzH/N5RxoGXdpqyhajdWWYYhZ
         YHVTiYlSbBBUY48J3Q9EbW4bfnA3P3IbVAqGLiJPwvCxaIlhy/N5sj/E4/2kVPSQ8z
         Re78ateq1IJCmxRSQDBGy7gnVITUA+o/dPLSUM6eB4HkjrdDOhJfq8FPbZ6guisG/R
         fK/OBUVb2W+zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14E75E6BBD2;
        Tue, 15 Feb 2022 19:19:30 +0000 (UTC)
Subject: Re: [GIT PULL] KVM changes for Linux 5.17-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220215172131.3777266-1-pbonzini@redhat.com>
References: <20220215172131.3777266-1-pbonzini@redhat.com>
X-PR-Tracked-List-Id: <kvm.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220215172131.3777266-1-pbonzini@redhat.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
X-PR-Tracked-Commit-Id: 710c476514313c74045c41c0571bb5178fd16e3d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5d9ae265b105d9a67575fb67bd4650a6fc08e25
Message-Id: <164495277007.28413.17972421364914635918.pr-tracker-bot@kernel.org>
Date:   Tue, 15 Feb 2022 19:19:30 +0000
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 15 Feb 2022 12:21:31 -0500:

> https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5d9ae265b105d9a67575fb67bd4650a6fc08e25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
