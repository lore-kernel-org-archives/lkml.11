Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEA6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 15:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347939AbiC3PJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347861AbiC3PId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 340B09F6C0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1A2D1477;
        Wed, 30 Mar 2022 08:06:47 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A22343F73B;
        Wed, 30 Mar 2022 08:06:46 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 12/22] firmware: arm_scmi: Parse clock_enable_latency conditionally
Date:   Wed, 30 Mar 2022 16:05:41 +0100
Message-Id: <20220330150551.2573938-13-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock_enable_latency field in CLOCK_ATTRIBUTES response message has
been added only since SCMI v3.1: use the advertised SCMI Clock protocol
version as a proper condition check for parsing it, instead of the bare
message length lookup.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index 6dd4150b761b..b46b43a99871 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -130,8 +130,8 @@ static int scmi_clock_attributes_get(const struct scmi_protocol_handle *ph,
 	if (!ret) {
 		attributes = le32_to_cpu(attr->attributes);
 		strlcpy(clk->name, attr->name, SCMI_MAX_STR_SIZE);
-		/* Is optional field clock_enable_latency provided ? */
-		if (t->rx.len == sizeof(*attr))
+		/* clock_enable_latency field is present only since SCMI v3.1 */
+		if (PROTOCOL_REV_MAJOR(version) >= 0x2)
 			clk->enable_latency =
 				le32_to_cpu(attr->clock_enable_latency);
 	}
-- 
2.32.0

