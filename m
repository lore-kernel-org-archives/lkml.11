Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F34FC433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 16:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242947AbiBQQMA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:12:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbiBQQL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:11:58 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CC1BF48;
        Thu, 17 Feb 2022 08:11:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6334F219A2;
        Thu, 17 Feb 2022 16:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645114299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=trkaAj42Qk58nzvh5xCn9D72uPJ0Goap4j9Xg6GQj54=;
        b=dIt60ilvthbCzGmprCu9i0vdIACxkq2NIlLVQSHwrsUEUHqFlF7hbQprfIAEY7l2wMM/3W
        PYS5RX+QIa3rGOFDU3MRy5wmcKBI6jB3NUXLFjp4KQRY9AwhYyciJ+tW0WGDSaausdAEir
        hzOr+3+QNiRqmnreY2jgWr6606D4ZQs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4360813C18;
        Thu, 17 Feb 2022 16:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qnfcD7tzDmJ7cwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 17 Feb 2022 16:11:39 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Masami Ichikawa <masami.ichikawa@cybertrust.co.jp>,
        Tabitha Sable <tabitha.c.sable@gmail.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, stable@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cgroup-v1: Correct privileges check in release_agent writes
Date:   Thu, 17 Feb 2022 17:11:28 +0100
Message-Id: <20220217161128.20291-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idea is to check: a) the owning user_ns of cgroup_ns, b)
capabilities in init_user_ns.

The commit 24f600856418 ("cgroup-v1: Require capabilities to set
release_agent") got this wrong in the write handler of release_agent
since it checked user_ns of the opener (may be different from the owning
user_ns of cgroup_ns).
Secondly, to avoid possibly confused deputy, the capability of the
opener must be checked.

Fixes: 24f600856418 ("cgroup-v1: Require capabilities to set release_agent")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/stable/20220216121142.GB30035@blackbody.suse.cz/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/cgroup/cgroup-v1.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 0e877dbcfeea..afc6c0e9c966 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -546,6 +546,7 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
 					  char *buf, size_t nbytes, loff_t off)
 {
 	struct cgroup *cgrp;
+	struct cgroup_file_ctx *ctx;
 
 	BUILD_BUG_ON(sizeof(cgrp->root->release_agent_path) < PATH_MAX);
 
@@ -553,8 +554,9 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
 	 * Release agent gets called with all capabilities,
 	 * require capabilities to set release agent.
 	 */
-	if ((of->file->f_cred->user_ns != &init_user_ns) ||
-	    !capable(CAP_SYS_ADMIN))
+	ctx = of->priv;
+	if ((ctx->ns->user_ns != &init_user_ns) ||
+	    !file_ns_capable(of->file, &init_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	cgrp = cgroup_kn_lock_live(of->kn, false);
-- 
2.34.1

