Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E772EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 20:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiFWUm2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 16:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiFWUmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:42:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C3062721
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:42:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A01C2B82551
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 20:42:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E49C341C6;
        Thu, 23 Jun 2022 20:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656016938;
        bh=EHItQIKNVJfn8mij6ldS1OYUVih2/7DyFWugQGORgBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c+oCjodIQ+Puk3hBE//GLboGpTLt6yaVWTqJoFaZ4424XGndRPWuqhMPSAEdFZcPq
         jTYggxmv6mLQmuG3JgvkqT9WypcCe9Tt6kAAHiI9YxjM6MjI/Hk3q1hg5YAlyXdvMI
         WT6CEORt8VEJD2g/xFZgEQecKTImp+BclNAonjdMEYQyaX3zG/Tx5xmDneMD2K6MRM
         vzf0DhWYTGFSlX3h4m+aaXiGhY6n2eET7fVCSPee1ZtUeNAthfOeRfoEGnjYG12dcf
         DZqgiahQV8YzD6k1iO90n169j2WPmDAO2JFhnRpjTpWwru4DZNl422spT1iWFPFSO0
         zCuvtflNbwQng==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Koby Elbaz <kelbaz@habana.ai>, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/9] habanalabs/gaudi: fix warning: var might be used uninitialized
Date:   Thu, 23 Jun 2022 23:42:05 +0300
Message-Id: <20220623204212.1628709-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623204212.1628709-1-ogabbay@kernel.org>
References: <20220623204212.1628709-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Koby Elbaz <kelbaz@habana.ai>

kernel test robot:
"warning: variable 'index' is used uninitialized whenever 'if' condition
is false"

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Koby Elbaz <kelbaz@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 939d2636b9ed..172c21f262e7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -7388,7 +7388,7 @@ static void gaudi_handle_qman_err(struct hl_device *hdev, u16 event_type, u64 *e
 		if (event_type == GAUDI_EVENT_MME0_QM) {
 			index = 0;
 			qid_base = GAUDI_QUEUE_ID_MME_0_0;
-		} else if (event_type == GAUDI_EVENT_MME2_QM) {
+		} else { /* event_type == GAUDI_EVENT_MME2_QM */
 			index = 2;
 			qid_base = GAUDI_QUEUE_ID_MME_1_0;
 		}
-- 
2.25.1

