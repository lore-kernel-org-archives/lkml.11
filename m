Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E35CCA487
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 13:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238522AbiGSNA7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 09:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242520AbiGSM7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:59:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8DC5FAFD;
        Tue, 19 Jul 2022 05:23:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4EA61632;
        Tue, 19 Jul 2022 12:23:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA40C341C6;
        Tue, 19 Jul 2022 12:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658233434;
        bh=Mg3fED1AAvaDbJxZHyGG4Bsb6lTRQRN91wZoWjfGKTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kHdvHQ/pf08x16sFUwmi2UNmh5HBgJtiU6xcxqmy7i7Cxn9mEqBDNZe/4052gZnih
         4PAjn51MXodNpo7MP/XmjfGVhzPfdA0rr3wEHyPaw7vcyd4hJNnTICjYvJxt/cr1WC
         6Iu8DKWVPToMNvJRskIYE82x5gTDBsbDGtaH1iWg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 095/231] lockd: fix nlm_close_files
Date:   Tue, 19 Jul 2022 13:53:00 +0200
Message-Id: <20220719114722.758879857@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220719114714.247441733@linuxfoundation.org>
References: <20220719114714.247441733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 1197eb5906a5464dbaea24cac296dfc38499cc00 ]

This loop condition tries a bit too hard to be clever. Just test for
the two indices we care about explicitly.

Cc: J. Bruce Fields <bfields@fieldses.org>
Fixes: 7f024fcd5c97 ("Keep read and write fds with each nlm_file")
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/lockd/svcsubs.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index b2f277727469..e1c4617de771 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -283,11 +283,10 @@ nlm_file_inuse(struct nlm_file *file)
 
 static void nlm_close_files(struct nlm_file *file)
 {
-	struct file *f;
-
-	for (f = file->f_file[0]; f <= file->f_file[1]; f++)
-		if (f)
-			nlmsvc_ops->fclose(f);
+	if (file->f_file[O_RDONLY])
+		nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
+	if (file->f_file[O_WRONLY])
+		nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
 }
 
 /*
-- 
2.35.1



