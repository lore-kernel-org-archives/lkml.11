Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A6C47080
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 14:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345419AbiCJOlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245465AbiCJOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:30:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E83180218;
        Thu, 10 Mar 2022 06:26:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30BF1B82615;
        Thu, 10 Mar 2022 14:26:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6DEC340E8;
        Thu, 10 Mar 2022 14:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646922374;
        bh=MfHU0Kwo0xA5jQW28E3BI2IOIWOZWlLewPFWs+uMccc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vLNi7cVzw8Yv8g+1ZqEdppnF6OdCJlf4H21GOaEBd3mkHnJfUDAHE/d6MPsUTmBUO
         lXbyBZAWsmxY6IotBlYSSqaruwgb6hQnhzIyBEzLkNJs7tW0utAETRG/uYoPL1X4NS
         O0ElGum20UYtEZmRgz5WuXhfv27PvJ92aohEdtBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Simon Gaiser <simon@invisiblethingslab.com>,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 5.10 55/58] xen/pvcalls: use alloc/free_pages_exact()
Date:   Thu, 10 Mar 2022 15:19:15 +0100
Message-Id: <20220310140814.433062031@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310140812.869208747@linuxfoundation.org>
References: <20220310140812.869208747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

Commit b0576cc9c6b843d99c6982888d59a56209341888 upstream.

Instead of __get_free_pages() and free_pages() use alloc_pages_exact()
and free_pages_exact(). This is in preparation of a change of
gnttab_end_foreign_access() which will prohibit use of high-order
pages.

This is part of CVE-2022-23041 / XSA-396.

Reported-by: Simon Gaiser <simon@invisiblethingslab.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/xen/pvcalls-front.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -337,8 +337,8 @@ static void free_active_ring(struct sock
 	if (!map->active.ring)
 		return;
 
-	free_pages((unsigned long)map->active.data.in,
-			map->active.ring->ring_order);
+	free_pages_exact(map->active.data.in,
+			 PAGE_SIZE << map->active.ring->ring_order);
 	free_page((unsigned long)map->active.ring);
 }
 
@@ -352,8 +352,8 @@ static int alloc_active_ring(struct sock
 		goto out;
 
 	map->active.ring->ring_order = PVCALLS_RING_ORDER;
-	bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					PVCALLS_RING_ORDER);
+	bytes = alloc_pages_exact(PAGE_SIZE << PVCALLS_RING_ORDER,
+				  GFP_KERNEL | __GFP_ZERO);
 	if (!bytes)
 		goto out;
 


