Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97C5C43217
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 17:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbiEWR6h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 13:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242207AbiEWRcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 13:32:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C2C1753737
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 10:27:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1A3E61FB;
        Mon, 23 May 2022 10:17:07 -0700 (PDT)
Received: from pluto.guestnet.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BC6B3F73D;
        Mon, 23 May 2022 10:17:05 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>, Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH] firmware: arm_scmi: Relax BASE protocol sanity checks on protocol list
Date:   Mon, 23 May 2022 18:15:59 +0100
Message-Id: <20220523171559.472112-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though malformed replies from firmware must be treated carefully to
avoid memory corruption Kernel side, some out-of-spec SCMI replies can
be tolerated to avoid breaking existing deployed system, as long as they
won't cause memory issues.

Reported-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc: Etienne Carriere <etienne.carriere@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/base.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 20fba7370f4e..d0ac96da1ddf 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -221,11 +221,17 @@ scmi_base_implementation_list_get(const struct scmi_protocol_handle *ph,
 		calc_list_sz = (1 + (loop_num_ret - 1) / sizeof(u32)) *
 				sizeof(u32);
 		if (calc_list_sz != real_list_sz) {
-			dev_err(dev,
-				"Malformed reply - real_sz:%zd  calc_sz:%u\n",
-				real_list_sz, calc_list_sz);
-			ret = -EPROTO;
-			break;
+			dev_warn(dev,
+				 "Malformed reply - real_sz:%zd  calc_sz:%u  (loop_num_ret:%d)\n",
+				 real_list_sz, calc_list_sz, loop_num_ret);
+			/*
+			 * Bail out if the expected list size is bigger than the
+			 * total payload size of the received reply.
+			 */
+			if (calc_list_sz > real_list_sz) {
+				ret = -EPROTO;
+				break;
+			}
 		}
 
 		for (loop = 0; loop < loop_num_ret; loop++)
-- 
2.36.1

