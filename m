Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B2C3F6B0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 16:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiHKQV1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 12:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237656AbiHKQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 12:20:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C4210FC7;
        Thu, 11 Aug 2022 09:01:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FAA5B82166;
        Thu, 11 Aug 2022 16:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FDBC433C1;
        Thu, 11 Aug 2022 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660233712;
        bh=xGPcd112oX8lfCcJLqKqMEUwHG5cYMcLjULpMYNSNpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KPt5Wim+Q+7TLhPlqTS8cmg6pRmlSoYEy9k3pgpBj4UWhn9uQwHRusXdZIabWZBTW
         FV+ll5SRpe/Jmb5vVrkCImAJt2GTI+M3+LziU4ltL8vro4xUyF6X4xUEaoYi1VZqMl
         jsUiJO2tcJA/iMEfZVtf+lQ1VtU92gFJHzAmi/xOKjil7bJbv9QxKSe7cLnellejBN
         9eXzfUxMGrt1esnFxbQ/zppmfG1Jg7425Up5ptwcjcszfCu5gWhDQ5dvFHR61A9wPo
         61nI0ZzEeLWtY0eaCHQZPeZd2+uLhCP40GfksiDBwgZokRSlkzBGZIgEafreWEJStv
         EnreHSOjjak8g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 45/69] iov_iter_get_pages{,_alloc}(): cap the maxsize with MAX_RW_COUNT
Date:   Thu, 11 Aug 2022 11:55:54 -0400
Message-Id: <20220811155632.1536867-45-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811155632.1536867-1-sashal@kernel.org>
References: <20220811155632.1536867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

[ Upstream commit 7392ed1734c319150b5ddec3f192a6405728e8d0 ]

All callers can and should handle iov_iter_get_pages() returning
fewer pages than requested.  All in-kernel ones do.  And it makes
the arithmetical overflow analysis much simpler...

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/iov_iter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6cf2d66fb839..ce24835abe55 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1522,6 +1522,8 @@ ssize_t iov_iter_get_pages(struct iov_iter *i,
 		maxsize = i->count;
 	if (!maxsize)
 		return 0;
+	if (maxsize > MAX_RW_COUNT)
+		maxsize = MAX_RW_COUNT;
 
 	if (likely(iter_is_iovec(i))) {
 		unsigned int gup_flags = 0;
@@ -1642,6 +1644,8 @@ ssize_t iov_iter_get_pages_alloc(struct iov_iter *i,
 		maxsize = i->count;
 	if (!maxsize)
 		return 0;
+	if (maxsize > MAX_RW_COUNT)
+		maxsize = MAX_RW_COUNT;
 
 	if (likely(iter_is_iovec(i))) {
 		unsigned int gup_flags = 0;
-- 
2.35.1

