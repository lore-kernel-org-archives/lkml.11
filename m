Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C40FC433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Apr 2022 23:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376640AbiDCXMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Apr 2022 19:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356986AbiDCXMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 19:12:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABED138DB9
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=6kZxA/ryHkaU9h/eQxcRuN9OQKG8Wz6rQOnBsqvvAIM=; b=b8yQ+shycBrAuZ1bphbkYe/UY0
        w9RLUEg4rEzzdMw1tTMWh8L1mXzVEWZ2eXJhiSURz+lopWPE5LhVrQUZIAW3rOAk847f5nkDXvkrR
        6ApanfC8plvYpFWZfkK5jSg+3nyE+5czoL9JpjJvx50n4f7ahVgxbAUjkzoW8jKxqtirFcX2tEwyM
        RMxKdhTAPGb3m+DkpWZ0fNJIHceRUrSlxdzUAK+CRjwP3H5koSP/SYA75iY9v5gDy0qEhnc4Avenh
        kKH5NCSlJz2+Y41VToxQ2C3BpXH0eqLRxACCtZzeCQ07GQ9p5/OJwA1VN+AvscVyPf8Npy94QjfM8
        lROKVdZg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nb9Mn-00CVxK-F4; Sun, 03 Apr 2022 23:10:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Simon Ser <contact@emersion.fr>
Subject: [PATCH v2] drm: drm/drm_file.h: fix a kernel-doc typo
Date:   Sun,  3 Apr 2022 16:10:40 -0700
Message-Id: <20220403231040.18540-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a build warning from 'make htmldocs' by correcting the lock name
in the kernel-doc comment.

include/drm/drm_file.h:369: warning: Function parameter or member 'master_lookup_lock' not described in 'drm_file'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
Reviewed-by: Simon Ser <contact@emersion.fr>
---
v2: rebase/resend

 include/drm/drm_file.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20220401.orig/include/drm/drm_file.h
+++ linux-next-20220401/include/drm/drm_file.h
@@ -248,7 +248,7 @@ struct drm_file {
 	 */
 	struct drm_master *master;
 
-	/** @master_lock: Serializes @master. */
+	/** @master_lookup_lock: Serializes @master. */
 	spinlock_t master_lookup_lock;
 
 	/** @pid: Process that opened this file. */
