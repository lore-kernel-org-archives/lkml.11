Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD60C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 00:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241475AbiF1Aa6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiF1Aaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:30:55 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4063FED;
        Mon, 27 Jun 2022 17:30:54 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 407E410056D;
        Tue, 28 Jun 2022 10:30:53 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZiDvR08htYCi; Tue, 28 Jun 2022 10:30:53 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 36C3D10055A; Tue, 28 Jun 2022 10:30:53 +1000 (AEST)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 7B94D10053F;
        Tue, 28 Jun 2022 10:30:52 +1000 (AEST)
Subject: [PATCH 1/2] vfs: parse: deal with zero length string value
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jun 2022 08:30:52 +0800
Message-ID: <165637625215.37717.9592144816249092137.stgit@donald.themaw.net>
In-Reply-To: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
References: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parsing an fs string that has zero length should result in the parameter
being set to NULL so that downstream processing handles it correctly.
For example, the proc mount table processing should print "(none)" in
this case to preserve mount record field count, but if the value points
to the NULL string this doesn't happen.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/fs_context.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..4c735d0ce3cb 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -175,9 +175,13 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 	};
 
 	if (value) {
-		param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
-		if (!param.string)
-			return -ENOMEM;
+		if (!v_size)
+			param.string = NULL;
+		else {
+			param.string = kmemdup_nul(value, v_size, GFP_KERNEL);
+			if (!param.string)
+				return -ENOMEM;
+		}
 		param.type = fs_value_is_string;
 	}
 


