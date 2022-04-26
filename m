Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94033C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 08:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbiDZIia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 04:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345517AbiDZIel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:34:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EF578928;
        Tue, 26 Apr 2022 01:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C587EB81A2F;
        Tue, 26 Apr 2022 08:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3394BC385A0;
        Tue, 26 Apr 2022 08:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650961651;
        bh=Wgd36B5rjC5/ZHNoZuT+EVys1kOLNjl1nZr2tmHVyXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IyzQG7MDEsrk00dbVINB6OWteuS2qv0XG8cFthcLoJi7NK7NcKYXiwV1VPVqAp5u7
         tciKl/6QpYxTRW4e3WsP4FdJf7kCGT9/7ekdJ3I/a0mhpemZRzB4ZsYw9nhGfvfBrN
         j9HwIp8Uk070iUSqKP8EKfOfUUs81pWIN4gge72s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, stable@kernel.org,
        Ye Bin <yebin10@huawei.com>, Jan Kara <jack@suse.cz>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.19 39/53] ext4: fix symlink file size not match to file content
Date:   Tue, 26 Apr 2022 10:21:19 +0200
Message-Id: <20220426081736.794937216@linuxfoundation.org>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220426081735.651926456@linuxfoundation.org>
References: <20220426081735.651926456@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

commit a2b0b205d125f27cddfb4f7280e39affdaf46686 upstream.

We got issue as follows:
[home]# fsck.ext4  -fn  ram0yb
e2fsck 1.45.6 (20-Mar-2020)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Symlink /p3/d14/d1a/l3d (inode #3494) is invalid.
Clear? no
Entry 'l3d' in /p3/d14/d1a (3383) has an incorrect filetype (was 7, should be 0).
Fix? no

As the symlink file size does not match the file content. If the writeback
of the symlink data block failed, ext4_finish_bio() handles the end of IO.
However this function fails to mark the buffer with BH_write_io_error and
so when unmount does journal checkpoint it cannot detect the writeback
error and will cleanup the journal. Thus we've lost the correct data in the
journal area. To solve this issue, mark the buffer as BH_write_io_error in
ext4_finish_bio().

Cc: stable@kernel.org
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321144438.201685-1-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/page-io.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -105,8 +105,10 @@ static void ext4_finish_bio(struct bio *
 				continue;
 			}
 			clear_buffer_async_write(bh);
-			if (bio->bi_status)
+			if (bio->bi_status) {
+				set_buffer_write_io_error(bh);
 				buffer_io_error(bh);
+			}
 		} while ((bh = bh->b_this_page) != head);
 		bit_spin_unlock(BH_Uptodate_Lock, &head->b_state);
 		local_irq_restore(flags);


