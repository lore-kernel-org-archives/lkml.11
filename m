Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CC8C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Apr 2022 01:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiDBByK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Apr 2022 21:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiDBByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 21:54:09 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE6D121099
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 18:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2IOznadgyKy/ui5EodindoIw3741NjkdXcIjACRZPL8=; b=uQZoTz7oK2sAF3fENaM1Z4ubTZ
        FEte8jR7XkPzbDyD2dhWltdW07ePGP74j5lo1SZrLQVMlfrmjFJCsC+7L9nx3/ZwuItrD39ELlFGf
        XY407kDdgCznUdqKpuj7bXjUJBCM2Uz63hsMZ7aMwNdoW3oK46GYWkbTkVDpURWF/ctBPPSaL7Ss+
        2eBWAN0C1SlSaS6p7UeGTAXef8HOSi33gL9Yg8eJqrCPfAHA3/GU7JF/eIjiyKA9cMUAkTtf2tibn
        /Tsmua6S2+yI9kEQ7mSsnrmRWuYLNDDl0LzGws+HfAV2L7AruwPw0kAJczDDZQ53Q4XrYruL9ls0o
        WOhl50gQ==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1naSw5-001j9V-RM; Sat, 02 Apr 2022 01:52:17 +0000
Date:   Sat, 2 Apr 2022 01:52:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] vfs.git misc stuff
Message-ID: <YkesUZwCNJcHxIv4@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Assorted bits and pieces.  5.17-rc1-based, one trivial conflict in
arch/x86/um/Kconfig (two selects added here and in mainline next to each other).
Sorry about being that late in cycle with that...

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.misc

for you to fetch changes up to 61e02cdb6ac68a84f1bb95026632d63677f26202:

  aio: drop needless assignment in aio_read() (2022-03-15 19:43:19 -0400)

----------------------------------------------------------------
Al Viro (4):
      constify struct path argument of finish_automount()/do_add_mount()
      asm/user.h: killed unused macros
      uml/x86: use x86 load_unaligned_zeropad()
      clean overflow checks in count_mounts() a bit

Lukas Bulwahn (1):
      aio: drop needless assignment in aio_read()

Maíra Canal (1):
      seq_file: fix NULL pointer arithmetic warning

Tal Zussman (1):
      fs: Remove FIXME comment in generic_write_checks()

 arch/alpha/include/asm/user.h   |  6 ------
 arch/arm/include/asm/user.h     |  4 ----
 arch/h8300/include/asm/user.h   |  4 ----
 arch/ia64/include/asm/user.h    |  6 ------
 arch/m68k/include/asm/user.h    |  4 ----
 arch/powerpc/include/asm/user.h |  5 -----
 arch/s390/include/asm/user.h    |  4 ----
 arch/sh/include/asm/user.h      |  6 ------
 arch/um/include/asm/Kbuild      |  1 -
 arch/x86/include/asm/user_32.h  |  4 ----
 arch/x86/include/asm/user_64.h  |  4 ----
 arch/x86/lib/csum-partial_64.c  | 26 --------------------------
 arch/x86/um/Kconfig             |  1 +
 fs/aio.c                        |  1 -
 fs/internal.h                   |  2 +-
 fs/kernfs/file.c                |  7 +------
 fs/namespace.c                  | 23 ++++++++++++-----------
 fs/read_write.c                 |  1 -
 fs/seq_file.c                   |  4 ++--
 include/linux/seq_file.h        |  1 +
 20 files changed, 18 insertions(+), 96 deletions(-)
