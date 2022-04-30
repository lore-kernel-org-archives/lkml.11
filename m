Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFE4C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Apr 2022 15:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382968AbiD3P5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Apr 2022 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383003AbiD3P46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 11:56:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE2A6949F
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 08:53:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB8C2B800E2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 15:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED49C385AA;
        Sat, 30 Apr 2022 15:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651334009;
        bh=qbkGyalylzrpJ5ERJKkap+/1LWrx4g4LKwfa/l25gZY=;
        h=Date:From:To:Cc:Subject:From;
        b=1Z1p+TBEh5R7JlZUBAEdfi4Z+Z9QlUh07jdVvvihP6WyAVzS0ELe4oVEdDGSH+hHG
         gYO3cJXT83ytiBtrIZ4NJshFUN/prLXwEE9kZ6QyO/vGKr+BJ0RD+FSWNAKrHUUpO0
         Ban5QHLgdGljwZKyyS5eBCWJHiB2DGv++j9tqbqI=
Date:   Sat, 30 Apr 2022 17:53:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 5.18-rc5
Message-ID: <Ym1bduXu4c5Qt5LA@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc5

for you to fetch changes up to ad8d869343ae4a07a2038a4ca923f699308c8323:

  kernfs: fix NULL dereferencing in kernfs_remove (2022-04-27 19:32:07 +0200)

----------------------------------------------------------------
Driver core fixes for 5.18-rc5

Here are some small driver core and kernfs fixes for some reported
problems.  They include:
	- kernfs regression that is causing oopses in 5.17 and newer
	  releases
	- topology sysfs fixes for a few small reported problems.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Darren Hart (1):
      topology: make core_mask include at least cluster_siblings

Greg Kroah-Hartman (1):
      topology: Fix up build warning in topology_is_visible()

Minchan Kim (1):
      kernfs: fix NULL dereferencing in kernfs_remove

Tony Luck (1):
      topology/sysfs: Hide PPIN on systems that do not support it.

Wang Qing (1):
      arch_topology: Do not set llc_sibling if llc_id is invalid

 drivers/base/arch_topology.c | 11 ++++++++++-
 drivers/base/topology.c      | 10 ++++++++++
 fs/kernfs/dir.c              |  7 ++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)
