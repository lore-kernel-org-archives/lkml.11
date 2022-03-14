Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF57C47088
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 12:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245585AbiCNMdP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243945AbiCNMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 08:21:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6C613D33;
        Mon, 14 Mar 2022 05:19:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06DD360C70;
        Mon, 14 Mar 2022 12:19:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF056C340E9;
        Mon, 14 Mar 2022 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647260355;
        bh=/ysTpHMR/qo7lmvua99zXU/quYDGz2gZ/U7+mWVtzZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CS3V/gc+DzlmRi4TpMUzUTPlEEi67rhn3pOYUahvXe1WOQZb4UhxYm5BhzE42bfCS
         SA1E0kXq2ygQ2ybCDimovDFjNXvD79/2PVN/7jWwhlnU5Pl9uyCq7n2fVXxpNepE8G
         8AWSUNVYPGMVtKbktAx1Vj0K4oXVDviQ6FU6+n6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.16 109/121] watch_queue: Fix the alloc bitmap size to reflect notes allocated
Date:   Mon, 14 Mar 2022 12:54:52 +0100
Message-Id: <20220314112747.152601399@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112744.120491875@linuxfoundation.org>
References: <20220314112744.120491875@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Howells <dhowells@redhat.com>

commit 3b4c0371928c17af03e8397ac842346624017ce6 upstream.

Currently, watch_queue_set_size() sets the number of notes available in
wqueue->nr_notes according to the number of notes allocated, but sets
the size of the bitmap to the unrounded number of notes originally asked
for.

Fix this by setting the bitmap size to the number of notes we're
actually going to make available (ie. the number allocated).

Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/watch_queue.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -244,6 +244,7 @@ long watch_queue_set_size(struct pipe_in
 		goto error;
 	}
 
+	nr_notes = nr_pages * WATCH_QUEUE_NOTES_PER_PAGE;
 	ret = pipe_resize_ring(pipe, roundup_pow_of_two(nr_notes));
 	if (ret < 0)
 		goto error;
@@ -269,7 +270,7 @@ long watch_queue_set_size(struct pipe_in
 	wqueue->notes = pages;
 	wqueue->notes_bitmap = bitmap;
 	wqueue->nr_pages = nr_pages;
-	wqueue->nr_notes = nr_pages * WATCH_QUEUE_NOTES_PER_PAGE;
+	wqueue->nr_notes = nr_notes;
 	return 0;
 
 error_p:


