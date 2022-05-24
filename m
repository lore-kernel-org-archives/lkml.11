Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB640C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 05:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbiEXF4W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 01:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbiEXF4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACBA25F86
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653371770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=tNuCs3myf8YTzjg6YEi6CfRCnRzJghoZRGG5TUri4wc=;
        b=Ku4J/OJsRyEAJSStK27gjfPEznp4xQO63WfZdAwJ/zdBwouwoDxqZnBwcxQ8NUw7Wr/3tY
        ky01xkQ755TQwSn0rXEQ25ULJfiSY2D/LoWY5xg2fcDQAorNfuhO2rErUEfgnATh+TOQaq
        p2CyCVbTErfAVL+zQeskexrFeeZhxaY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-360-byxo_TCoM-aBro8LqBX2aA-1; Tue, 24 May 2022 01:56:04 -0400
X-MC-Unique: byxo_TCoM-aBro8LqBX2aA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAAC0185A79C;
        Tue, 24 May 2022 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-128.pek2.redhat.com [10.72.12.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 040FC40E7F06;
        Tue, 24 May 2022 05:56:00 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, lingshan.zhu@intel.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] vdpa: ifcvf: set pci driver data in probe
Date:   Tue, 24 May 2022 13:55:57 +0800
Message-Id: <20220524055557.1938-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should set the pci driver data in probe instead of the vdpa device
adding callback. Otherwise if no vDPA device is created we will lose
the pointer to the management device.

Fixes: 6b5df347c6482 ("vDPA/ifcvf: implement management netlink framework for ifcvf")
Tested-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 750e5f23406d..0a5670729412 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -771,7 +771,6 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	}
 
 	ifcvf_mgmt_dev->adapter = adapter;
-	pci_set_drvdata(pdev, ifcvf_mgmt_dev);
 
 	vf = &adapter->vf;
 	vf->dev_type = get_dev_type(pdev);
@@ -886,6 +885,8 @@ static int ifcvf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err;
 	}
 
+	pci_set_drvdata(pdev, ifcvf_mgmt_dev);
+
 	return 0;
 
 err:
-- 
2.25.1

