Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088ACC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 14:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235390AbiCAOr2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 09:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235392AbiCAOrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:47:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0FC49FA9
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 06:46:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 409F561601
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 14:46:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 140F8C340F0;
        Tue,  1 Mar 2022 14:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646145999;
        bh=XuPfbJ5gyWV/sNDbzNt2QVmxD4bkkTRFvCQ8bl7OriU=;
        h=From:To:Cc:Subject:Date:From;
        b=K1iG7/KtxI8qmv6YXuSrkbTtoXNkYG7uLI00ux8Mcf5KqeJKyaZJT7hbh5iedi3TQ
         dQU7yl7Gl+vmbbyoSH2DOPc7mXMkA7fkcZYAmTkDaGXUwdn39QDpMrxmVUn0OUpLiL
         SUFPYvGqYxuiKALMvfeRGEPa8QWfqPDqLpd0F5MBoFtu/Jc9k93IjVRjJHSMsZh1LX
         lZXknFTSjrfvvd2/ZEQWdtFPo/AeZ4LOGqIXMtn7HDrH5uixCv6Lsc2RRcqK4iFogc
         C+DW5bWRvlySFZMxHRnZkX/+LrUBo6C6hBmeKxtN87LmIDiYmllCEUDlTaeo9uXBGU
         CPnBn6e9oIkPw==
From:   SeongJae Park <sj@kernel.org>
To:     roger.pau@citrix.com, jgross@suse.com
Cc:     mheyne@amazon.de, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] xen-blk{back,front}: Update contact points for buffer_squeeze_duration_ms and feature_persistent
Date:   Tue,  1 Mar 2022 14:46:28 +0000
Message-Id: <20220301144628.2858-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SeongJae is currently listed as a contact point for some blk{back,front}
features, but he will not work for XEN for a while.  This commit
therefore updates the contact point to his colleague, Maximilian, who is
understanding the context and actively working with the features now.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
---
 Documentation/ABI/testing/sysfs-driver-xen-blkback  | 4 ++--
 Documentation/ABI/testing/sysfs-driver-xen-blkfront | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkback b/Documentation/ABI/testing/sysfs-driver-xen-blkback
index a74dfe52dd76..7faf719af165 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkback
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkback
@@ -29,7 +29,7 @@ Description:
 What:           /sys/module/xen_blkback/parameters/buffer_squeeze_duration_ms
 Date:           December 2019
 KernelVersion:  5.6
-Contact:        SeongJae Park <sj@kernel.org>
+Contact:        Maximilian Heyne <mheyne@amazon.de>
 Description:
                 When memory pressure is reported to blkback this option
                 controls the duration in milliseconds that blkback will not
@@ -39,7 +39,7 @@ Description:
 What:           /sys/module/xen_blkback/parameters/feature_persistent
 Date:           September 2020
 KernelVersion:  5.10
-Contact:        SeongJae Park <sj@kernel.org>
+Contact:        Maximilian Heyne <mheyne@amazon.de>
 Description:
                 Whether to enable the persistent grants feature or not.  Note
                 that this option only takes effect on newly created backends.
diff --git a/Documentation/ABI/testing/sysfs-driver-xen-blkfront b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
index 61fd173fabfe..7f646c58832e 100644
--- a/Documentation/ABI/testing/sysfs-driver-xen-blkfront
+++ b/Documentation/ABI/testing/sysfs-driver-xen-blkfront
@@ -12,7 +12,7 @@ Description:
 What:           /sys/module/xen_blkfront/parameters/feature_persistent
 Date:           September 2020
 KernelVersion:  5.10
-Contact:        SeongJae Park <sj@kernel.org>
+Contact:        Maximilian Heyne <mheyne@amazon.de>
 Description:
                 Whether to enable the persistent grants feature or not.  Note
                 that this option only takes effect on newly created frontends.
-- 
2.17.1

