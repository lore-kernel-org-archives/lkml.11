Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5839DC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 07:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbiGOHse (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 03:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiGOHsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 03:48:31 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 290777C1B0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 00:48:30 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 646A51E80D11;
        Fri, 15 Jul 2022 15:44:57 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3I6Jw3BDA2vP; Fri, 15 Jul 2022 15:44:54 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 987C81E80D19;
        Fri, 15 Jul 2022 15:44:54 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     dhowells@redhat.com, marc.dionne@auristor.com
Cc:     linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@nfschina.com, Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] afs/file: Fix typo in string
Date:   Fri, 15 Jul 2022 15:48:22 +0800
Message-Id: <20220715074822.57403-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated ',' from string

Signed-off-by: Zhou jie <zhoujie@nfschina.com>

diff --git a/fs/afs/file.c b/fs/afs/file.c
index 26292a110a8f..19202e7f400b 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -287,7 +287,7 @@ int afs_fetch_data(struct afs_vnode *vnode, struct afs_read *req)
 {
 	struct afs_operation *op;
 
-	_enter("%s{%llx:%llu.%u},%x,,,",
+	_enter("%s{%llx:%llu.%u},%x,",
 	       vnode->volume->name,
 	       vnode->fid.vid,
 	       vnode->fid.vnode,
-- 
2.18.2

