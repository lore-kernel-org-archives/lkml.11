Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91432C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 May 2022 12:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbiECMOj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 May 2022 08:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbiECMOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:14:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE39632EEB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 05:11:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FDCE1042;
        Tue,  3 May 2022 05:11:04 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EE5A3F73D;
        Tue,  3 May 2022 05:11:03 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, Cristian Marussi <cristian.marussi@arm.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] firmware: arm_scmi: Fix late checks on pointer dereference
Date:   Tue,  3 May 2022 13:10:47 +0100
Message-Id: <20220503121047.3590340-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few dereferences could happen before the iterator pointer argument was
checked for NULL, causing the following smatch warnings:

drivers/firmware/arm_scmi/driver.c:1214 scmi_iterator_run() warn: variable
dereferenced before check 'i' (see line 1210)

Fix by moving the checks early and dropping some unneeded local references.

No functional change.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index c4960fd3df75..c1922bd650ae 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -1205,18 +1205,21 @@ static void *scmi_iterator_init(const struct scmi_protocol_handle *ph,
 static int scmi_iterator_run(void *iter)
 {
 	int ret = -EINVAL;
+	struct scmi_iterator_ops *iops;
+	const struct scmi_protocol_handle *ph;
+	struct scmi_iterator_state *st;
 	struct scmi_iterator *i = iter;
-	struct scmi_iterator_state *st = &i->state;
-	struct scmi_iterator_ops *iops = i->ops;
-	const struct scmi_protocol_handle *ph = i->ph;
-	const struct scmi_xfer_ops *xops = ph->xops;
 
-	if (!i)
+	if (!i || !i->ops || !i->ph)
 		return ret;
 
+	iops = i->ops;
+	ph = i->ph;
+	st = &i->state;
+
 	do {
 		iops->prepare_message(i->msg, st->desc_index, i->priv);
-		ret = xops->do_xfer(ph, i->t);
+		ret = ph->xops->do_xfer(ph, i->t);
 		if (ret)
 			break;
 
@@ -1240,7 +1243,7 @@ static int scmi_iterator_run(void *iter)
 		}
 
 		st->desc_index += st->num_returned;
-		xops->reset_rx_to_maxsz(ph, i->t);
+		ph->xops->reset_rx_to_maxsz(ph, i->t);
 		/*
 		 * check for both returned and remaining to avoid infinite
 		 * loop due to buggy firmware
@@ -1249,7 +1252,7 @@ static int scmi_iterator_run(void *iter)
 
 out:
 	/* Finalize and destroy iterator */
-	xops->xfer_put(ph, i->t);
+	ph->xops->xfer_put(ph, i->t);
 	devm_kfree(ph->dev, i);
 
 	return ret;
-- 
2.32.0

