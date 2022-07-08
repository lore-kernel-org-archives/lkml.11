Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04DCC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 01:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiGHBnc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Jul 2022 21:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237142AbiGHBn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 21:43:27 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42830C41;
        Thu,  7 Jul 2022 18:43:26 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id DD87E10052B;
        Fri,  8 Jul 2022 11:43:24 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4wEqhAuDhxc7; Fri,  8 Jul 2022 11:43:24 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id CDCCC1007D3; Fri,  8 Jul 2022 11:43:24 +1000 (AEST)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 2CD3B10052B;
        Fri,  8 Jul 2022 11:43:24 +1000 (AEST)
Subject: [PATCH 5/5] autofs: remove unused ino field inode
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Fri, 08 Jul 2022 09:43:23 +0800
Message-ID: <165724460393.30914.6511330213821246793.stgit@donald.themaw.net>
In-Reply-To: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
References: <165724445154.30914.10970894936827635879.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused inode field of the autofs dentry info
structure.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/autofs_i.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 0117d6e06300..d5a44fa88acf 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -51,8 +51,6 @@ extern struct file_system_type autofs_fs_type;
  */
 struct autofs_info {
 	struct dentry	*dentry;
-	struct inode	*inode;
-
 	int		flags;
 
 	struct completion expire_complete;


