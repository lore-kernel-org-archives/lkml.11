Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6C2C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 17:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbiB1R3j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 12:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbiB1R1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 12:27:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13A389CD1;
        Mon, 28 Feb 2022 09:26:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36D256136E;
        Mon, 28 Feb 2022 17:26:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BC70C340E7;
        Mon, 28 Feb 2022 17:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646069217;
        bh=9K0UzSGCz4nli94eISe4QfoPGkKsQJl3zLABJrN/GYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1Qlmp3mEsOZnnf4UfibwNASnU0uY+sMO7di4hnGf1EXU1Q+M7VRhc+wcpmyBna/f3
         VW3BH4+v1BxZUd2pnhxNp1uC6Zo1pXzcz55pFNWbd5uF3ya1HDY6ZrI1sFXzkO4yYH
         TK7/o5QRne2mZalu7YRDZA8Rm/X6j+WEiugAjV1U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 4.9 28/29] memblock: use kfree() to release kmalloced memblock regions
Date:   Mon, 28 Feb 2022 18:23:55 +0100
Message-Id: <20220228172144.473893436@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220228172141.744228435@linuxfoundation.org>
References: <20220228172141.744228435@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

commit c94afc46cae7ad41b2ad6a99368147879f4b0e56 upstream.

memblock.{reserved,memory}.regions may be allocated using kmalloc() in
memblock_double_array(). Use kfree() to release these kmalloced regions
indicated by memblock_{reserved,memory}_in_slab.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Fixes: 3010f876500f ("mm: discard memblock data later")
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/memblock.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -272,14 +272,20 @@ void __init memblock_discard(void)
 		addr = __pa(memblock.reserved.regions);
 		size = PAGE_ALIGN(sizeof(struct memblock_region) *
 				  memblock.reserved.max);
-		__memblock_free_late(addr, size);
+		if (memblock_reserved_in_slab)
+			kfree(memblock.reserved.regions);
+		else
+			__memblock_free_late(addr, size);
 	}
 
 	if (memblock.memory.regions != memblock_memory_init_regions) {
 		addr = __pa(memblock.memory.regions);
 		size = PAGE_ALIGN(sizeof(struct memblock_region) *
 				  memblock.memory.max);
-		__memblock_free_late(addr, size);
+		if (memblock_memory_in_slab)
+			kfree(memblock.memory.regions);
+		else
+			__memblock_free_late(addr, size);
 	}
 }
 #endif


