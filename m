Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE78C433EF
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Jul 2022 00:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiGBACq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 20:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiGBACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 20:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701F231380
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 17:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EDD4623F4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 00:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70895C341C7;
        Sat,  2 Jul 2022 00:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656720163;
        bh=biGyzp1Lglan+enLcCay5lxuk5YwGUhOpmrUOlyKpvI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rOsQ/PM/+sW+JJ4VnO0YWPQRwjN14EApB/tWQelg+TGo5dMtG2/OnOXo+J2O76tnS
         twHIBw+5BL96lw85iTz6zDcD3esqEfIxSVvC+XygRsSA3xknfxk/KCb1FFYI4UEAI0
         gDU8VVnofXuwjJyWLNhrZcZIMaEAuG1kilfXK3QdkUKCQY78gNM7RHVI0xv23xdxnm
         rilSgOi2K7AWNTZavx3s/KN1VnSUZvRIgTqCJSWkGtslJ8v1aIwpcyhzPmDFsafwj4
         daFlWz15x7nqXsW5Av0si3L9aqt4kPRzua2DcBBUXMiyr0uFgC3rA2aSv04vP0NryX
         dH4F4WM5Znv3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59F9BE49BB8;
        Sat,  2 Jul 2022 00:02:43 +0000 (UTC)
Subject: Re: [GIT PULL] nvdimm fixes v5.19-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <02c021ee6306877ea63d6db0a314564ac7843882.camel@intel.com>
References: <02c021ee6306877ea63d6db0a314564ac7843882.camel@intel.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <02c021ee6306877ea63d6db0a314564ac7843882.camel@intel.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.19-rc5
X-PR-Tracked-Commit-Id: ef9102004a87cb3f8b26e000a095a261fc0467d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 089866061428ec9bf67221247c936792078c41a4
Message-Id: <165672016336.25386.17573716042798881072.pr-tracker-bot@kernel.org>
Date:   Sat, 02 Jul 2022 00:02:43 +0000
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 1 Jul 2022 23:07:26 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-fixes-5.19-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/089866061428ec9bf67221247c936792078c41a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
