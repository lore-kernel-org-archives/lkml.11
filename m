Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2E1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 11:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiCNL7h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 07:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240030AbiCNL65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:58:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291FB1C122;
        Mon, 14 Mar 2022 04:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE6A6B80DEA;
        Mon, 14 Mar 2022 11:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AF87C36AF7;
        Mon, 14 Mar 2022 11:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647259054;
        bh=9DTrj1+o5tcpK00hHoateH8FLQi3sJXMkP1YP3PrzME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fea7wMDnXoNUOAMn/G1vSSzDplnOpAsxGIPImQWUIOPsbGB6q5lYtDqggUOeS/RLs
         SV0PVoA41gWnG+LW0rnd10RIsoc5sWMrn+hYF9FtEDHgXwD/BiANzwyIJTLBVsPJj4
         8w4WEig3tVUe3zORGYl/YA3z1zCrng0iRBskVa58=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH 5.4 36/43] virtio: unexport virtio_finalize_features
Date:   Mon, 14 Mar 2022 12:53:47 +0100
Message-Id: <20220314112735.433393587@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314112734.415677317@linuxfoundation.org>
References: <20220314112734.415677317@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@redhat.com>

commit 838d6d3461db0fdbf33fc5f8a69c27b50b4a46da upstream.

virtio_finalize_features is only used internally within virtio.
No reason to export it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/virtio/virtio.c |    3 +--
 include/linux/virtio.h  |    1 -
 2 files changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -167,7 +167,7 @@ void virtio_add_status(struct virtio_dev
 }
 EXPORT_SYMBOL_GPL(virtio_add_status);
 
-int virtio_finalize_features(struct virtio_device *dev)
+static int virtio_finalize_features(struct virtio_device *dev)
 {
 	int ret = dev->config->finalize_features(dev);
 	unsigned status;
@@ -188,7 +188,6 @@ int virtio_finalize_features(struct virt
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(virtio_finalize_features);
 
 static int virtio_dev_probe(struct device *_d)
 {
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -135,7 +135,6 @@ void virtio_break_device(struct virtio_d
 void virtio_config_changed(struct virtio_device *dev);
 void virtio_config_disable(struct virtio_device *dev);
 void virtio_config_enable(struct virtio_device *dev);
-int virtio_finalize_features(struct virtio_device *dev);
 #ifdef CONFIG_PM_SLEEP
 int virtio_device_freeze(struct virtio_device *dev);
 int virtio_device_restore(struct virtio_device *dev);


