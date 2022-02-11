Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1778C433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 02:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347183AbiBKCOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 21:14:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347218AbiBKCOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:14:14 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C35FB9;
        Thu, 10 Feb 2022 18:14:14 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:57088)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILRt-000fSD-Ju; Thu, 10 Feb 2022 19:14:13 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:52650 helo=localhost.localdomain)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nILRr-00FMXV-Lf; Thu, 10 Feb 2022 19:14:13 -0700
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
        "Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Date:   Thu, 10 Feb 2022 20:13:21 -0600
Message-Id: <20220211021324.4116773-5-ebiederm@xmission.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
References: <87o83e2mbu.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-XM-SPF: eid=1nILRr-00FMXV-Lf;;;mid=<20220211021324.4116773-5-ebiederm@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+LUNNXy+P6wbS8hab2BGjP4edjzZTdos=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 5/8] ucounts: Handle wrapping in is_ucounts_overlimit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While examining is_ucounts_overlimit and reading the various messages
I realized that is_ucounts_overlimit fails to deal with counts that
may have wrapped.

Being wrapped should be a transitory state for counts and they should
never be wrapped for long, but it can happen so handle it.

Cc: stable@vger.kernel.org
Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/ucount.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 65b597431c86..06ea04d44685 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -350,7 +350,8 @@ bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsign
 	if (rlimit > LONG_MAX)
 		max = LONG_MAX;
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		if (get_ucounts_value(iter, type) > max)
+		long val = get_ucounts_value(iter, type);
+		if (val < 0 || val > max)
 			return true;
 		max = READ_ONCE(iter->ns->ucount_max[type]);
 	}
-- 
2.29.2

