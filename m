Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8ECC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 03:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbiCHDml (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 22:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232753AbiCHDmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:42:38 -0500
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4997B33A04;
        Mon,  7 Mar 2022 19:41:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=hongnan.li@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V6bcFtB_1646710899;
Received: from localhost(mailfrom:hongnan.li@linux.alibaba.com fp:SMTPD_---0V6bcFtB_1646710899)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 08 Mar 2022 11:41:39 +0800
From:   Hongnan Li <hongnan.li@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation/filesystem/dax: update DAX description on erofs
Date:   Tue,  8 Mar 2022 11:41:39 +0800
Message-Id: <20220308034139.93748-1-hongnan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lihongnan <hongnan.lhn@alibaba-inc.com>

Add missing erofs fsdax description since fsdax has been supported
on erofs from Linux 5.15.

Signed-off-by: lihongnan <hongnan.lhn@alibaba-inc.com>
---
 Documentation/filesystems/dax.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/dax.rst b/Documentation/filesystems/dax.rst
index e3b30429d703..c04609d8ee24 100644
--- a/Documentation/filesystems/dax.rst
+++ b/Documentation/filesystems/dax.rst
@@ -23,11 +23,11 @@ on it as usual.  The `DAX` code currently only supports files with a block
 size equal to your kernel's `PAGE_SIZE`, so you may need to specify a block
 size when creating the filesystem.
 
-Currently 4 filesystems support `DAX`: ext2, ext4, xfs and virtiofs.
+Currently 5 filesystems support `DAX`: ext2, ext4, xfs, virtiofs and erofs.
 Enabling `DAX` on them is different.
 
-Enabling DAX on ext2
---------------------
+Enabling DAX on ext2 and erofs
+------------------------------
 
 When mounting the filesystem, use the ``-o dax`` option on the command line or
 add 'dax' to the options in ``/etc/fstab``.  This works to enable `DAX` on all files
-- 
2.32.0 (Apple Git-132)

