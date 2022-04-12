Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4275BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 06:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350218AbiDLGuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 02:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351481AbiDLGo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:44:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6433AA7B;
        Mon, 11 Apr 2022 23:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87AE2B818C8;
        Tue, 12 Apr 2022 06:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40F2C385A1;
        Tue, 12 Apr 2022 06:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649745503;
        bh=u+U5VkDgvKYLLZki/AQqHBw1Vp9+XfAo+5qJ6Dk/VdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cCbjDPsd8C/JcuVeKAve62/LVof0LXZa4Uw8M+tUVp9loQUdSw3jhtXzlsPcdPtnZ
         BKTaomvFTk1RyENH3rTiAkzlIpAGB9kdZ0oZKWX1FMc0BWlWHxH+mvAnG96NXBVFFr
         vfH+VLLx3ZSqhml0FP909mRlIsP4oB5Z6SzUPBTI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Xiong <xiongx18@fudan.edu.cn>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 077/171] NFSv4.2: fix reference count leaks in _nfs42_proc_copy_notify()
Date:   Tue, 12 Apr 2022 08:29:28 +0200
Message-Id: <20220412062930.114869680@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062927.870347203@linuxfoundation.org>
References: <20220412062927.870347203@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xin Xiong <xiongx18@fudan.edu.cn>

[ Upstream commit b7f114edd54326f730a754547e7cfb197b5bc132 ]

[You don't often get email from xiongx18@fudan.edu.cn. Learn why this is important at http://aka.ms/LearnAboutSenderIdentification.]

The reference counting issue happens in two error paths in the
function _nfs42_proc_copy_notify(). In both error paths, the function
simply returns the error code and forgets to balance the refcount of
object `ctx`, bumped by get_nfs_open_context() earlier, which may
cause refcount leaks.

Fix it by balancing refcount of the `ctx` object before the function
returns in both error paths.

Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42proc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 2587b1b8e2ef..dad32b171e67 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -567,8 +567,10 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 
 	ctx = get_nfs_open_context(nfs_file_open_context(src));
 	l_ctx = nfs_get_lock_context(ctx);
-	if (IS_ERR(l_ctx))
-		return PTR_ERR(l_ctx);
+	if (IS_ERR(l_ctx)) {
+		status = PTR_ERR(l_ctx);
+		goto out;
+	}
 
 	status = nfs4_set_rw_stateid(&args->cna_src_stateid, ctx, l_ctx,
 				     FMODE_READ);
@@ -576,7 +578,7 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 	if (status) {
 		if (status == -EAGAIN)
 			status = -NFS4ERR_BAD_STATEID;
-		return status;
+		goto out;
 	}
 
 	status = nfs4_call_sync(src_server->client, src_server, &msg,
@@ -584,6 +586,7 @@ static int _nfs42_proc_copy_notify(struct file *src, struct file *dst,
 	if (status == -ENOTSUPP)
 		src_server->caps &= ~NFS_CAP_COPY_NOTIFY;
 
+out:
 	put_nfs_open_context(nfs_file_open_context(src));
 	return status;
 }
-- 
2.35.1



