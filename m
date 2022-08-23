Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB90C32792
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244700AbiHWIhZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbiHWIfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F975FE9;
        Tue, 23 Aug 2022 01:16:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4CE761284;
        Tue, 23 Aug 2022 08:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9B2C433C1;
        Tue, 23 Aug 2022 08:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242594;
        bh=QcPnvmwlxRsZIKwLbUmsHT7NWb9WNl57reREAKOTIlk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Idmy6mVx2g9bbT+jvDt19o0YlSrbBwfZDI4Wb6VXpWDMSX+lznWzvHKPIRfNu9hLu
         sCUmDhQ8DK2lYmkA/K14I/BY40+VIhroHSVHkblOeeysO2RRqf9/TtBAf91dq+MQh1
         vV9AeORNYk4wVmGv8Frm+3CKxVeTMskoQfwGxTHk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, gautam.dawar@xilinx.com,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH 5.19 142/365] vdpa_sim: use max_iotlb_entries as a limit in vhost_iotlb_init
Date:   Tue, 23 Aug 2022 10:00:43 +0200
Message-Id: <20220823080124.177818092@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

commit 67f8f10c0bd78c4a0f0e983e050ab90da015323b upstream.

Commit bda324fd037a ("vdpasim: control virtqueue support") changed
the allocation of iotlbs calling vhost_iotlb_init() for each address
space, instead of vhost_iotlb_alloc().

With this change we forgot to use the limit we had introduced with
the `max_iotlb_entries` module parameter.

Fixes: bda324fd037a ("vdpasim: control virtqueue support")
Cc: gautam.dawar@xilinx.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20220621151208.189959-1-sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 0f2865899647..3e81532c01cb 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -33,7 +33,7 @@ MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
 static int max_iotlb_entries = 2048;
 module_param(max_iotlb_entries, int, 0444);
 MODULE_PARM_DESC(max_iotlb_entries,
-		 "Maximum number of iotlb entries. 0 means unlimited. (default: 2048)");
+		 "Maximum number of iotlb entries for each address space. 0 means unlimited. (default: 2048)");
 
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
@@ -291,7 +291,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 		goto err_iommu;
 
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
-		vhost_iotlb_init(&vdpasim->iommu[i], 0, 0);
+		vhost_iotlb_init(&vdpasim->iommu[i], max_iotlb_entries, 0);
 
 	vdpasim->buffer = kvmalloc(dev_attr->buffer_size, GFP_KERNEL);
 	if (!vdpasim->buffer)
-- 
2.37.2



