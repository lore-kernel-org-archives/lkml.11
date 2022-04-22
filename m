Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C00C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 21:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiDVV4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 17:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiDVV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:56:20 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 910DD2A6FFA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:38:53 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650659223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJ7iyWPMUBRHOLQYsDGfDGb0YRmFrOq96IBzMGKKov4=;
        b=QViKBcw+Y9me8wTo9O4z/6ARWC0RmTqkrJWEJ2LMRfQ3Qrx5ozVcnOKyrHA5zyzle+u9xQ
        00G2tNIT5roV/LpwrAldQRK1ODQiptW0RKq1uETU7v8wjtHp1XmlgoNT+7wjiylNM3KnBt
        9FI2VIjhzM7nngbtUg5otkmzsXGjiEU=
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Dave Chinner <dchinner@redhat.com>, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: [PATCH v2 2/7] mm: memcontrol: introduce mem_cgroup_ino() and mem_cgroup_get_from_ino()
Date:   Fri, 22 Apr 2022 13:26:39 -0700
Message-Id: <20220422202644.799732-3-roman.gushchin@linux.dev>
In-Reply-To: <20220422202644.799732-1-roman.gushchin@linux.dev>
References: <20220422202644.799732-1-roman.gushchin@linux.dev>
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

Cgroup inode number is a perfect way, already used by e.g. bpf.

This commit adds a couple of helper functions which will be used to
represent and interact with memcg-aware shrinkers.

Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
---
 include/linux/memcontrol.h |  9 +++++++++
 mm/memcontrol.c            | 23 +++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 89b14729d59f..27a91dd210c9 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -831,6 +831,15 @@ static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
 }
 struct mem_cgroup *mem_cgroup_from_id(unsigned short id);
 
+#ifdef CONFIG_SHRINKER_DEBUG
+static inline unsigned long mem_cgroup_ino(struct mem_cgroup *memcg)
+{
+	return cgroup_ino(memcg->css.cgroup);
+}
+
+struct mem_cgroup *mem_cgroup_get_from_ino(unsigned long ino);
+#endif
+
 static inline struct mem_cgroup *mem_cgroup_from_seq(struct seq_file *m)
 {
 	return mem_cgroup_from_css(seq_css(m));
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 08cbe23a8b94..a508979177a2 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5022,6 +5022,29 @@ struct mem_cgroup *mem_cgroup_from_id(unsigned short id)
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
2.35.1

