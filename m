Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F9C25B08
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Aug 2022 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbiHQR2L (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 13:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiHQR15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:27:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D1A8A1D30
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:27:56 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5DCC8113E;
        Wed, 17 Aug 2022 10:27:57 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2EC03F66F;
        Wed, 17 Aug 2022 10:27:55 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 4/6] firmware: arm_scmi: Harden accesses to Reset domains
Date:   Wed, 17 Aug 2022 18:27:29 +0100
Message-Id: <20220817172731.1185305-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220817172731.1185305-1-cristian.marussi@arm.com>
References: <20220817172731.1185305-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing Reset domains descriptors by index upon SCMI drivers requests
through the SCMI reset operations interface can potentially lead to
out-of-bound violations if the SCMI driver misbehave.

Add an internal consistency check in front of such domains descriptors
accesses.

Fixes: 95a15d80aa0de ("firmware: arm_scmi: Add RESET protocol in SCMI v2.0")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/reset.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/reset.c b/drivers/firmware/arm_scmi/reset.c
index 673f3eb498f4..b0494165b1cb 100644
--- a/drivers/firmware/arm_scmi/reset.c
+++ b/drivers/firmware/arm_scmi/reset.c
@@ -166,8 +166,12 @@ static int scmi_domain_reset(const struct scmi_protocol_handle *ph, u32 domain,
 	struct scmi_xfer *t;
 	struct scmi_msg_reset_domain_reset *dom;
 	struct scmi_reset_info *pi = ph->get_priv(ph);
-	struct reset_dom_info *rdom = pi->dom_info + domain;
+	struct reset_dom_info *rdom;
 
+	if (domain >= pi->num_domains)
+		return -EINVAL;
+
+	rdom = pi->dom_info + domain;
 	if (rdom->async_reset)
 		flags |= ASYNCHRONOUS_RESET;
 
-- 
2.32.0

