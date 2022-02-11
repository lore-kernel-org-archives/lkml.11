Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F270C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 02:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347249AbiBKCOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 21:14:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347238AbiBKCOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:14:21 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2915FB7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:14:21 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:35146)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILS0-00BUbz-LR; Thu, 10 Feb 2022 19:14:20 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:52650 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILRy-00FMXV-EE; Thu, 10 Feb 2022 19:14:20 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alexey Gladkov <legion@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        containers@lists.linux-foundation.org,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Thu, 10 Feb 2022 20:13:23 -0600
Message-Id: <20220211021324.4116773-7-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nILRy-00FMXV-EE;;;mid=<20220211021324.4116773-7-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19hIkDhW0y+iihrri7QgnEJaetNmmdeS/I=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 7/8] rlimit: For RLIMIT_NPROC test the child not the parent for capabilites
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ever since capabilities have become user namespace relative the
capability checks to allow overrriing RLIMIT_NPROC in fork has been
wrong.  It is desirable to test the capabilities the new process will
have not to test the capabilities of the existing process.  In all
cases except when creating a user namespace this does not matter, and
even then not enforcing RLIMIT_NPROC on the root_user probably makes
such a test moot.

Still the test is wrong in principle so fix it to the more stringent test.

Especially now that RLIMIT_NPROC enforcement has become per user namespace.

Fixes: 3486740a4f32 ("userns: security: make capabilities relative to the user namespace")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/fork.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 69333078259c..79661678a5bf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2030,7 +2030,8 @@ static __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_count;
 	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
 		if ((task_ucounts(p) != &init_ucounts) &&
-		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
+		    !has_capability(p, CAP_SYS_RESOURCE) &&
+		    !has_capability(p, CAP_SYS_ADMIN))
 			goto bad_fork_cleanup_count;
 	}
 	current->flags &= ~PF_NPROC_CHECK;
-- 
2.29.2

