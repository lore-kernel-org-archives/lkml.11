Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5873C4167E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 11:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377148AbiDEL1r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 07:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242793AbiDEItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:49:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B551F75611;
        Tue,  5 Apr 2022 01:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36B6F614E9;
        Tue,  5 Apr 2022 08:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E11C385A0;
        Tue,  5 Apr 2022 08:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147855;
        bh=zmHctF1XS8pTSyItRcY2jAqHaGIbjUzahCepRrZqcSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhfroRnmsZNxUZTj4mIkAPHHRSWeX8/VXp6uHjwEkdZHm7L6Uagfot74akyiPQN0G
         sjXb9sd47jqeF/JFccQzGlNUQNbDCRtDIXlnOroNcGzxS7uuq7fvIvvkKmuMMmOJ06
         4M959k4+CaR6ub0Hbh90AUZXF+udgjXkJ/a4lMik=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.16 0145/1017] btrfs: zoned: put block group after final usage
Date:   Tue,  5 Apr 2022 09:17:38 +0200
Message-Id: <20220405070358.507991164@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070354.155796697@linuxfoundation.org>
References: <20220405070354.155796697@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Borisov <nborisov@suse.com>

commit d3e29967079c522ce1c5cab0e9fab2c280b977eb upstream.

It's counter-intuitive (and wrong) to put the block group _before_ the
final usage in submit_eb_page. Fix it by re-ordering the call to
btrfs_put_block_group after its final reference. Also fix a minor typo
in 'implies'

Fixes: be1a1d7a5d24 ("btrfs: zoned: finish fully written block group")
CC: stable@vger.kernel.org # 5.16+
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4800,11 +4800,12 @@ static int submit_eb_page(struct page *p
 		return ret;
 	}
 	if (cache) {
-		/* Impiles write in zoned mode */
-		btrfs_put_block_group(cache);
-		/* Mark the last eb in a block group */
+		/*
+		 * Implies write in zoned mode. Mark the last eb in a block group.
+		 */
 		if (cache->seq_zone && eb->start + eb->len == cache->zone_capacity)
 			set_bit(EXTENT_BUFFER_ZONE_FINISH, &eb->bflags);
+		btrfs_put_block_group(cache);
 	}
 	ret = write_one_eb(eb, wbc, epd);
 	free_extent_buffer(eb);


