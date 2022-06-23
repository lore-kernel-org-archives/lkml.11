Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D8C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 12:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiFWMsD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 08:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiFWMsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:48:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B264BCAF
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:47:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8812913D5;
        Thu, 23 Jun 2022 05:47:59 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 755903F534;
        Thu, 23 Jun 2022 05:47:58 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, vincent.guittot@linaro.org,
        f.fainelli@gmail.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 1/5] firmware: arm_scmi: Remove deprecated ida_simple_ calls
Date:   Thu, 23 Jun 2022 13:47:38 +0100
Message-Id: <20220623124742.2492164-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220623124742.2492164-1-cristian.marussi@arm.com>
References: <20220623124742.2492164-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove deprecated calls to ida_simple_get/ida_simple_remove.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/arm_scmi/bus.c b/drivers/firmware/arm_scmi/bus.c
index e95085a66bc4..a7cbf4d09081 100644
--- a/drivers/firmware/arm_scmi/bus.c
+++ b/drivers/firmware/arm_scmi/bus.c
@@ -192,7 +192,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 		return NULL;
 	}
 
-	id = ida_simple_get(&scmi_bus_id, 1, 0, GFP_KERNEL);
+	id = ida_alloc(&scmi_bus_id, GFP_KERNEL);
 	if (id < 0) {
 		kfree_const(scmi_dev->name);
 		kfree(scmi_dev);
@@ -215,7 +215,7 @@ scmi_device_create(struct device_node *np, struct device *parent, int protocol,
 put_dev:
 	kfree_const(scmi_dev->name);
 	put_device(&scmi_dev->dev);
-	ida_simple_remove(&scmi_bus_id, id);
+	ida_free(&scmi_bus_id, id);
 	return NULL;
 }
 
@@ -223,7 +223,7 @@ void scmi_device_destroy(struct scmi_device *scmi_dev)
 {
 	kfree_const(scmi_dev->name);
 	scmi_handle_put(scmi_dev->handle);
-	ida_simple_remove(&scmi_bus_id, scmi_dev->id);
+	ida_free(&scmi_bus_id, scmi_dev->id);
 	device_unregister(&scmi_dev->dev);
 }
 
-- 
2.32.0

