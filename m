Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1221BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 11:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiGALfV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 07:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiGALfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:35:18 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D436814B0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 04:35:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 26CCB1FF74;
        Fri,  1 Jul 2022 11:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1656675316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W7W9DpDiQH1euC0uREaJgoNej8dBkN5z8wg8OPoapmE=;
        b=eA/xVIZSRsTfC9KEzYMFWuAjpSrWF3vYLdRWCxYo1fM9+/69by6OI7ox+o4pWjcewT9coo
        8mLbT9ZAFkulDUQpWGPpZTJz0CoLqnU0n24nmJnw2DB4f4sBwuj0a22DoY2tLfw2uB8UM0
        r7b2XeEsW8D2jZL+ymd1WNtHwzvEKww=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD8C213484;
        Fri,  1 Jul 2022 11:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oHNeM/PbvmLiGAAAMHmgww
        (envelope-from <nborisov@suse.com>); Fri, 01 Jul 2022 11:35:15 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/2] scripts/bloat-o-meter: add -p argument
Date:   Fri,  1 Jul 2022 14:35:13 +0300
Message-Id: <20220701113513.1938008-2-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701113513.1938008-1-nborisov@suse.com>
References: <20220701113513.1938008-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When doing cross platform development on a machine sometimes it might be
useful to invoke bloat-o-meter for files which haven't been build with
the native toolchain. In cases when the host nm doesn't support
the target one then a toolchain-specific nm could be used. Add this
ability by adding the -p allowing invocations as:

./scripts/bloat-o-meter -p riscv64-unknown-linux-gnu- file1.o file2.o

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 scripts/bloat-o-meter | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index 2a360118710e..f9553f60a14a 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -17,6 +17,7 @@ group = parser.add_mutually_exclusive_group()
 group.add_argument('-c', help='categorize output based on symbol type', action='store_true')
 group.add_argument('-d', help='Show delta of Data Section', action='store_true')
 group.add_argument('-t', help='Show delta of text Section', action='store_true')
+parser.add_argument('-p', dest='prefix', help='Arch prefix for the tool being used. Useful in cross build scenarios')
 parser.add_argument('file1', help='First file to compare')
 parser.add_argument('file2', help='Second file to compare')
 
@@ -26,7 +27,11 @@ re_NUMBER = re.compile(r'\.[0-9]+')
 
 def getsizes(file, format):
     sym = {}
-    with os.popen("nm --size-sort " + file) as f:
+    nm = "nm"
+    if args.prefix:
+        nm = "{}nm".format(args.prefix)
+
+    with os.popen("{} --size-sort {}".format(nm, file)) as f:
         for line in f:
             if line.startswith("\n") or ":" in line:
                 continue
-- 
2.25.1

