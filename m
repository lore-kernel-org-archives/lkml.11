Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE02C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 11:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355632AbiCYLXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345635AbiCYLXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:23:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A58FD3AD1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:22:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB67F1F7AC;
        Fri, 25 Mar 2022 11:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648207319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+LamZ0geDTfpNVX97DRjW3uLcqzqtDRSg1gttDr+Okw=;
        b=3cr8H6ITaU4bWdYmGl635Er+pwxS2FwDPLsw+b78jPwGV2uTXlzuNP++/ez4ZizqHu/VrI
        JIW8gaTs7mKn6MZ8kPf4LKmc+q4uL2FbNwPjOyy6oZdHrHIvuclyHSACe7xuaity9z3dFy
        9Hu595qMzYnoCYeEkYgyC2109sEWbn4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648207319;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+LamZ0geDTfpNVX97DRjW3uLcqzqtDRSg1gttDr+Okw=;
        b=ezwOuBFzEpFQ8R9PPMYNXOQKDxvU8i0DUnZ6RJk6cMvtpxvhn55JB8Z0ZCgUSmC4SIZh+0
        rTD4QjUX6KuAZ7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C2421332D;
        Fri, 25 Mar 2022 11:21:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GWOLJNelPWKfOQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 25 Mar 2022 11:21:59 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/1] ns: Move MAX_PID_NS_LEVEL to ns_common.h, reuse it
Date:   Fri, 25 Mar 2022 12:21:27 +0100
Message-Id: <20220325112127.18026-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move MAX_PID_NS_LEVEL to ns_common.h and reuse it in check in
user_namespace.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Christian, all,

I don't see putting MAX_PID_NS_LEVEL into ns_common.h as an elegant
solution but IMHO better than use a hardwired number or redefinition in
user_namespace.h.

Kind regards,
Petr

 include/linux/ns_common.h     | 3 +++
 include/linux/pid_namespace.h | 3 ---
 kernel/user_namespace.c       | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 0f1d024bd958..173fab9dadf7 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -4,6 +4,9 @@
 
 #include <linux/refcount.h>
 
+/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
+#define MAX_PID_NS_LEVEL 32
+
 struct proc_ns_operations;
 
 struct ns_common {
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 07481bb87d4e..f814068012d0 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -11,9 +11,6 @@
 #include <linux/ns_common.h>
 #include <linux/idr.h>
 
-/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
-#define MAX_PID_NS_LEVEL 32
-
 struct fs_pin;
 
 struct pid_namespace {
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 5481ba44a8d6..6ea6e263403d 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -87,7 +87,7 @@ int create_user_ns(struct cred *new)
 	int ret, i;
 
 	ret = -ENOSPC;
-	if (parent_ns->level > 32)
+	if (parent_ns->level > MAX_PID_NS_LEVEL)
 		goto fail;
 
 	ucounts = inc_user_namespaces(parent_ns, owner);
-- 
2.35.1

