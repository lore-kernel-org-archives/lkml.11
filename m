Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D69C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347302AbiBIEJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346476AbiBID3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:29:12 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC91C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:29:11 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644377349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nk/ogVvZ6G5p1cloPOlhe43E5L3x/YQoDgays1J5zEo=;
        b=YTNfyWsWjeJQ7m69DfJep2bexhfoncZFU2rMNsW4qldVIB7maRAB1nHaZFqcNEJzq2/C/1
        ZUnfPMHwcteobZMIJHyRu12rAbk45ppIlMie46CnYKwVBaeDYzogpJvA356JdasE+lqArv
        +Fr5kmRgoqRvn6NvKzY55QorpXznHVY=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen/pci: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:28:41 +0800
Message-Id: <20220209032842.38818-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/xen/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/pci.c b/drivers/xen/pci.c
index 2c890f4f2cbc..72d4e3f193af 100644
--- a/drivers/xen/pci.c
+++ b/drivers/xen/pci.c
@@ -264,7 +264,7 @@ struct xen_device_domain_owner {
 };
 
 static DEFINE_SPINLOCK(dev_domain_list_spinlock);
-static struct list_head dev_domain_list = LIST_HEAD_INIT(dev_domain_list);
+static LIST_HEAD(dev_domain_list);
 
 static struct xen_device_domain_owner *find_device(struct pci_dev *dev)
 {
-- 
2.25.1

