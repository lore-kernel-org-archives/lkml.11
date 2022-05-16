Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C3EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbiEPKMR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 06:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiEPKML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:12:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 118EFB49E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 03:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652695929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XtoYzvV0Lbrzf7gOH5qbnOQUAI5SvWglVXrVSiG9GLo=;
        b=XN87IVTpsesSJ8GUzTfbcsR75PPexQPNIvqIl1lun70J+1//dUch7Yp7SQAsqOjNA7Nn3s
        Dm8Qy4SU9u7BfJKUJ8J5WS+n/NR2y3C6RnY2JDLSbywkV342J0nMuYoxTIqpXO6Li+XySW
        I1/D6Dmvg/mXvx15rhgj2Sk4R+5jbxo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-Ur-3BFZOOxGAdoTCTjcHPQ-1; Mon, 16 May 2022 06:12:06 -0400
X-MC-Unique: Ur-3BFZOOxGAdoTCTjcHPQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B17EE1D33869;
        Mon, 16 May 2022 10:12:05 +0000 (UTC)
Received: from thuth.com (unknown [10.39.192.239])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7400B41654C;
        Mon, 16 May 2022 10:12:04 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] include/uapi/linux/vfio.h: Fix trivial typo - _IORW should be _IOWR instead
Date:   Mon, 16 May 2022 12:12:02 +0200
Message-Id: <20220516101202.88373-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no macro called _IORW, so use _IOWR in the comment instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/uapi/linux/vfio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index fea86061b44e..733a1cddde30 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -643,7 +643,7 @@ enum {
 };
 
 /**
- * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IORW(VFIO_TYPE, VFIO_BASE + 12,
+ * VFIO_DEVICE_GET_PCI_HOT_RESET_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 12,
  *					      struct vfio_pci_hot_reset_info)
  *
  * Return: 0 on success, -errno on failure:
@@ -770,7 +770,7 @@ struct vfio_device_ioeventfd {
 #define VFIO_DEVICE_IOEVENTFD		_IO(VFIO_TYPE, VFIO_BASE + 16)
 
 /**
- * VFIO_DEVICE_FEATURE - _IORW(VFIO_TYPE, VFIO_BASE + 17,
+ * VFIO_DEVICE_FEATURE - _IOWR(VFIO_TYPE, VFIO_BASE + 17,
  *			       struct vfio_device_feature)
  *
  * Get, set, or probe feature data of the device.  The feature is selected
-- 
2.27.0

