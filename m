Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED62C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 11:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242845AbiEULOM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 07:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242386AbiEULMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:12:03 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20442AE39;
        Sat, 21 May 2022 04:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TiWtDwQGjPI0Vq6U4Laa215lDEd4MlpHdfhIAGUc5us=;
  b=S9MB/CfwyNHczngbAP/96e+qIJke6ojAoK/Dduv2CqrKi7i1o6Q+Ovwl
   69pEHZL2oK0tOeC1Hnml0CejkNX23J2zHhJ68XqH207DiwXxM6Dx7azaO
   2yGyhebldnHz3h+oexfJzjR+rqN9fyj/e94eHq8uCpZrVQNvwQvj5Ahbe
   Y=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727910"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:54 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] squashfs: fix typo in comment
Date:   Sat, 21 May 2022 13:10:25 +0200
Message-Id: <20220521111145.81697-15-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 fs/squashfs/xattr.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/xattr.c b/fs/squashfs/xattr.c
index e1e3f3dd5a06..7b78703c0408 100644
--- a/fs/squashfs/xattr.c
+++ b/fs/squashfs/xattr.c
@@ -76,7 +76,7 @@ ssize_t squashfs_listxattr(struct dentry *d, char *buffer,
 			}
 			rest -= prefix_size + name_size + 1;
 		} else  {
-			/* no handler or insuffficient privileges, so skip */
+			/* no handler or insufficient privileges, so skip */
 			err = squashfs_read_metadata(sb, NULL, &start,
 				&offset, name_size);
 			if (err < 0)

