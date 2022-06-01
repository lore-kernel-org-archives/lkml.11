Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663ABC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jun 2022 03:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349346AbiFADWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 23:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345338AbiFADWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 23:22:40 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999D424BEA
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 20:22:39 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654053757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mw56TqjwP1nlClT0bDMzZb5y1zrFQFqeocrqdRbM8lQ=;
        b=NRyWKtJEOJRWxQXWgzjF2clbmi92csp9B01aBATNqLPV/HoNy9SPljVymhDL+E67lH3oPM
        d1DFZXFuEFOtqhfQae/3WabxbXTT8UkLaK1KdE6I0VwBWOwkAAYXo15msxVDuTxflUa+bU
        qFKJLPUwCfpTwrTmgjSAQTCMFekunTI=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Muchun Song <songmuchun@bytedance.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v5 1/6] mm: memcontrol: introduce mem_cgroup_ino() and mem_cgroup_get_from_ino()
Date:   Tue, 31 May 2022 20:22:22 -0700
Message-Id: <20220601032227.4076670-2-roman.gushchin@linux.dev>
In-Reply-To: <20220601032227.4076670-1-roman.gushchin@linux.dev>
References: <20220601032227.4076670-1-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shrinker debugfs requires a way to represent memory cgroups without
using full paths, both for displaying information and getting input
from a user.

Cgroup inode number is a perfect way, already used by bpf.

This commit adds a couple of helper functions which will be used
to handle memcg-aware shrinkers.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
Acked-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/memcontrol.h | 21 +++++++++++++++++++++
 mm/memcontrol.c            | 23 +++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89b14729d59f..66a4f22e8154 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -831,6 +831,15 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
 
+#ifdef CONFIG_SHRINKER_DEBUG
+static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
+{
+	return memcg ? cgroup_ino(memcg->css.cgroup) : 0;
+}
+
+struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
+#endif
+
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
 	return mem_cgroup_from_css(seq_css(m));
@@ -1328,6 +1337,18 @@ static inline struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return NULL;
 }
 
+#ifdef CONFIG_SHRINKER_DEBUG
+static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
+{
+	return 0;
+}
+
+static inline struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
+{
+	return NULL;
+}
+#endif
+
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
 	return NULL;
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 598fece89e2b..d0f892bde698 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5027,6 +5027,29 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
 	return idr_find(&mem_cgroup_idr, id);
 }
 
+#ifdef CONFIG_SHRINKER_DEBUG
+struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino)
+{
+	struct cgroup *cgrp;
+	struct cgroup_subsys_state *css;
+	struct mem_cgroup *memcg;
+
+	cgrp = cgroup_get_from_id(ino);
+	if (!cgrp)
+		return ERR_PTR(-ENOENT);
+
+	css = cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
+	if (css)
+		memcg = container_of(css, struct mem_cgroup, css);
+	else
+		memcg = ERR_PTR(-ENOENT);
+
+	cgroup_put(cgrp);
+
+	return memcg;
+}
+#endif
+
 static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
 {
 	struct mem_cgroup_per_node *pn;
-- 
2.35.3

