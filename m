Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48585C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 00:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241612AbiF1AbF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 20:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiF1AbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:31:03 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757C2C1;
        Mon, 27 Jun 2022 17:31:02 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 8C85E10057D;
        Tue, 28 Jun 2022 10:31:00 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WDOHH2LEuyw1; Tue, 28 Jun 2022 10:31:00 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 7E4EF10056D; Tue, 28 Jun 2022 10:31:00 +1000 (AEST)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 5200D10053C;
        Tue, 28 Jun 2022 10:30:58 +1000 (AEST)
Subject: [PATCH 2/2] vfs: escape hash as well
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jun 2022 08:30:58 +0800
Message-ID: <165637625806.37717.2027157232247047949.stgit@donald.themaw.net>
In-Reply-To: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
References: <165637619182.37717.17755020386697900473.stgit@donald.themaw.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Siddhesh Poyarekar <siddhesh@gotplt.org>

When a filesystem is mounted with a name that starts with a #:

 # mount '#name' /mnt/bad -t tmpfs

this will cause the entry to look like this (leading space added so
that git does not strip it out):

 #name /mnt/bad tmpfs rw,seclabel,relatime,inode64 0 0

This breaks getmntent and any code that aims to parse fstab as well as
/proc/mounts with the same logic since they need to strip leading spaces
or skip over comment lines, due to which they report incorrect output or
skip over the line respectively.

Solve this by translating the hash character into its octal encoding
equivalent so that applications can decode the name correctly.

Signed-off-by: Siddhesh Poyarekar <siddhesh@gotplt.org>
Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/proc_namespace.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 49650e54d2f8..846f9455ae22 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -86,7 +86,7 @@ static void show_mnt_opts(struct seq_file *m, struct vfsmount *mnt)
 
 static inline void mangle(struct seq_file *m, const char *s)
 {
-	seq_escape(m, s, " \t\n\\");
+	seq_escape(m, s, " \t\n\\#");
 }
 
 static void show_type(struct seq_file *m, struct super_block *sb)


