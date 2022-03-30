Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A08C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 15:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347842AbiC3PIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 11:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347795AbiC3PIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:08:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C102199684
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:06:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86E0B1477;
        Wed, 30 Mar 2022 08:06:30 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39D0D3F73B;
        Wed, 30 Mar 2022 08:06:29 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH 01/22] firmware: arm_scmi: Fix sorting of retrieved clock rates
Date:   Wed, 30 Mar 2022 16:05:30 +0100
Message-Id: <20220330150551.2573938-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330150551.2573938-1-cristian.marussi@arm.com>
References: <20220330150551.2573938-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During SCMI Clock protocol initialization, after having retrieved from the
SCMI platform all the available discrete rates for a specific clock, the
clock rates array is sorted, unfortunately using a pointer to its end as
a base instead of its start, so that sorting does not work.

Fix invocation of sort() passing as base a pointer to the start of the
retrieved clock rates array.

Fixes: dccec73de91 ("firmware: arm_scmi: Keep the discrete clock rates sorted")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/clock.c b/drivers/firmware/arm_scmi/clock.c
index cf6fed6dec77..ef6431c6eb1c 100644
--- a/drivers/firmware/arm_scmi/clock.c
+++ b/drivers/firmware/arm_scmi/clock.c
@@ -210,7 +210,8 @@ scmi_clock_describe_rates_get(const struct scmi_protocol_handle *ph, u32 clk_id,
 
 	if (rate_discrete && rate) {
 		clk->list.num_rates = tot_rate_cnt;
-		sort(rate, tot_rate_cnt, sizeof(*rate), rate_cmp_func, NULL);
+		sort(clk->list.rates, tot_rate_cnt, sizeof(*rate),
+		     rate_cmp_func, NULL);
 	}
 
 	clk->rate_discrete = rate_discrete;
-- 
2.32.0

