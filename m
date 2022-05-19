Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513F9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 14:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbiESONw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbiESONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:13:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ABE9C69B72
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652969626;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=eqceAlLkIRMC8r2OIaYK/mnLWCgm8RT+DPdsKKlVtj4=;
        b=QiI6rIE8UUrEjAuHQPgdeI4rG4gXmtFTnUNrPJXfZ1m8UiqMofApPqlSxdKgXwyjY32dnX
        BxTFYwH0SQGERBigY2rtvPScO/VghUmfk/w4WwlVjTGVTWwDJmEYq0WY+lqZ/1/PX7Yzsl
        b/Maq8ETa6p15NsaCrfPs0A/I2D2G6I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-398-fezXsucJNYCFMZKMCQ_UFg-1; Thu, 19 May 2022 10:13:45 -0400
X-MC-Unique: fezXsucJNYCFMZKMCQ_UFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1F9A1C0514E;
        Thu, 19 May 2022 14:13:44 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4CC152026D6A;
        Thu, 19 May 2022 14:13:44 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] afs: Fix some checker issues
From:   David Howells <dhowells@redhat.com>
To:     marc.dionne@auristor.com
Cc:     dhowells@redhat.com, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 19 May 2022 15:13:43 +0100
Message-ID: <165296962354.3594744.4899296486173782654.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unused global variable and make another static as reported by
make C=1.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

 fs/afs/volume.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index 94a3d247924b..cc665cef0abe 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -9,8 +9,7 @@
 #include <linux/slab.h>
 #include "internal.h"
 
-unsigned __read_mostly afs_volume_gc_delay = 10;
-unsigned __read_mostly afs_volume_record_life = 60 * 60;
+static unsigned __read_mostly afs_volume_record_life = 60 * 60;
 
 /*
  * Insert a volume into a cell.  If there's an existing volume record, that is


