Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA293C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 May 2022 12:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376864AbiEEMey (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 May 2022 08:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376779AbiEEMek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:34:40 -0400
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 05:31:01 PDT
Received: from smarthost1.greenhost.nl (smarthost1.greenhost.nl [195.190.28.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B46F4B1F0
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:31:01 -0700 (PDT)
From:   Indan Zupancic <Indan.Zupancic@mep-info.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Indan Zupancic <Indan.Zupancic@mep-info.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] UIO: Let uio_pdrv_genirq support cached memory
Date:   Thu,  5 May 2022 14:15:19 +0200
Message-Id: <20220505121518.46054-1-Indan.Zupancic@mep-info.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <436ea1f019d26d28ab4fce4ee28f609b@mep-info.com>
References: <436ea1f019d26d28ab4fce4ee28f609b@mep-info.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-As-Hash: ffa5b08e093a8a3dd7ef4f7d7b64ba463f993468
X-Virus-Scanned: by clamav at smarthost1.greenhost.nl
X-Scan-Signature: 353bb18b0f14186cd389c275975c39f5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 'cacheable' DT property exists, the memory mapping will be
done with UIO_MEM_IOVA instead of the default UIO_MEM_PHYS.

Signed-off-by: Indan Zupancic <Indan.Zupancic@mep-info.com>
---
 Documentation/driver-api/uio-howto.rst | 3 ++-
 drivers/uio/uio_pdrv_genirq.c          | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/uio-howto.rst b/Documentation/driver-api/uio-howto.rst
index 907ffa3b38f5..3cb48fc757d9 100644
--- a/Documentation/driver-api/uio-howto.rst
+++ b/Documentation/driver-api/uio-howto.rst
@@ -413,7 +413,8 @@ probed with the ``"of_id"`` module parameter set to the ``"compatible"``
 string of the node the driver is supposed to handle. By default, the
 node's name (without the unit address) is exposed as name for the
 UIO device in userspace. To set a custom name, a property named
-``"linux,uio-name"`` may be specified in the DT node.
+``"linux,uio-name"`` may be specified in the DT node. If a property
+named ``cacheable`` exists, the memory will be mapped cacheable.
 
 Using uio_dmem_genirq for platform devices
 ------------------------------------------
diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 63258b6accc4..269784ce0ba3 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -115,6 +115,7 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 	struct uio_mem *uiomem;
 	int ret = -EINVAL;
 	int i;
+	int memtype = UIO_MEM_PHYS;
 
 	if (node) {
 		const char *name;
@@ -132,7 +133,10 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 		else
 			uioinfo->name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
 						       "%pOFn", node);
-
+		if (of_get_property(node, "cacheable", NULL)) {
+			dev_info(&pdev->dev, "%s cacheable\n", uioinfo->name);
+			memtype = UIO_MEM_IOVA;
+		}
 		uioinfo->version = "devicetree";
 		/* Multiple IRQs are not supported */
 	}
@@ -204,7 +208,7 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 			break;
 		}
 
-		uiomem->memtype = UIO_MEM_PHYS;
+		uiomem->memtype = memtype;
 		uiomem->addr = r->start & PAGE_MASK;
 		uiomem->offs = r->start & ~PAGE_MASK;
 		uiomem->size = (uiomem->offs + resource_size(r)
-- 
2.30.2

