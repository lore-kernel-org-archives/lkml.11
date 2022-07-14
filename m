Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A7CC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 02:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbiGNC6B (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jul 2022 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiGNC5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 22:57:49 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77E2525290
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 19:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=npQPi
        A96mmh8pN2HAtBmFsXOD7TFeizPkB3sUnXQWW4=; b=bQIN9eAzmIYLr8wsVe5KG
        KJEU6io86oErv6NrY/c7L+t1bp+ZokgdIifVWg4KXA5vKScES+RG/NSTjvcArA3E
        VQbW6cY27I3LIwaq39xHfmSclxswsOmqJAwcmA2ZXWog4dXP3TrnQ0qxp7ZD3o2q
        Aks8Pzftk7a4MYCD/3/0OU=
Received: from localhost.localdomain (unknown [111.48.58.12])
        by smtp7 (Coremail) with SMTP id C8CowAAHg6kDhs9iLvqQNQ--.56871S2;
        Thu, 14 Jul 2022 10:57:17 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     shaggy@kernel.org
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] fs/jfs: replace ternary operator with min_t()
Date:   Thu, 14 Jul 2022 10:56:56 +0800
Message-Id: <20220714025656.1685439-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowAAHg6kDhs9iLvqQNQ--.56871S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1fWr4kWw1xXr48ur47CFg_yoW8Gr4fpF
        ykCr4fGF95Gr1UX3Z7Wr4kX3WIga4vyayIqrW8Zr12vr9Yqw1ftF13tFyYgayFvF4xX3yj
        qF4DuryfXr1DJr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07js6p9UUUUU=
X-Originating-IP: [111.48.58.12]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/xtbBAg4++2B0Ij99lgAAsr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix the following coccicheck warning:

fs/jfs/super.c:748: WARNING opportunity for min().
fs/jfs/super.c:788: WARNING opportunity for min().

min_t() macro is defined in include/linux/minmax.h. It avoids
multiple evaluations of the arguments when non-constant and performs
strict type-checking.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/jfs/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 85d4f44f2ac4..d2f82cb7db1b 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -745,8 +745,7 @@ static ssize_t jfs_quota_read(struct super_block *sb, int type, char *data,
 		len = i_size-off;
 	toread = len;
 	while (toread > 0) {
-		tocopy = sb->s_blocksize - offset < toread ?
-				sb->s_blocksize - offset : toread;
+		tocopy = min_t(size_t, sb->s_blocksize - offset, toread);
 
 		tmp_bh.b_state = 0;
 		tmp_bh.b_size = i_blocksize(inode);
@@ -785,8 +784,7 @@ static ssize_t jfs_quota_write(struct super_block *sb, int type,
 
 	inode_lock(inode);
 	while (towrite > 0) {
-		tocopy = sb->s_blocksize - offset < towrite ?
-				sb->s_blocksize - offset : towrite;
+		tocopy = min_t(size_t, sb->s_blocksize - offset, towrite);
 
 		tmp_bh.b_state = 0;
 		tmp_bh.b_size = i_blocksize(inode);
-- 
2.25.1

