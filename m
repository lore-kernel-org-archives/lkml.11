Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329CEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 17:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350532AbiCOR0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 13:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350023AbiCOR0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:26:00 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FB03916E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1647365083;
        bh=8Dq3UHkiF8sKrd4rL50cJdnD1RwPcpD+6IhqnTkCDWc=;
        h=From:To:Cc:Subject:Date;
        b=MHYLIo4w5AyA/IaM7X3oPzZ5wMpg2vH+gyvvDhp/NHxfaG3hKD0a7ZWPZUuKfiuWm
         E7i95f+U0nkqkH2fymr+m3GD7t5J8DFbwDJLSZ3Cdf0QXz9BBgGAg32R3quER5ZLII
         Nqn+widP4l8DhOPA5/OTMbXr5/H4aDZ1oL99x/FQ=
Received: from localhost.localdomain ([218.197.153.188])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 61E19C3B; Wed, 16 Mar 2022 01:24:30 +0800
X-QQ-mid: xmsmtpt1647365070ty68a8iup
Message-ID: <tencent_F721901366AB5C720E008AF7F02DA5D3FF07@qq.com>
X-QQ-XMAILINFO: MyirvGjpKb1jQdcb8Zmu3PrYNR/0MQcRhpCOvUEuVfJxKw4fIwFXfZXYjfqlHU
         twfs+UBPOw70nFBIBCOG8t0WK/dNeP3RlSbypp2XIntvVKB6RJNfs0w0tyRisMcQtInPC275fg3h
         by3Yk0sfCzSdxjeiiNs48kp8VW+HW+b1G83RyK6VGUxVoOBLLLivQ/f+kvtQjuwO88YQJba5zJEY
         /GGUJJvuF/nfiyhpeS4Uf6lF/A9PkXIVCYufTbdjRGQWXQdqsIO8jyIODupCGixUpPzZaLtL4Edc
         UawjL+6m6oVibUSVOXYLk60WccIHvs9CZRf9djySUCZyayGZFi11/rQGmWmWnYv1gTgliCiso9j2
         BDFfPm5UQlhb1xDVnEA0YyXwBGaHKogkby7PvXfERFEZP1ghxEWrZt7/K8C3+jF1+Ue0uAxgvm0d
         aXkM22Dif/6dZGXK3CQnt439wWuzshxXih8LrNTyQcnT1a1vG5L5hY2JBON2sOSvc2gKKEHSCzRd
         UpoO9xucGwNJZETdF7CGwjb6I6IFR6fdxHGthqQRoGJIKQ1YNY9u8+KTQAJQ/UJrSgei8cC5Fbs0
         WMrKwhE5eWolYdQKDIFburkfbkz2SNlIg/iCisDsj9qx3LIaOx1W1ra/Stjp/ULYO0iWt1JigmzU
         Gpsv//ZEJnfZgHXS8CXz1zJPVITpCE93FKO3cVmGJRBrHOQOWHLoZhEeqKdVgINSxYdYNmhljkT9
         Lm/QwEIJgvvkVuWhTUXEaKZPIRmtWcbvdD1uKyjkztb1kTsSK1vc/XlYMfxu8nv55q8Ye+oiBTl2
         qKy6TJZK2hAx13Dh4jHAkEdm8UZqkm1/1WhQQF2hEWs5EUV+PQNdGo5W7iTVrje258DV/5+GbPCC
         /4LDOJ4fTJoOsdzT0lgStw1IKTCUWceLOuK+lm//hVxfKDJJgqK5Ql13ke6b5dfU06XdLoDRJC
From:   xkernel.wang@foxmail.com
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        nsaenz@kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: mmal-vchiq: clear redundant item named bulk_scratch
Date:   Wed, 16 Mar 2022 01:24:12 +0800
X-OQ-MSGID: <20220315172412.1024-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

bulk_scratch is not used anywhere and the original allocation of it
does not have proper check.
Deleting it directly seems to be a good choice.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 76d3f03..6615c7a 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -168,9 +168,6 @@ struct vchiq_mmal_instance {
 	/* ensure serialised access to service */
 	struct mutex vchiq_mutex;
 
-	/* vmalloc page to receive scratch bulk xfers into */
-	void *bulk_scratch;
-
 	struct idr context_map;
 	/* protect accesses to context_map */
 	struct mutex context_map_lock;
@@ -1847,8 +1844,6 @@ int vchiq_mmal_finalise(struct vchiq_mmal_instance *instance)
 	flush_workqueue(instance->bulk_wq);
 	destroy_workqueue(instance->bulk_wq);
 
-	vfree(instance->bulk_scratch);
-
 	idr_destroy(&instance->context_map);
 
 	kfree(instance);
@@ -1908,7 +1903,6 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 
 	mutex_init(&instance->vchiq_mutex);
 
-	instance->bulk_scratch = vmalloc(PAGE_SIZE);
 	instance->vchiq_instance = vchiq_instance;
 
 	mutex_init(&instance->context_map_lock);
@@ -1939,7 +1933,6 @@ int vchiq_mmal_init(struct vchiq_mmal_instance **out_instance)
 	vchiq_close_service(instance->service_handle);
 	destroy_workqueue(instance->bulk_wq);
 err_free:
-	vfree(instance->bulk_scratch);
 	kfree(instance);
 err_shutdown_vchiq:
 	vchiq_shutdown(vchiq_instance);
-- 
