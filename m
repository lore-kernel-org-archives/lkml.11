Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E09BC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 10:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiCWKB4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 06:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbiCWKBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:01:53 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E6A75E42;
        Wed, 23 Mar 2022 03:00:20 -0700 (PDT)
X-UUID: ef50e9487ff64a058113459f57789bb6-20220323
X-UUID: ef50e9487ff64a058113459f57789bb6-20220323
Received: from cs2c.com.cn [(172.17.111.24)] by nksmu.kylinos.cn
        (envelope-from <lienze@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 347948112; Wed, 23 Mar 2022 17:59:34 +0800
X-ns-mid: postfix-623AEFB1-8934667832
Received: from localhost.localdomain (unknown [172.30.60.63])
        by cs2c.com.cn (NSMail) with ESMTPSA id D5C593848645;
        Wed, 23 Mar 2022 10:00:17 +0000 (UTC)
From:   Enze Li <lienze@kylinos.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs: fix -Wmissing-declaration warning
Date:   Wed, 23 Mar 2022 18:00:03 +0800
Message-Id: <20220323100003.115516-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I encontered the following warning when compiling with
-Wmissing-declarations:

fs/namei.c:2587:5: warning: no previous declaration for
‘filename_parentat’ [-Wmissing-declarations]
 2587 | int filename_parentat(int dfd, struct filename *name, unsigned
 int flags,
       |     ^~~~~~~~~~~~~~~~~)

This warning was introduced by recent commit 43ff44bde7e5 ("ksmbd: fix
racy issue from using ->d_parent and ->d_name").

Address this warning by declaring the function as static, setting its
scope to the containing file.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 44c366f3152f..fe3525807361 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2584,7 +2584,7 @@ static int __filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
-int filename_parentat(int dfd, struct filename *name, unsigned int flags,
+static int filename_parentat(int dfd, struct filename *name, unsigned int flags,
 		      struct path *parent, struct qstr *last, int *type)
 {
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
-- 
2.25.1

