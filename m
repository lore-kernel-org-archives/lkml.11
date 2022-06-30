Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4688DC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 07:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbiF3Huw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 03:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiF3Huu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:50:50 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 687BE3D485
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:50:49 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 739951E80D11;
        Thu, 30 Jun 2022 15:49:28 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ELo56DrHke8u; Thu, 30 Jun 2022 15:49:25 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 36A4A1E80CB6;
        Thu, 30 Jun 2022 15:49:25 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] xen: Fix spelling mistake
Date:   Thu, 30 Jun 2022 15:50:27 +0800
Message-Id: <20220630075027.68833-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change 'maped' to 'mapped'.
Change 'unmaped' to 'unmapped'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 drivers/xen/xen-front-pgdir-shbuf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/xen-front-pgdir-shbuf.c b/drivers/xen/xen-front-pgdir-shbuf.c
index bef8d72a6ca6..5c0b5cb5b419 100644
--- a/drivers/xen/xen-front-pgdir-shbuf.c
+++ b/drivers/xen/xen-front-pgdir-shbuf.c
@@ -89,7 +89,7 @@ EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_get_dir_start);
  * shared by the frontend itself) or map the provided granted
  * references onto the backing storage (buf->pages).
  *
- * \param buf shared buffer which grants to be maped.
+ * \param buf shared buffer which grants to be mapped.
  * \return zero on success or a negative number on failure.
  */
 int xen_front_pgdir_shbuf_map(struct xen_front_pgdir_shbuf *buf)
@@ -110,7 +110,7 @@ EXPORT_SYMBOL_GPL(xen_front_pgdir_shbuf_map);
  * shared by the frontend itself) or unmap the provided granted
  * references.
  *
- * \param buf shared buffer which grants to be unmaped.
+ * \param buf shared buffer which grants to be unmapped.
  * \return zero on success or a negative number on failure.
  */
 int xen_front_pgdir_shbuf_unmap(struct xen_front_pgdir_shbuf *buf)
-- 
2.34.1

