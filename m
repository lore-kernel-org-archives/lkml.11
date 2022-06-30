Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D963EC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 01:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiF3BK0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jun 2022 21:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiF3BKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 21:10:25 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 10E3B403ED;
        Wed, 29 Jun 2022 18:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=DKUrC
        qPEXYuKmW3w0+RErOtr/L90fVOnjPQkW+LNK0M=; b=AC5ZbvbRavyZiyK78dsM6
        vF1UK3Fwr0+2Oa5LkkFS+j3Cz+4+s43WbfVer8f44obElPwXsFbqmP9Ddykfmsrh
        IB6bgmOLprWiSsH43veqQcR6WdYUm7I3Oq2DGwlVgl3mjY8KLNKHpjCKhRAC44ci
        c1iksDfxu1c6vKNhoXuCLE=
Received: from localhost.localdomain (unknown [123.112.69.106])
        by smtp4 (Coremail) with SMTP id HNxpCgCHlt3x97xijOXeLw--.53498S4;
        Thu, 30 Jun 2022 09:10:17 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     mathias.nyman@intel.com, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] usb: host: xhci: Fix potential memory leak in xhci_alloc_stream_info()
Date:   Thu, 30 Jun 2022 09:10:08 +0800
Message-Id: <20220630011008.2167298-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgCHlt3x97xijOXeLw--.53498S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw48KFWxCF17WF1DuFy8Zrb_yoW8AFW7pF
        yfZw1Fkr43tF1kGF1DJa4YvayrKw18Ka45KrZrG34kur4UJF4YgF1UCFW8urySvrn5Xr10
        yF95twn5JF4UGFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRqYLPUUUUU=
X-Originating-IP: [123.112.69.106]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiMhkwjFWBzt3EiwAAsf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xhci_alloc_stream_info() allocates stream context array for stream_info
->stream_ctx_array with xhci_alloc_stream_ctx(). When some error occurs,
stream_info->stream_ctx_array is not released, which will lead to a
memory leak.

We can fix it by releasing the stream_info->stream_ctx_array with
xhci_free_stream_ctx() on the error path to avoid the potential memory
leak.

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/usb/host/xhci-mem.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index 8c19e151a945..a71d3a873467 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -648,8 +648,13 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 	/* Allocate everything needed to free the stream rings later */
 	stream_info->free_streams_command =
 		xhci_alloc_command_with_ctx(xhci, true, mem_flags);
-	if (!stream_info->free_streams_command)
+	if (!stream_info->free_streams_command) {
+		xhci_free_stream_ctx(xhci,
+			stream_info->num_stream_ctxs,
+			stream_info->stream_ctx_array,
+			stream_info->ctx_array_dma);
 		goto cleanup_ctx;
+	}
 
 	INIT_RADIX_TREE(&stream_info->trb_address_map, GFP_ATOMIC);
 
@@ -700,6 +705,10 @@ struct xhci_stream_info *xhci_alloc_stream_info(struct xhci_hcd *xhci,
 			stream_info->stream_rings[cur_stream] = NULL;
 		}
 	}
+	xhci_free_stream_ctx(xhci,
+			stream_info->num_stream_ctxs,
+			stream_info->stream_ctx_array,
+			stream_info->ctx_array_dma);
 	xhci_free_command(xhci, stream_info->free_streams_command);
 cleanup_ctx:
 	kfree(stream_info->stream_rings);
-- 
2.25.1

