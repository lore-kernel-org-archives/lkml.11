Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09D2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 08:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347463AbiEEIU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 04:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346977AbiEEIUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:20:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7D749688
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:16:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4AF8C210DF;
        Thu,  5 May 2022 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651738604; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=97UDNK1f7czhnU/2ak2EMjgJM9WmcipgW6hepwuQnLg=;
        b=TIGROP5NtrO/PMKocRwXDq4uW8i352wOc1Z8dfJPBykWG1KVaUs1y2V2ugsyPQNmx7HW7A
        7YEaBEYBaDKYEspokFV4o5IqKEomEss+SP90j3p4SJQhRp2HPvh7OngYWLnofHdSf1J4/b
        gKvNZ3TxKDt4H8fjI3G6ZJ0tlhzkvPg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CCDA13B11;
        Thu,  5 May 2022 08:16:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8JqSBeyHc2K1BwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 05 May 2022 08:16:44 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v3 02/21] xen/grant-table: never put a reserved grant on the free list
Date:   Thu,  5 May 2022 10:16:21 +0200
Message-Id: <20220505081640.17425-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220505081640.17425-1-jgross@suse.com>
References: <20220505081640.17425-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure a reserved grant is never put on the free list, as this could
cause hard to debug errors.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V3:
- new patch
---
 drivers/xen/grant-table.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/grant-table.c b/drivers/xen/grant-table.c
index 6ea31ea26008..1a1aec0a88a1 100644
--- a/drivers/xen/grant-table.c
+++ b/drivers/xen/grant-table.c
@@ -207,6 +207,10 @@ static inline void check_free_callbacks(void)
 static void put_free_entry(grant_ref_t ref)
 {
 	unsigned long flags;
+
+	if (unlikely(ref < GNTTAB_NR_RESERVED_ENTRIES))
+		return;
+
 	spin_lock_irqsave(&gnttab_list_lock, flags);
 	gnttab_entry(ref) = gnttab_free_head;
 	gnttab_free_head = ref;
-- 
2.35.3

