Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45742C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 01:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1845445AbiDFByu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 21:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443707AbiDEPkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CED184B6D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41E31B81D2F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F95C385A7;
        Tue,  5 Apr 2022 13:58:11 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
Subject: [PATCH 04/10] drivers/md: Use ARCH_DMA_MINALIGN instead of ARCH_KMALLOC_MINALIGN
Date:   Tue,  5 Apr 2022 14:57:52 +0100
Message-Id: <20220405135758.774016-5-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405135758.774016-1-catalin.marinas@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ARCH_DMA_MINALIGN represents the minimum (static) alignment for safe DMA
operations while ARCH_KMALLOC_MINALIGN is the minimum kmalloc() objects
alignment.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index fb80539865d7..b6929dd1d283 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -3250,7 +3250,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	cc->per_bio_data_size = ti->per_io_data_size =
 		ALIGN(sizeof(struct dm_crypt_io) + cc->dmreq_start + additional_req_size,
-		      ARCH_KMALLOC_MINALIGN);
+		      ARCH_DMA_MINALIGN);
 
 	ret = mempool_init(&cc->page_pool, BIO_MAX_VECS, crypt_page_alloc, crypt_page_free, cc);
 	if (ret) {
