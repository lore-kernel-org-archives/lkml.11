Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCF0C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 15:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349507AbiCKP7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbiCKP7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16F5F3FD82
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647014310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=YzULi3Mf2x8o0v0/vm+cJ+iGXlkMLGGs801f/kC1Ckw=;
        b=CeJX6BzzFWzv4RzU+3EEcIXqnRcKK7hMORCIeWNVX8oQryz9lxZkWN1oxvUJvig1xsvEO+
        7yLEvwz8xVYoqFeCBepO/D8Cw7NKW4LAn3skzpPmHZs0aQYBlf2gNbR2GbfYFxogAMxsvm
        gTuK+VzpCgA2N/rxy58nKFEYYCwK0Is=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-jEEfoacfOJuXawk_LCI7Sw-1; Fri, 11 Mar 2022 10:58:27 -0500
X-MC-Unique: jEEfoacfOJuXawk_LCI7Sw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC0A71091DA1;
        Fri, 11 Mar 2022 15:58:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8021D7F0DB;
        Fri, 11 Mar 2022 15:58:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix potential thrashing in afs writeback
From:   David Howells <dhowells@redhat.com>
To:     torvalds@linux-foundation.org
Cc:     dhowells@redhat.com, marc.dionne@auristor.com,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 11 Mar 2022 15:58:21 +0000
Message-ID: <164701430151.2588429.8245041241669432969.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In afs_writepages_region(), if the dirty page we find is undergoing
writeback or write to cache, but the sync_mode is WB_SYNC_NONE, we go round
the loop trying the same page again and again with no pausing or waiting
unless and until another thread manages to clear the writeback and fscache
flags.

Fix this with three measures:

 (1) Advance start to after the page we found.

 (2) Break out of the loop and return if rescheduling is requested.

 (3) Arbitrarily give up after a maximum of 5 skips.

Fixes: 31143d5d515e ("AFS: implement basic file write support")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Acked-by: Marc Dionne <marc.dionne@auristor.com>
Link: https://lore.kernel.org/r/164692725757.2097000.2060513769492301854.stgit@warthog.procyon.org.uk/ # v1
---

 fs/afs/write.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index 85c9056ba9fb..bd0201f4939a 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -701,7 +701,7 @@ static int afs_writepages_region(struct address_space *mapping,
 	struct folio *folio;
 	struct page *head_page;
 	ssize_t ret;
-	int n;
+	int n, skips = 0;
 
 	_enter("%llx,%llx,", start, end);
 
@@ -752,8 +752,15 @@ static int afs_writepages_region(struct address_space *mapping,
 #ifdef CONFIG_AFS_FSCACHE
 				folio_wait_fscache(folio);
 #endif
+			} else {
+				start += folio_size(folio);
 			}
 			folio_put(folio);
+			if (wbc->sync_mode == WB_SYNC_NONE) {
+				if (skips >= 5 || need_resched())
+					break;
+				skips++;
+			}
 			continue;
 		}
 


