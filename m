Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF06C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 10:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347493AbiFJKNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 06:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347722AbiFJKNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 06:13:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F15B10D31A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 03:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654855984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kei8NmzpOkUxB2dpHEcfp2PDkq3C/+cSDDIqUmwxvJk=;
        b=iDz0yXivDrAeWGqKKUnvaUtGLWBk04vfgrTIhhNmZhHa5kPbx0cLQIm0Oy0a2UzCfisJkc
        Ppp1GaeqQBOeNEWdRzRDeAW8ijQ2HSqVOI56s/j4+sAddDAzxd/+lrbJSYBDLWtX3gNHrK
        kaHoAvXD4XF7dNpSED6x0U4rgD091nM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-584-bNOwocI5MvevCnMSLlxg3w-1; Fri, 10 Jun 2022 06:13:01 -0400
X-MC-Unique: bNOwocI5MvevCnMSLlxg3w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2EFE101A54E;
        Fri, 10 Jun 2022 10:13:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 64D691415102;
        Fri, 10 Jun 2022 10:12:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1] MAINTAINERS: add MEMORY HOT(UN)PLUG section and add myself as reviewer
Date:   Fri, 10 Jun 2022 12:12:58 +0200
Message-Id: <20220610101258.75738-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are certainly a lot more files that partially fall into the memory
hot(un)plug category, including parts of mm/sparse.c, mm/page_isolation.c
and mm/page_alloc.c. Let's only add what's almost completely memory
hot(un)plug related.

Add myself as reviewer so it's easier for contributors to figure out
whom to CC.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..77aebce76288 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12848,6 +12848,18 @@ F:	include/linux/vmalloc.h
 F:	mm/
 F:	tools/testing/selftests/vm/
 
+MEMORY HOT(UN)PLUG
+M:	Andrew Morton <akpm@linux-foundation.org>
+R:	David Hildenbrand <david@redhat.com>
+L:	linux-mm@kvack.org
+S:	Maintained
+F:	Documentation/admin-guide/mm/memory-hotplug.rst
+F:	Documentation/core-api/memory-hotplug.rst
+F:	drivers/base/memory.c
+F:	include/linux/memory_hotplug.h
+F:	mm/memory_hotplug.c
+F:	tools/testing/selftests/memory-hotplug/
+
 MEMORY TECHNOLOGY DEVICES (MTD)
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Richard Weinberger <richard@nod.at>
-- 
2.35.3

