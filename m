Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBACC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 13:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376958AbiFMNZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 09:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377497AbiFMNUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 09:20:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6C76B036;
        Mon, 13 Jun 2022 04:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31506B80D3A;
        Mon, 13 Jun 2022 11:23:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88C9EC3411C;
        Mon, 13 Jun 2022 11:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655119396;
        bh=oQaEf7TcFQLf12PeD593fPUkHJ8E0yg6lQV1dyKGqcI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZyRq+xpoDvLl625dfG9T5k3YzAoLDjvkSGuRHjk4jAS96IBQhTCNuYms1J3Fhtg+
         atul8fOcnIVR4Sm9MbG0XlwaEIwvTuF+JPrF/FBmmtJzv2Vs7D1LcHsbQbUUwwdMHl
         k3dyp0zcurmyGmzG9M4+H1bEkHAzLJyiXKSbRFKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5.15 247/247] zonefs: fix handling of explicit_open option on mount
Date:   Mon, 13 Jun 2022 12:12:29 +0200
Message-Id: <20220613094930.437208619@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220613094922.843438024@linuxfoundation.org>
References: <20220613094922.843438024@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

commit a2a513be7139b279f1b5b2cee59c6c4950c34346 upstream.

Ignoring the explicit_open mount option on mount for devices that do not
have a limit on the number of open zones must be done after the mount
options are parsed and set in s_mount_opts. Move the check to ignore
the explicit_open option after the call to zonefs_parse_options() in
zonefs_fill_super().

Fixes: b5c00e975779 ("zonefs: open/close zone on file open/close")
Cc: <stable@vger.kernel.org>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/zonefs/super.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -1694,11 +1694,6 @@ static int zonefs_fill_super(struct supe
 	sbi->s_mount_opts = ZONEFS_MNTOPT_ERRORS_RO;
 	sbi->s_max_open_zones = bdev_max_open_zones(sb->s_bdev);
 	atomic_set(&sbi->s_open_zones, 0);
-	if (!sbi->s_max_open_zones &&
-	    sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
-		zonefs_info(sb, "No open zones limit. Ignoring explicit_open mount option\n");
-		sbi->s_mount_opts &= ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
-	}
 
 	ret = zonefs_read_super(sb);
 	if (ret)
@@ -1717,6 +1712,12 @@ static int zonefs_fill_super(struct supe
 	zonefs_info(sb, "Mounting %u zones",
 		    blkdev_nr_zones(sb->s_bdev->bd_disk));
 
+	if (!sbi->s_max_open_zones &&
+	    sbi->s_mount_opts & ZONEFS_MNTOPT_EXPLICIT_OPEN) {
+		zonefs_info(sb, "No open zones limit. Ignoring explicit_open mount option\n");
+		sbi->s_mount_opts &= ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
+	}
+
 	/* Create root directory inode */
 	ret = -ENOMEM;
 	inode = new_inode(sb);


