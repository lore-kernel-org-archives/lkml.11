Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16F2CCA47C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 07:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242523AbiFCHf1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 03:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242596AbiFCHfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 03:35:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1585E1DA5B;
        Fri,  3 Jun 2022 00:34:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 784151F8AE;
        Fri,  3 Jun 2022 07:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654241698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=j7Ww7cKCif3bOsw9nkqMS3BtrJ26nS6Z6FXIoNR0jpQ=;
        b=oxPMfFD9UnHIqHEMVYa+A/rDi+lEg2/rOilAxQb91rBOIGs+WQy3unBKE0vPYtMctoFn/z
        /09HiNPJL2ckjhbJZY92zXoQZuZl1HU5yD3dxTvBWm15OPpITg6LRzkdOsFD2Q/bCCPEB9
        0M12dN1UVy9PBuAqXUCCzZkNPxKFIVg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2439413B11;
        Fri,  3 Jun 2022 07:34:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pJX7BaK5mWKOVQAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 03 Jun 2022 07:34:58 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] pipe: Remove redundant zeroing of pipe->offset
Date:   Fri,  3 Jun 2022 10:34:56 +0300
Message-Id: <20220603073456.311724-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This member is already set to 0 for the newly initialized buffer, no
need to duplicate the operation.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/pipe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 74ae9fafd25a..56950aa850be 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -536,7 +536,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 				break;
 			}
 			ret += copied;
-			buf->offset = 0;
 			buf->len = copied;
 
 			if (!iov_iter_count(from))
-- 
2.25.1

