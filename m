Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569AAC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jun 2022 22:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239617AbiFBWjy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jun 2022 18:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiFBWjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:39:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18D911A3D;
        Thu,  2 Jun 2022 15:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 735AF6190D;
        Thu,  2 Jun 2022 22:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5834C385A5;
        Thu,  2 Jun 2022 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654209582;
        bh=stxXNATAAVa5m7XYtD0qlxolNn1C7S+C6lSJgqlwBww=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cwc+t6W41NFY30yLDPlP41VrpWQ3auScbqTJ8jMsDydOvXK5hHnN+zhPP5KDyNSeE
         Z+UWPDa6IdkBJmo5Pl5LGHGEs8mepYac7Xy8annqUZC0gJMYmm/+iHDyFD1kBLIH6u
         fnOK3qL3qOleet3fuKJj/HINblp2JMPpsS4OPcXpzynwrf7oXM3aVFxI0igyhlms3I
         4IErHg6NoLEhaksl3zLV0jfavw1KOnPJExwCicC8eH+gYtYftxiIss1tGd7B86o//A
         tJ0SY8aQ5CrRDqNq0ZE++1J80qZlnGpDmiAikJL+jKX/CamkdIUQ6pEfI+PojTrejt
         ma5ejNsgY877Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BEEDDEAC09C;
        Thu,  2 Jun 2022 22:39:42 +0000 (UTC)
Subject: Re: [GIT PULL] Documentation fixes for 5.19
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875yliycfi.fsf@meer.lwn.net>
References: <875yliycfi.fsf@meer.lwn.net>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875yliycfi.fsf@meer.lwn.net>
X-PR-Tracked-Remote: git://git.lwn.net/linux.git tags/docs-5.19-2
X-PR-Tracked-Commit-Id: a27e51b45e1bc57f15cffd6b9bfc38efef8cc419
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc
Message-Id: <165420958277.8125.13358709868030337999.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Jun 2022 22:39:42 +0000
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 02 Jun 2022 15:37:21 -0600:

> git://git.lwn.net/linux.git tags/docs-5.19-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50fd82b3a9a9335df5d50c7ddcb81c81d358c4fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
