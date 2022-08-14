Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4C1C25B06
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Aug 2022 09:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbiHNJHm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Aug 2022 05:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHNJHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 05:07:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC127FF9
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 02:07:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8BA264E2C7;
        Sun, 14 Aug 2022 09:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660468058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=/3Itj9Hk+TVagievoSV8p71OSN6sgi+RAOHLldUn2iU=;
        b=Uo/EOJFuGWq+iBJpjLWEyshbgqqhKTVtzIu1csCK3zPWitdkuZClRMx7YwCpXQA9QFVe7n
        CXawCqgEvMYe1wLakKBAulnAYgkGelCplXyHVbG1FZpoRzfKWov8Hm/YueGyQVbXLlwe/P
        hLSClo8XxQIqjKjG9zAdytlctXDCxsM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6119213AAE;
        Sun, 14 Aug 2022 09:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ydY+Flq7+GJ2PgAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 14 Aug 2022 09:07:38 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        sstabellini@kernel.org
Subject: [GIT PULL] xen: 2nd round of patches for 6.0-rc1
Date:   Sun, 14 Aug 2022 11:07:37 +0200
Message-Id: <20220814090737.29335-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc1b-tag

xen: 2nd round of patches for 6.0-rc1

It contains the following patches:

- a series for fixing the handling of the "persistent grants" feature
  negotiation between Xen blkfront and Xen blkback drivers

- a cleanup of xen.config and adding xen.config to Xen section in
  MAINTAINERS

- a patch for supporting HVMOP_set_evtchn_upcall_vector, which is more
  compliant to "normal" interrupt handling than the global callback used
  up to now

- 2 further small cleanups

Thanks.

Juergen

 Documentation/ABI/testing/sysfs-driver-xen-blkback |  2 +-
 .../ABI/testing/sysfs-driver-xen-blkfront          |  2 +-
 MAINTAINERS                                        |  2 +
 arch/x86/include/asm/xen/cpuid.h                   |  2 +
 arch/x86/include/asm/xen/events.h                  |  3 +-
 arch/x86/xen/enlighten.c                           |  2 +-
 arch/x86/xen/enlighten_hvm.c                       | 24 +++++++---
 arch/x86/xen/suspend_hvm.c                         | 10 +++-
 drivers/block/xen-blkback/xenbus.c                 | 20 ++++----
 drivers/block/xen-blkfront.c                       |  4 +-
 drivers/xen/events/events_base.c                   | 53 +++++++++++++++++++---
 drivers/xen/xen-pciback/pciback_ops.c              |  2 +-
 drivers/xen/xenbus/xenbus_dev_frontend.c           |  4 +-
 include/xen/hvm.h                                  |  2 +
 include/xen/interface/hvm/hvm_op.h                 | 19 ++++++++
 kernel/configs/xen.config                          |  1 -
 16 files changed, 116 insertions(+), 36 deletions(-)

Dan Carpenter (1):
      xen/xenbus: fix return type in xenbus_file_read()

Jane Malalane (1):
      x86/xen: Add support for HVMOP_set_evtchn_upcall_vector

Jason Wang (1):
      xen/pciback: Fix comment typo

Lukas Bulwahn (2):
      xen: remove XEN_SCRUB_PAGES in xen.config
      MAINTAINERS: add xen config fragments to XEN HYPERVISOR sections

Maximilian Heyne (1):
      xen-blkback: Apply 'feature_persistent' parameter when connect

SeongJae Park (2):
      xen-blkback: fix persistent grants negotiation
      xen-blkfront: Apply 'feature_persistent' parameter when connect
