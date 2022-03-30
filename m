Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4139FC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 15:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347884AbiC3PId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347820AbiC3PIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC2CE996B9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B475B1576;
        Wed, 30 Mar 2022 08:06:33 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2D53F73B;
        Wed, 30 Mar 2022 08:06:32 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 03/22] firmware: arm_scmi: Fix Base list protocols enumeration
Date:   Wed, 30 Mar 2022 16:05:32 +0100
Message-Id: <20220330150551.2573938-4-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While enumerating protocols implemented by the SCMI backend server using
BASE_DISCOVER_LIST_PROTOCOLS, the number of returned protocols is currently
validated in an improper way since the check employs a sum between unsigned
integers that could overflow and cause the check itself to be silently
bypassed if the returned value 'loop_num_ret' is big enough.

Fix the validation avoiding the addition.

Fixes: b6f20ff8bd9 ("firmware: arm_scmi: add common infrastructure and support for base protocol")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index ebaef5d320af..f279146f8110 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -197,7 +197,7 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
 			break;
 
 		loop_num_ret = le32_to_cpu(*num_ret);
-		if (tot_num_ret + loop_num_ret > MAX_PROTOCOLS_IMP) {
+		if (loop_num_ret > MAX_PROTOCOLS_IMP - tot_num_ret) {
 			dev_err(dev, "No. of Protocol > MAX_PROTOCOLS_IMP");
 			break;
 		}
-- 
2.32.0

