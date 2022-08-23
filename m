Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE1C32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbiHWIju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344526AbiHWIjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:39:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5BC263D;
        Tue, 23 Aug 2022 01:18:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4176E61344;
        Tue, 23 Aug 2022 08:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4558BC433C1;
        Tue, 23 Aug 2022 08:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242694;
        bh=irptwIDxqF2pKji92Dk04MOvhgeuIDxlQ8Rc8roUWe8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pl6XJIo0KsjbGmuwVD4FNVtUUCgcnzabNOFEfs4LEvenfE4en1oX6T7tMF/oNTLw3
         rLHr4WdtUmGlhM9bl7js7CZV3H364DgiEtATG9r4GWZrMRxSplPbBp330M85MeyL6x
         LgiXUqPG/ks9GvNDI884s22lhAOrYvOSFfeMOMgA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH 5.19 163/365] fs/ntfs3: Fix double free on remount
Date:   Tue, 23 Aug 2022 10:01:04 +0200
Message-Id: <20220823080125.031762428@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

commit cd39981fb92adf0cc736112f87e3e61602baa415 upstream.

Pointer to options was freed twice on remount
Fixes xfstest generic/361
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ntfs3/super.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -30,6 +30,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/log2.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/nls.h>
 #include <linux/seq_file.h>
@@ -390,7 +391,7 @@ static int ntfs_fs_reconfigure(struct fs
 		return -EINVAL;
 	}
 
-	memcpy(sbi->options, new_opts, sizeof(*new_opts));
+	swap(sbi->options, fc->fs_private);
 
 	return 0;
 }
@@ -900,6 +901,8 @@ static int ntfs_fill_super(struct super_
 	ref.high = 0;
 
 	sbi->sb = sb;
+	sbi->options = fc->fs_private;
+	fc->fs_private = NULL;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
@@ -1262,8 +1265,6 @@ load_root:
 		goto put_inode_out;
 	}
 
-	fc->fs_private = NULL;
-
 	return 0;
 
 put_inode_out:
@@ -1416,7 +1417,6 @@ static int ntfs_init_fs_context(struct f
 	mutex_init(&sbi->compress.mtx_lzx);
 #endif
 
-	sbi->options = opts;
 	fc->s_fs_info = sbi;
 ok:
 	fc->fs_private = opts;


