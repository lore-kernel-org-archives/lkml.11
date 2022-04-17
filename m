Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699B0C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Apr 2022 08:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbiDQITM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Apr 2022 04:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233603AbiDQITK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 04:19:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6742AE06
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 01:16:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6DBB81F756;
        Sun, 17 Apr 2022 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650183393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=8hA3P47WmX5/EGYFrm5XFq7kqAZ1F4M1ZIzKycvSpTo=;
        b=o9CfhqReKWVWM271Udk/wEwqeAl4nvA017R8Kqn4LvU5KbDTv58bxQJTwxW4AEW8mE81UB
        gNwJKgLmswA4e/exU6isnZravzoepT3FO4n33kSn8/Cv+sMdiPa4viOh3buEA2fSRfm5W2
        jx9l/HVrSPG5OiTgDV/c0y3en01EPVY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3667D13216;
        Sun, 17 Apr 2022 08:16:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v4REC+HMW2LTXAAAMHmgww
        (envelope-from <jgross@suse.com>); Sun, 17 Apr 2022 08:16:33 +0000
From:   Juergen Gross <jgross@suse.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com
Subject: [GIT PULL] xen: branch for v5.18-rc3
Date:   Sun, 17 Apr 2022 10:16:32 +0200
Message-Id: <20220417081632.11230-1-jgross@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please git pull the following tag:

 git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-5.18-rc3-tag

xen: branch for v5.18-rc3

It contains just a single cleanup patch for the Xen balloon driver.


Thanks.

Juergen

 drivers/xen/balloon.c           | 54 ++++++++++++++++++-----------------------
 drivers/xen/unpopulated-alloc.c | 33 -------------------------
 2 files changed, 23 insertions(+), 64 deletions(-)

Juergen Gross (1):
      xen/balloon: don't use PV mode extra memory for zone device allocations
