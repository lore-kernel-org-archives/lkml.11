Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6263FC433FE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 01:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242114AbiDGBcF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 21:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiDGBSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:18:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B25D1A1285;
        Wed,  6 Apr 2022 18:13:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24B22B81E79;
        Thu,  7 Apr 2022 01:13:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99DFC385A1;
        Thu,  7 Apr 2022 01:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649294019;
        bh=1kWx12Muyv7hyNQivimjk08S38ZMZK/FXxmUOm/fI48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yf7rd6C0sV/g2dfLevLmfrKjlGzmGtO30PxM6zHxgHTOxeK4fjb4vlejk0QpgEDrK
         qf6PYw/+pDjjRJWANJHaW8LU3IkPHwkIDZN3HKSbSXMdnfWRuF9huywTobAZuWd/ix
         asfncoleUEWoP/2LfGJongadxA5mFUyQ6AxAcnGl8/ygYImohr5Am0HfoNuUKJPVUn
         Cb77jv/wdB4nDq5a/4Y7xVpBPT7V17Q27O36JzjqFHdQ/lUz8/KGe/vXcb04uXHj/h
         csDgAiaBhemkTaaxeqmEIa+YwrdaxpdgENWH5yKm1beV6sFHXLTteMqtwK+cRQuq64
         J457U3vj+gAWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Zhu Lingshan <lingshan.zhu@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Sasha Levin <sashal@kernel.org>, jasowang@redhat.com,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 16/27] vhost_vdpa: don't setup irq offloading when irq_num < 0
Date:   Wed,  6 Apr 2022 21:12:46 -0400
Message-Id: <20220407011257.114287-16-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407011257.114287-1-sashal@kernel.org>
References: <20220407011257.114287-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhu Lingshan <lingshan.zhu@intel.com>

[ Upstream commit cce0ab2b2a39072d81f98017f7b076f3410ef740 ]

When irq number is negative(e.g., -EINVAL), the virtqueue
may be disabled or the virtqueues are sharing a device irq.
In such case, we should not setup irq offloading for a virtqueue.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
Link: https://lore.kernel.org/r/20220222115428.998334-3-lingshan.zhu@intel.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index d62f05d056b7..299a99532618 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -97,8 +97,11 @@ static void vhost_vdpa_setup_vq_irq(struct vhost_vdpa *v, u16 qid)
 		return;
 
 	irq = ops->get_vq_irq(vdpa, qid);
+	if (irq < 0)
+		return;
+
 	irq_bypass_unregister_producer(&vq->call_ctx.producer);
-	if (!vq->call_ctx.ctx || irq < 0)
+	if (!vq->call_ctx.ctx)
 		return;
 
 	vq->call_ctx.producer.token = vq->call_ctx.ctx;
-- 
2.35.1

