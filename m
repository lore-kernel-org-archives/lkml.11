Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5039BC32793
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:18:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbiHWISg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiHWINd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:13:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB68D6C76A;
        Tue, 23 Aug 2022 01:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74CB8B81C25;
        Tue, 23 Aug 2022 08:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAEEC433C1;
        Tue, 23 Aug 2022 08:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242154;
        bh=BITwDc7HCAhUTG2hPw8EvofbLIg6dJhSahwCDwKFeng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4/dnDGbzE1nT2ce5vxzMD94kgTs12hRsRlmIv4bL83NueaqiXvTVotRm6fB34mrr
         aYWHD2CyeqKierrWoow+J4UYaruK2nxT7V9fa6djpME59W9tLzpCOznOLt4zc8mJ2M
         j5xYV4psuT5VGYgCsouQiGGwW7dceVamVVFWFhrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 028/101] add barriers to buffer_uptodate and set_buffer_uptodate
Date:   Tue, 23 Aug 2022 10:03:01 +0200
Message-Id: <20220823080035.659046535@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080034.579196046@linuxfoundation.org>
References: <20220823080034.579196046@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit d4252071b97d2027d246f6a82cbee4d52f618b47 upstream.

Let's have a look at this piece of code in __bread_slow:

	get_bh(bh);
	bh->b_end_io = end_buffer_read_sync;
	submit_bh(REQ_OP_READ, 0, bh);
	wait_on_buffer(bh);
	if (buffer_uptodate(bh))
		return bh;

Neither wait_on_buffer nor buffer_uptodate contain any memory barrier.
Consequently, if someone calls sb_bread and then reads the buffer data,
the read of buffer data may be executed before wait_on_buffer(bh) on
architectures with weak memory ordering and it may return invalid data.

Fix this bug by adding a memory barrier to set_buffer_uptodate and an
acquire barrier to buffer_uptodate (in a similar way as
folio_test_uptodate and folio_mark_uptodate).

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/buffer_head.h |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -113,7 +113,6 @@ static __always_inline int test_clear_bu
  * of the form "mark_buffer_foo()".  These are higher-level functions which
  * do something in addition to setting a b_state bit.
  */
-BUFFER_FNS(Uptodate, uptodate)
 BUFFER_FNS(Dirty, dirty)
 TAS_BUFFER_FNS(Dirty, dirty)
 BUFFER_FNS(Lock, locked)
@@ -131,6 +130,30 @@ BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
 
+static __always_inline void set_buffer_uptodate(struct buffer_head *bh)
+{
+	/*
+	 * make it consistent with folio_mark_uptodate
+	 * pairs with smp_load_acquire in buffer_uptodate
+	 */
+	smp_mb__before_atomic();
+	set_bit(BH_Uptodate, &bh->b_state);
+}
+
+static __always_inline void clear_buffer_uptodate(struct buffer_head *bh)
+{
+	clear_bit(BH_Uptodate, &bh->b_state);
+}
+
+static __always_inline int buffer_uptodate(const struct buffer_head *bh)
+{
+	/*
+	 * make it consistent with folio_test_uptodate
+	 * pairs with smp_mb__before_atomic in set_buffer_uptodate
+	 */
+	return (smp_load_acquire(&bh->b_state) & (1UL << BH_Uptodate)) != 0;
+}
+
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
 /* If we *know* page->private refers to buffer_heads */


