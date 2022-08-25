Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55E4C48BE4
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Aug 2022 01:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbiHYBk4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 21:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiHYBjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:39:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C599AF8E;
        Wed, 24 Aug 2022 18:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D697ACE18FC;
        Thu, 25 Aug 2022 01:37:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C51C433C1;
        Thu, 25 Aug 2022 01:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661391435;
        bh=gryOjwWDAu/usCl18nIUd96bjcCBzxoffoZ+xdmDChE=;
        h=From:To:Cc:Subject:Date:From;
        b=hDL0MaqOa1k0otmAPraW0W77RrgQkhvLJcuC6+obGhT/d58JLRZsv94gv0Du3Zz12
         cG3dacHQXniAll/1n1WDbKbNodZmI8CRPgHPE3NOYQa/tIiqjwPMK4ePh2e9T/ZVRK
         9ZBft8FvZrjxk2KkNydA/11OMWqfy1HT2/VSfq9elEGOzXIt6EOZYX2USj4+YCyYyO
         OideMnQ+uVCou5hJZGaA/2pCfNytldEO7rEoIxlw+Cxubi58af3Pa+z+qN+S3De97R
         u/BpfSrQVJHf4M62DlNJ78+FpailqmSJQoiTCqNoTL+EMGoeObfDdBZHs9NJSLHLHv
         lIuxCJqeHehMw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Sasha Levin <sashal@kernel.org>, ntfs3@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 01/20] fs/ntfs3: Fix work with fragmented xattr
Date:   Wed, 24 Aug 2022 21:36:53 -0400
Message-Id: <20220825013713.22656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 42f86b1226a42bfc79a7125af435432ad4680a32 ]

In some cases xattr is too fragmented,
so we need to load it before writing.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/xattr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 0968565ff2ca..fa9f42e50503 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -118,7 +118,7 @@ static int ntfs_read_ea(struct ntfs_inode *ni, struct EA_FULL **ea,
 
 		run_init(&run);
 
-		err = attr_load_runs(attr_ea, ni, &run, NULL);
+		err = attr_load_runs_range(ni, ATTR_EA, NULL, 0, &run, 0, size);
 		if (!err)
 			err = ntfs_read_run_nb(sbi, &run, 0, ea_p, size, NULL);
 		run_close(&run);
@@ -443,6 +443,11 @@ static noinline int ntfs_set_ea(struct inode *inode, const char *name,
 		/* Delete xattr, ATTR_EA */
 		ni_remove_attr_le(ni, attr, mi, le);
 	} else if (attr->non_res) {
+		err = attr_load_runs_range(ni, ATTR_EA, NULL, 0, &ea_run, 0,
+					   size);
+		if (err)
+			goto out;
+
 		err = ntfs_sb_write_run(sbi, &ea_run, 0, ea_all, size, 0);
 		if (err)
 			goto out;
-- 
2.35.1

