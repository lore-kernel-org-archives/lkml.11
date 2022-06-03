Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE452C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 12:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244408AbiFCMri (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 08:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244389AbiFCMre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:47:34 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E31EBC81
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:47:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 57095609B3C1;
        Fri,  3 Jun 2022 14:47:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zgza6Iw92Vaj; Fri,  3 Jun 2022 14:47:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 087F2609B3C2;
        Fri,  3 Jun 2022 14:47:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id cfWZlBJTWb8r; Fri,  3 Jun 2022 14:47:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id DEAC7609B3C1;
        Fri,  3 Jun 2022 14:47:30 +0200 (CEST)
Date:   Fri, 3 Jun 2022 14:47:30 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1471475855.130153.1654260450880.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML updates for v5.19-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: 3VceN5utQRUfs6JID6rD6pLjE6sKbQ==
Thread-Topic: UML updates for v5.19-rc1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.19-rc1

for you to fetch changes up to 2a4a62a14be1947fa945c5c11ebf67326381a568:

  um: Fix out-of-bounds read in LDT setup (2022-05-27 09:03:41 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Various cleanups and fixes: xterm, serial line, time travel
- Set ARCH_HAS_GCOV_PROFILE_ALL

----------------------------------------------------------------
Johannes Berg (6):
      um: xterm: Make default terminal emulator configurable
      um: daemon: Make default socket configurable
      um: Use asm-generic/dma-mapping.h
      um: line: Use separate IRQs per line
      um: virtio_uml: Fix broken device handling in time-travel
      um: chan_user: Fix winch_tramp() return value

Vincent Whitchurch (2):
      um: Enable ARCH_HAS_GCOV_PROFILE_ALL
      um: Fix out-of-bounds read in LDT setup

 arch/um/Kconfig                 |  1 +
 arch/um/drivers/Kconfig         | 15 +++++++++++++++
 arch/um/drivers/Makefile        |  2 ++
 arch/um/drivers/chan_kern.c     | 10 +++++-----
 arch/um/drivers/chan_user.c     |  9 +++++----
 arch/um/drivers/daemon_kern.c   |  2 +-
 arch/um/drivers/line.c          | 22 +++++++++++++---------
 arch/um/drivers/line.h          |  4 ++--
 arch/um/drivers/ssl.c           |  2 --
 arch/um/drivers/stdio_console.c |  2 --
 arch/um/drivers/virtio_uml.c    | 33 +++++++++++++++++++++++----------
 arch/um/drivers/xterm.c         |  7 ++++---
 arch/um/include/asm/Kbuild      |  1 +
 arch/um/include/asm/irq.h       | 22 +++++++++-------------
 arch/x86/um/ldt.c               |  6 ++++--
 15 files changed, 85 insertions(+), 53 deletions(-)
