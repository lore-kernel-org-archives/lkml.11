Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D4EC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 16:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbiERQnU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 12:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbiERQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 12:43:13 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5152D60AB7;
        Wed, 18 May 2022 09:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Juc744IBDe0/YlnjwfVrcCw9F1+WRXzjcPzfaEDrEQs=; b=u95C2A0MeWd+0tomPwWSEfB5Vx
        odYGsMh6kbUIWaOqxhRSdu76ciEwYQrqo3YTYW3y4s9PwYR/crfV++hRzQ6+eiwHnfnurAiAtyYyB
        FthrILmgkwA0QCV5u1x0Yfx7vG5f1dungjyRGRZk3rOthSqpeSmcP3XHUzB3dx1tnZ5NGUo9wvdt1
        1ouqD+oUS2l51PXGtMtNUHR7pOpfRnynPsZtB3+PWkcCpi2AvSZFgy9Mi2mcZGwVIUQCaReX2hVk2
        pC/xsN9ZiDMqL6yGhVV3Q0ie0IN0GYsBXlGk53wV9gARinfmX6e6jZDWi4okMXYHGtHcqnh9pvS/k
        /qBnPgFQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrMlS-00G4od-SG; Wed, 18 May 2022 16:43:11 +0000
Date:   Wed, 18 May 2022 16:43:10 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [git pull] a couple of fixes
Message-ID: <YoUiHhz1NsTbN5Vo@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	vhost race fix + percpu_ref_init-caused cgroup double-free fix
(the latter had manifested as buggered struct mount refcounting -
those are also using percpu data structures, but anything that does
percpu allocations could be hit)

The following changes since commit feb9c5e19e913b53cb536a7aa7c9f20107bb51ec:

  Merge tag 'for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost (2022-05-10 11:15:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes

for you to fetch changes up to fb4554c2232e44d595920f4d5c66cf8f7d13f9bc:

  Fix double fget() in vhost_net_set_backend() (2022-05-18 12:33:51 -0400)

----------------------------------------------------------------
Al Viro (2):
      percpu_ref_init(): clean ->percpu_count_ref on failure
      Fix double fget() in vhost_net_set_backend()

 drivers/vhost/net.c   | 15 +++++++--------
 lib/percpu-refcount.c |  1 +
 2 files changed, 8 insertions(+), 8 deletions(-)
