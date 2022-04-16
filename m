Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB0C4332F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 13:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbiDPNRz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 09:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiDPNRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 09:17:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4590721816
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 06:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5A64B80687
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 13:15:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD0EC385A1;
        Sat, 16 Apr 2022 13:15:18 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="aynd3gVJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1650114916;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eMdzqQZDddHB/OEg4b6bfSG+6AFrNXMzb0GZKmbygIE=;
        b=aynd3gVJkKkLkZpAbOBhVV5uXyrvFzdIim9JWwrXk0D0jOyQuUEFrTxEVYj5LH2TZ7iASr
        u02ovu1JZLYlovYrkciAC12d4lt8PYEB4o6zeul7+TsMbnMmMM/CmOW8JYGYwHLRYnoYql
        0FZwTHTs04HkUR4V6IdEKSm8zP4BBUg=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 19f3db18 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 16 Apr 2022 13:15:16 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] random number generator fixes for 5.18-rc3
Date:   Sat, 16 Apr 2022 15:13:18 +0200
Message-Id: <20220416131318.80278-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following three fixes to the RNG for 5.18-rc3:

- Per your suggestion, random reads now won't fail if there's a page fault
  after some non-zero amount of data has been read, which makes the behavior
  consistent with all other reads in the kernel.

- Rather than an inconsistent mix of random_get_entropy() returning an
  unsigned long or a cycles_t, now it just returns an unsigned long.

- A memcpy() was replaced with an memmove(), because the addresses are
  sometimes overlapping. In practice the destination is always before the
  source, so not really an issue, but better to be correct than not.

Thanks,
Jason

The following changes since commit a19944809fe9942e6a96292490717904d0690c21:

  Merge tag 'hardening-v5.18-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux (2022-04-12 14:29:40 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-5.18-rc3-for-linus

for you to fetch changes up to 35a33ff3807d3adb9daaf937f5bca002ffa9f84e:

  random: use memmove instead of memcpy for remaining 32 bytes (2022-04-16 12:53:31 +0200)

----------------------------------------------------------------
Random number generator fixes for Linux 5.18-rc3.
----------------------------------------------------------------

Jason A. Donenfeld (3):
      random: allow partial reads if later user copies fail
      random: make random_get_entropy() return an unsigned long
      random: use memmove instead of memcpy for remaining 32 bytes

 drivers/char/random.c | 44 ++++++++++++++++++++------------------------
 include/linux/timex.h |  2 +-
 2 files changed, 21 insertions(+), 25 deletions(-)
