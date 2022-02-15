Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EECC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 05:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiBOFWz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 00:22:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiBOFWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:22:50 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E0DB189F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:22:40 -0800 (PST)
X-QQ-mid: bizesmtp5t1644902556tdmi56v9s
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Feb 2022 13:22:28 +0800 (CST)
X-QQ-SSF: 0140000000200020C000000A0000000
X-QQ-FEAT: hR9GyqeohSghyzCA6GLsrCFQc1EAR/0XTYP76MPePQijBHM78LuiMpfJVuZag
        AuYC4oNTGkHevjFGtGEyNAjqNpRuSLwxh6sYkUIROetBPlOmhVjSXBTIU8KE/fFn7/CdGZy
        gyNfHx95mDhROU+0ZO/D89wpR68Nu6k6yXjJetwLgtzogiqCQUrTAjL3YEytLkCS3Wbughd
        KOSbrqV4wfMxcnDqVEdmyOGZoSRwWVsU+IGPEsL2w+QPOEB/+A4F+BYS6rTOlADZcGKQInq
        Bz5cIQJx04IH/VfeKncWI9HbVXMx1sEwAmOSaaNdBTm+dHyMASKKGcxJ5S5yScCRLQyOh2U
        PTJqqB3outMLTP5oELDL+RJnp1sjLVhH1ZiyhewyvDqo+aghBc=
X-QQ-GoodBg: 1
From:   Zhen Ni <nizhen@uniontech.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, mcgrof@kernel.org,
        keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH 2/8] sched: Move schedstats sysctls to core.c
Date:   Tue, 15 Feb 2022 13:22:08 +0800
Message-Id: <20220215052214.5286-3-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220215052214.5286-1-nizhen@uniontech.com>
References: <20220215052214.5286-1-nizhen@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move schedstats sysctls to core.c and use the new
register_sysctl_init() to register the sysctl interface.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 include/linux/sched/sysctl.h |  2 --
 kernel/sched/core.c          | 22 +++++++++++++++++++++-
 kernel/sysctl.c              | 11 -----------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5490ba24783a..ffe42509a595 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -54,8 +54,6 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *lenp, loff_t *ppos);
 int sysctl_numa_balancing(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
-int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
-		size_t *lenp, loff_t *ppos);
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern unsigned int sysctl_sched_energy_aware;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0bf0dc3adf57..3c1239c61b45 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4354,7 +4354,7 @@ static int __init setup_schedstats(char *str)
 __setup("schedstats=", setup_schedstats);
 
 #ifdef CONFIG_PROC_SYSCTL
-int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
+static int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos)
 {
 	struct ctl_table t;
@@ -4373,6 +4373,26 @@ int sysctl_schedstats(struct ctl_table *table, int write, void *buffer,
 		set_schedstats(state);
 	return err;
 }
+
+static struct ctl_table sched_schedstats_sysctls[] = {
+	{
+		.procname       = "sched_schedstats",
+		.data           = NULL,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_schedstats,
+		.extra1         = SYSCTL_ZERO,
+		.extra2         = SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init sched_schedstats_sysctl_init(void)
+{
+	register_sysctl_init("kernel", sched_schedstats_sysctls);
+	return 0;
+}
+late_initcall(sched_schedstats_sysctl_init);
 #endif /* CONFIG_PROC_SYSCTL */
 #endif /* CONFIG_SCHEDSTATS */
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 24a99b5b7da8..88ff6b27f8ab 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1652,17 +1652,6 @@ int proc_do_static_key(struct ctl_table *table, int write,
 }
 
 static struct ctl_table kern_table[] = {
-#ifdef CONFIG_SCHEDSTATS
-	{
-		.procname	= "sched_schedstats",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned int),
-		.mode		= 0644,
-		.proc_handler	= sysctl_schedstats,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE,
-	},
-#endif /* CONFIG_SCHEDSTATS */
 #ifdef CONFIG_TASK_DELAY_ACCT
 	{
 		.procname	= "task_delayacct",
-- 
2.20.1



