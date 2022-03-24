Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4B3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 08:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345948AbiCXI2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242495AbiCXI2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:28:12 -0400
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E76029BAF8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=SYdtMX0fUBJBGCRkZr
        x91FiJtXR+g6Dfi9TegzBMeTM=; b=qdSVARpouAfRPbGS+iy46sNTs3+sdaXlS8
        FC1UgeHYkfoW6IvAoxmthn9A6gAw44Y/MsSgjgi6wH7kCt59QxrAxbSSlDhbEfa8
        C5HaMRAu0SWQaHwu8lQ7F0FkiDChh6myl+Z5NiE5BVZ+qZWbivKFeqMZ/ljIF7lB
        lgVo2TGsA=
Received: from localhost (unknown [159.226.95.33])
        by smtp8 (Coremail) with SMTP id DMCowAD3_zc3KzxicLj8Bg--.28399S2;
        Thu, 24 Mar 2022 16:26:32 +0800 (CST)
From:   QintaoShen <unSimple1993@163.com>
To:     Felix.Kuehling@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        QintaoShen <unSimple1993@163.com>
Subject: [PATCH v1] drm/amdkfd: Check for potential null return of kmalloc_array()
Date:   Thu, 24 Mar 2022 16:26:23 +0800
Message-Id: <1648110383-3533-1-git-send-email-unSimple1993@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DMCowAD3_zc3KzxicLj8Bg--.28399S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4kWF17uF47Ar1kArWDurg_yoWftrg_Gr
        15Xr9xAr4DCFn5Wry2vw4aqry0yr4rZ3WkXF18t3WfJryfZFyUC348XrWkZ3yfGa4DuFyD
        tw4DKF4fuFsF9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sR_GYL3UUUUU==
X-Originating-IP: [159.226.95.33]
X-CM-SenderInfo: 5xqvxz5sohimizt6il2tof0z/xtbCbgjNH2BbCZsoFAAAsh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the kmalloc_array() may return null, the 'event_waiters[i].wait' would lead to null-pointer dereference.
Therefore, it is better to check the return value of kmalloc_array() to avoid this confusion.

Signed-off-by: QintaoShen <unSimple1993@163.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index deeccce..64f4a51 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -749,6 +749,8 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
 	event_waiters = kmalloc_array(num_events,
 					sizeof(struct kfd_event_waiter),
 					GFP_KERNEL);
+	if (!event_waiters)
+		return NULL;
 
 	for (i = 0; (event_waiters) && (i < num_events) ; i++) {
 		init_wait(&event_waiters[i].wait);
-- 
2.7.4

