Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DD5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 20:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355104AbiDZUmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 16:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355079AbiDZUmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:42:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 896197C15F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 13:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2ED49B8232E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 20:38:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61090C385B0;
        Tue, 26 Apr 2022 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651005534;
        bh=m1JQep2b3SfKr/7CLSAk47zNdHFQtwIgsoJpy0lNAxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTodtTo6ikP4OlRCyuSvS3rYtbIvHfD5TYO6ziMIaZ2XfUP/Icb71yug7SCjb/P5s
         XxIvu3pqLwHIEUZrWK9GNGeYmgmqsPegkgyfCJhEfkkU5QhJl2QWnUp+nGRAOosRQR
         SPoYDrFwEyV73nFHKcWZ/mPOwqrMPJCGUi5zDjGfKnUaMRLaXXj9dASP9VxGS1x5UG
         gJsaryztCRzWlWQcg+I9kGv/KWCKFVavsRYELr/ECIQj0a00ovvmZTb2UMlbmaHowS
         Nw3QywFEE8NWZ4xKBd+5Ce+9YjhmvfpUMbTRe/CcwViLCCeF3mPTAALXD+d2rWjrWq
         Xc7u3KtYAicJQ==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/4] selftets/damon/sysfs: test existence and permission of avail_operations
Date:   Tue, 26 Apr 2022 20:38:42 +0000
Message-Id: <20220426203843.45238-4-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426203843.45238-1-sj@kernel.org>
References: <20220426203843.45238-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

This commit adds a selftest test case for ensuring the existence and the
permission (read-only) of the 'avail_oprations' DAMON sysfs file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/sysfs.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/sysfs.sh b/tools/testing/selftests/damon/sysfs.sh
index 2e3ae77cb6db..89592c64462f 100644
--- a/tools/testing/selftests/damon/sysfs.sh
+++ b/tools/testing/selftests/damon/sysfs.sh
@@ -231,6 +231,7 @@ test_context()
 {
 	context_dir=$1
 	ensure_dir "$context_dir" "exist"
+	ensure_file "$context_dir/avail_operations" "exit" 400
 	ensure_file "$context_dir/operations" "exist" 600
 	test_monitoring_attrs "$context_dir/monitoring_attrs"
 	test_targets "$context_dir/targets"
-- 
2.25.1

