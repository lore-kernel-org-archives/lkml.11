Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D480CCA485
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jun 2022 21:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378286AbiFGVWx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 17:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376809AbiFGU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:28:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB861D92D3;
        Tue,  7 Jun 2022 11:33:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10CB6B82188;
        Tue,  7 Jun 2022 18:33:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EC0C385A2;
        Tue,  7 Jun 2022 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654626793;
        bh=aSoKgQo3dMDBuDYbjgDk2sOaJdxoVF0R36S6qlw9zqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DLSbSs2JRN/P5Xxv1Fnmgoj0eiIRRb06o0xQmYxL9F8yn+hmqhtzPJCr4D5mYkJK9
         zQUZ5Y9FoRzc5Php6Do53JTGXw9NfgutHe7OCrEDKcBz3d9yLQOfxaq82ovxbdOe0K
         jhQp1zGgdEwE7ZXoezRmcKhVEn/mVK2HVydFy1mM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mel Gorman <mel@csn.ul.ie>,
        Minchan Kim <minchan.kim@gmail.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 505/772] drivers/base/node.c: fix compaction sysfs file leak
Date:   Tue,  7 Jun 2022 19:01:37 +0200
Message-Id: <20220607165003.859966201@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607164948.980838585@linuxfoundation.org>
References: <20220607164948.980838585@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit da63dc84befaa9e6079a0bc363ff0eaa975f9073 ]

Compaction sysfs file is created via compaction_register_node in
register_node.  But we forgot to remove it in unregister_node.  Thus
compaction sysfs file is leaked.  Using compaction_unregister_node to fix
this issue.

Link: https://lkml.kernel.org/r/20220401070905.43679-1-linmiaohe@huawei.com
Fixes: ed4a6d7f0676 ("mm: compaction: add /sys trigger for per-node memory compaction")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Mel Gorman <mel@csn.ul.ie>
Cc: Minchan Kim <minchan.kim@gmail.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index 87acc47e8951..7b8368bc2000 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -682,6 +682,7 @@ static int register_node(struct node *node, int num)
  */
 void unregister_node(struct node *node)
 {
+	compaction_unregister_node(node);
 	hugetlb_unregister_node(node);		/* no-op, if memoryless node */
 	node_remove_accesses(node);
 	node_remove_caches(node);
-- 
2.35.1



