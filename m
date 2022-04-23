Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1301CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 13:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235636AbiDWNLK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 09:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiDWNLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:11:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E2B28E1B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:08:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EBE1F1F388;
        Sat, 23 Apr 2022 13:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650719286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xWfm7BakUoeVsVVbr6mNUxRV4SUG2JRam42wgGqtYIc=;
        b=lLi+d9yy5DdQq1TLM/gtOzFoULe+auo+MlB7Eb/Vz/ccN+lu+y3HD2Z51wKWEk1aYNuVUf
        BumjDvrMkoyaSoeefg9FcpWDUueGpX5j4RX1D5iHPWNYKIjD05Af3tQo8xPyLRKERrjtmb
        o+y0XW1Qk1LHhO8GyB6nelsfitmTUgI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5EE813AD8;
        Sat, 23 Apr 2022 13:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n3tYKzb6Y2LfdQAAMHmgww
        (envelope-from <jgross@suse.com>); Sat, 23 Apr 2022 13:08:06 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.18-rc4
Date:   Sat, 23 Apr 2022 15:08:06 +0200
Message-Id: <20220423130806.15699-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc4-tag

xen: branch for v5.18-rc4

It contains a simple cleanup patch and a refcount fix for Xen on Arm.

Thanks.

Juergen

 arch/arm/xen/enlighten.c | 9 +++++++--
 drivers/xen/gntalloc.c   | 4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

Alaa Mohamed (1):
      xen: Convert kmap() to kmap_local_page()

Miaoqian Lin (1):
      arm/xen: Fix some refcount leaks
