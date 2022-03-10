Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D97C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 22:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbiCJWKs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344007AbiCJWKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:10:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA5D4470;
        Thu, 10 Mar 2022 14:09:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 575B861B51;
        Thu, 10 Mar 2022 22:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F5BC340EB;
        Thu, 10 Mar 2022 22:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646950177;
        bh=lfRfc3xjp6HCohZFtCftK29crzr9/r27lMOBdYmLwgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PMdqBe+nEi5jcT9kt2KpB2lzX/Glts6tIH7ilG7RvPOh/QBKjD59eBtWsSYwjfhnz
         5EHVkOheU50UzExOeDVL27pecj3kvvXY0ITA+s5w65TOaEKMLU2VULCiH9xfp61Ddz
         KKa1HROw+T/gl8Mq0DYVAVWcMTyXFQD3Neu/dWUMONjli0N4gUT3FxbmFuR6us/3Bq
         MnppDMT/d2mF2qt/9F/2sGFG2zIJ0ykO29GGO2YaSIjt8b6Qhzkf3ehp2F81pVv/4W
         NnjMk6cxSQ8I9SgAs4YsKQi1z32Jqy8431K8Cvj9P3FtQ4W9RqO2YIh1jh/Iin4zVg
         NR9ltGrp6KYjw==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, llvm@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 1/2] linux/types.h: Remove unnecessary __bitwise__
Date:   Thu, 10 Mar 2022 16:09:26 -0600
Message-Id: <20220310220927.245704-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310220927.245704-1-helgaas@kernel.org>
References: <20220310220927.245704-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

There are no users of "__bitwise__" except the definition of "__bitwise".
Remove __bitwise__ and define __bitwise directly.

This is a follow-up to 05de97003c77 ("linux/types.h: enable endian checks
for all sparse builds").

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/types.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
index f6d2f83cbe29..71696f424ac8 100644
--- a/include/uapi/linux/types.h
+++ b/include/uapi/linux/types.h
@@ -20,11 +20,10 @@
  */
 
 #ifdef __CHECKER__
-#define __bitwise__ __attribute__((bitwise))
+#define __bitwise	__attribute__((bitwise))
 #else
-#define __bitwise__
+#define __bitwise
 #endif
-#define __bitwise __bitwise__
 
 typedef __u16 __bitwise __le16;
 typedef __u16 __bitwise __be16;
-- 
2.25.1

