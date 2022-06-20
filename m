Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3C0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 13:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345626AbiFTNOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbiFTNKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 09:10:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8511C913
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD16161585
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 13:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66743C3411C;
        Mon, 20 Jun 2022 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655730288;
        bh=DQ0T25vKkcmro9h8yx7UFxooO1yM3WIBu6PbXpNRccg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6FrsOUz58RPF3bIjB897iCF+E6ieQa2HkYdK/9ZBcSbTHlTjTR+O1qx8fPuUTOfa
         VLQC2PYFvkI0VUtQpCxqKdu+CMJc2zjgyUWghfQPA44hQaBqdMLddjR6NuQNhTydx8
         0dWZEVr5wcQmnn7vrvI5CtVx6ihy272kDb54cz0OMEDoHNXi9vZfr5DYVs0uTDg3+a
         05NbPBR0jP1zNy2jZ5DVFqp+9b4XqyDM70yiZHZBy10Jb8s2MgqF4KsPPmYiDMRtpw
         sTaO0OMEVDgK3Bf56hDoPbdccOoMBfMSpvcdsdo1J7Fb6+6kAoNM3QdxR85YJk3mkF
         MoGKmZGs2HBrw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     farah kassabri <fkassabri@habana.ai>
Subject: [PATCH 08/17] habanalabs: add validity check for cq counter offset
Date:   Mon, 20 Jun 2022 16:04:23 +0300
Message-Id: <20220620130432.1180451-8-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620130432.1180451-1-ogabbay@kernel.org>
References: <20220620130432.1180451-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: farah kassabri <fkassabri@habana.ai>

Driver performs no validity check for the user cq counter offset
used in both wait_for_interrupt and register_for_timestamp APIs.

Signed-off-by: farah kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/common/command_submission.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index cbb7c29966ff..72a557b83a7d 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -2979,7 +2979,7 @@ static int ts_buff_get_kernel_ts_record(struct hl_mmap_mem_buf *buf,
 	u64 current_cq_counter;
 
 	/* Validate ts_offset not exceeding last max */
-	if (requested_offset_record > cb_last) {
+	if (requested_offset_record >= cb_last) {
 		dev_err(buf->mmg->dev, "Ts offset exceeds max CB offset(0x%llx)\n",
 								(u64)(uintptr_t)cb_last);
 		return -EINVAL;
@@ -3064,6 +3064,13 @@ static int _hl_interrupt_wait_ioctl(struct hl_device *hdev, struct hl_ctx *ctx,
 		goto put_ctx;
 	}
 
+	/* Validate the cq offset */
+	if (((u64 *) cq_cb->kernel_address + cq_counters_offset) >=
+			((u64 *) cq_cb->kernel_address + (cq_cb->size / sizeof(u64)))) {
+		rc = -EINVAL;
+		goto put_cq_cb;
+	}
+
 	if (register_ts_record) {
 		dev_dbg(hdev->dev, "Timestamp registration: interrupt id: %u, ts offset: %llu, cq_offset: %llu\n",
 					interrupt->interrupt_id, ts_offset, cq_counters_offset);
-- 
2.25.1

