Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9D5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:11:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346169AbiDNOKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344134AbiDNNaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:30:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B80E1D3;
        Thu, 14 Apr 2022 06:28:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ADA2B8296A;
        Thu, 14 Apr 2022 13:28:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B283C385A5;
        Thu, 14 Apr 2022 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942887;
        bh=G1cCzSEmSyEJgD7avDuvFKb78yXZro2e0oLgp9BKbiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhPRSjtZMjmj7P3Mv/ffbKJuUtNgbJiT5vTGtPDDr+mVdcrJ973FmHOPnviZGo1FS
         a+0JA05C6tf2R0V+UxPiRu1PFpN01Dt0RWW8CQngKvAcP/r72U0iao+iifL5l5H4fG
         Uzkm2ctdRApH+XGeAvU1k8Zgjld/MRqsukKos+fE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, TCS Robot <tcs_robot@tencent.com>,
        Haimin Zhang <tcs_kernel@tencent.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 298/338] jfs: prevent NULL deref in diFree
Date:   Thu, 14 Apr 2022 15:13:21 +0200
Message-Id: <20220414110847.367481421@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haimin Zhang <tcs_kernel@tencent.com>

[ Upstream commit a53046291020ec41e09181396c1e829287b48d47 ]

Add validation check for JFS_IP(ipimap)->i_imap to prevent a NULL deref
in diFree since diFree uses it without do any validations.
When function jfs_mount calls diMount to initialize fileset inode
allocation map, it can fail and JFS_IP(ipimap)->i_imap won't be
initialized. Then it calls diFreeSpecial to close fileset inode allocation
map inode and it will flow into jfs_evict_inode. Function jfs_evict_inode
just validates JFS_SBI(inode->i_sb)->ipimap, then calls diFree. diFree use
JFS_IP(ipimap)->i_imap directly, then it will cause a NULL deref.

Reported-by: TCS Robot <tcs_robot@tencent.com>
Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 87b41edc800d..68779cc3609a 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -156,12 +156,13 @@ void jfs_evict_inode(struct inode *inode)
 		dquot_initialize(inode);
 
 		if (JFS_IP(inode)->fileset == FILESYSTEM_I) {
+			struct inode *ipimap = JFS_SBI(inode->i_sb)->ipimap;
 			truncate_inode_pages_final(&inode->i_data);
 
 			if (test_cflag(COMMIT_Freewmap, inode))
 				jfs_free_zero_link(inode);
 
-			if (JFS_SBI(inode->i_sb)->ipimap)
+			if (ipimap && JFS_IP(ipimap)->i_imap)
 				diFree(inode);
 
 			/*
-- 
2.35.1



