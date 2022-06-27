Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD7BC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 20:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241199AbiF0U0i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 16:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241187AbiF0U0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:26:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05041A076
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 13:26:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58AEE61760
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:26:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7F1C34115;
        Mon, 27 Jun 2022 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656361591;
        bh=fmv/K5khhbz2TQGKTfdQwYPovIqaoZRRArnWNMNaOyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AY+/WZFNIIyoscUK6mQpa3+/qX81O7bczL4xE36PJQSGryfW8LVZfNpWLRYulds0A
         nkrIrUgu+rQzlx+VbqupMmDZ8UgRf32rxwjLdt/Wnu4r9Nlzr3FCGxCibfcbPM2GU/
         Z5IBZlprSO0wlpbi3pjWdetJU8sTMMhycTDLYmY8O1dYqwfQUtEeMXYlooEQWc9O+1
         96/vJKym/ifhkAHR1foWYYcZLYCgoYbAGkLcpFom1lzRLWsu4wqiBmOzq24WrlwnDZ
         0I+sWRf8p9gPEK6hg0yFoDAy/8BwfYsWEEEwL4k7yFgGTYsU+kaBfE8p0q6vt0aT04
         ciFhin+gozUKw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 02/12] uapi: habanalabs: add gaudi2 defines
Date:   Mon, 27 Jun 2022 23:26:10 +0300
Message-Id: <20220627202620.961350-3-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220627202620.961350-1-ogabbay@kernel.org>
References: <20220627202620.961350-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the new defines for GAUDI2 uapi interface.

It includes the following:
1. Enums of engines and PLLs.
2. New information in the info IOCTL that is retrieved by the driver.
3. Update comments regarding the CB/CS/wait for CS ioctls.
4. New fields in the debug IOCTL for configuring the profiler for
   Gaudi2.

There is no new IOCTL.

Some of the changes are also relevant for Greco (which will be
upstreamed later this year). When ever it says "Greco and onwards",
it means it is also for Gaudi2.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 include/uapi/misc/habanalabs.h | 497 +++++++++++++++++++++++++++++++--
 1 file changed, 477 insertions(+), 20 deletions(-)

diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 41a0fa345e4e..8570fa52e20a 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -184,6 +184,285 @@ enum gaudi_queue_id {
 	GAUDI_QUEUE_ID_SIZE
 };
 
+/*
+ * In GAUDI2 we have two modes of operation in regard to queues:
+ * 1. Legacy mode, where each QMAN exposes 4 streams to the user
+ * 2. F/W mode, where we use F/W to schedule the JOBS to the different queues.
+ *
+ * When in legacy mode, the user sends the queue id per JOB according to
+ * enum gaudi2_queue_id below.
+ *
+ * When in F/W mode, the user sends a stream id per Command Submission. The
+ * stream id is a running number from 0 up to (N-1), where N is the number
+ * of streams the F/W exposes and is passed to the user in
+ * struct hl_info_hw_ip_info
+ */
+
+enum gaudi2_queue_id {
+	GAUDI2_QUEUE_ID_PDMA_0_0 = 0,
+	GAUDI2_QUEUE_ID_PDMA_0_1 = 1,
+	GAUDI2_QUEUE_ID_PDMA_0_2 = 2,
+	GAUDI2_QUEUE_ID_PDMA_0_3 = 3,
+	GAUDI2_QUEUE_ID_PDMA_1_0 = 4,
+	GAUDI2_QUEUE_ID_PDMA_1_1 = 5,
+	GAUDI2_QUEUE_ID_PDMA_1_2 = 6,
+	GAUDI2_QUEUE_ID_PDMA_1_3 = 7,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_0_0 = 8,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_0_1 = 9,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_0_2 = 10,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_0_3 = 11,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_1_0 = 12,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_1_1 = 13,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_1_2 = 14,
+	GAUDI2_QUEUE_ID_DCORE0_EDMA_1_3 = 15,
+	GAUDI2_QUEUE_ID_DCORE0_MME_0_0 = 16,
+	GAUDI2_QUEUE_ID_DCORE0_MME_0_1 = 17,
+	GAUDI2_QUEUE_ID_DCORE0_MME_0_2 = 18,
+	GAUDI2_QUEUE_ID_DCORE0_MME_0_3 = 19,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_0_0 = 20,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_0_1 = 21,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_0_2 = 22,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_0_3 = 23,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_1_0 = 24,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_1_1 = 25,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_1_2 = 26,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_1_3 = 27,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_2_0 = 28,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_2_1 = 29,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_2_2 = 30,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_2_3 = 31,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_3_0 = 32,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_3_1 = 33,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_3_2 = 34,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_3_3 = 35,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_4_0 = 36,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_4_1 = 37,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_4_2 = 38,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_4_3 = 39,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_5_0 = 40,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_5_1 = 41,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_5_2 = 42,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_5_3 = 43,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_6_0 = 44,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_6_1 = 45,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_6_2 = 46,
+	GAUDI2_QUEUE_ID_DCORE0_TPC_6_3 = 47,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_0_0 = 48,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_0_1 = 49,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_0_2 = 50,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_0_3 = 51,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_1_0 = 52,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_1_1 = 53,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_1_2 = 54,
+	GAUDI2_QUEUE_ID_DCORE1_EDMA_1_3 = 55,
+	GAUDI2_QUEUE_ID_DCORE1_MME_0_0 = 56,
+	GAUDI2_QUEUE_ID_DCORE1_MME_0_1 = 57,
+	GAUDI2_QUEUE_ID_DCORE1_MME_0_2 = 58,
+	GAUDI2_QUEUE_ID_DCORE1_MME_0_3 = 59,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_0_0 = 60,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_0_1 = 61,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_0_2 = 62,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_0_3 = 63,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_1_0 = 64,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_1_1 = 65,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_1_2 = 66,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_1_3 = 67,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_2_0 = 68,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_2_1 = 69,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_2_2 = 70,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_2_3 = 71,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_3_0 = 72,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_3_1 = 73,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_3_2 = 74,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_3_3 = 75,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_4_0 = 76,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_4_1 = 77,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_4_2 = 78,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_4_3 = 79,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_5_0 = 80,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_5_1 = 81,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_5_2 = 82,
+	GAUDI2_QUEUE_ID_DCORE1_TPC_5_3 = 83,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_0_0 = 84,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_0_1 = 85,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_0_2 = 86,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_0_3 = 87,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_1_0 = 88,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_1_1 = 89,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_1_2 = 90,
+	GAUDI2_QUEUE_ID_DCORE2_EDMA_1_3 = 91,
+	GAUDI2_QUEUE_ID_DCORE2_MME_0_0 = 92,
+	GAUDI2_QUEUE_ID_DCORE2_MME_0_1 = 93,
+	GAUDI2_QUEUE_ID_DCORE2_MME_0_2 = 94,
+	GAUDI2_QUEUE_ID_DCORE2_MME_0_3 = 95,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_0_0 = 96,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_0_1 = 97,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_0_2 = 98,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_0_3 = 99,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_1_0 = 100,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_1_1 = 101,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_1_2 = 102,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_1_3 = 103,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_2_0 = 104,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_2_1 = 105,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_2_2 = 106,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_2_3 = 107,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_3_0 = 108,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_3_1 = 109,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_3_2 = 110,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_3_3 = 111,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_4_0 = 112,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_4_1 = 113,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_4_2 = 114,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_4_3 = 115,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_5_0 = 116,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_5_1 = 117,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_5_2 = 118,
+	GAUDI2_QUEUE_ID_DCORE2_TPC_5_3 = 119,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_0_0 = 120,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_0_1 = 121,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_0_2 = 122,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_0_3 = 123,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_1_0 = 124,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_1_1 = 125,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_1_2 = 126,
+	GAUDI2_QUEUE_ID_DCORE3_EDMA_1_3 = 127,
+	GAUDI2_QUEUE_ID_DCORE3_MME_0_0 = 128,
+	GAUDI2_QUEUE_ID_DCORE3_MME_0_1 = 129,
+	GAUDI2_QUEUE_ID_DCORE3_MME_0_2 = 130,
+	GAUDI2_QUEUE_ID_DCORE3_MME_0_3 = 131,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_0_0 = 132,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_0_1 = 133,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_0_2 = 134,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_0_3 = 135,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_1_0 = 136,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_1_1 = 137,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_1_2 = 138,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_1_3 = 139,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_2_0 = 140,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_2_1 = 141,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_2_2 = 142,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_2_3 = 143,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_3_0 = 144,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_3_1 = 145,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_3_2 = 146,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_3_3 = 147,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_4_0 = 148,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_4_1 = 149,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_4_2 = 150,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_4_3 = 151,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_5_0 = 152,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_5_1 = 153,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_5_2 = 154,
+	GAUDI2_QUEUE_ID_DCORE3_TPC_5_3 = 155,
+	GAUDI2_QUEUE_ID_NIC_0_0 = 156,
+	GAUDI2_QUEUE_ID_NIC_0_1 = 157,
+	GAUDI2_QUEUE_ID_NIC_0_2 = 158,
+	GAUDI2_QUEUE_ID_NIC_0_3 = 159,
+	GAUDI2_QUEUE_ID_NIC_1_0 = 160,
+	GAUDI2_QUEUE_ID_NIC_1_1 = 161,
+	GAUDI2_QUEUE_ID_NIC_1_2 = 162,
+	GAUDI2_QUEUE_ID_NIC_1_3 = 163,
+	GAUDI2_QUEUE_ID_NIC_2_0 = 164,
+	GAUDI2_QUEUE_ID_NIC_2_1 = 165,
+	GAUDI2_QUEUE_ID_NIC_2_2 = 166,
+	GAUDI2_QUEUE_ID_NIC_2_3 = 167,
+	GAUDI2_QUEUE_ID_NIC_3_0 = 168,
+	GAUDI2_QUEUE_ID_NIC_3_1 = 169,
+	GAUDI2_QUEUE_ID_NIC_3_2 = 170,
+	GAUDI2_QUEUE_ID_NIC_3_3 = 171,
+	GAUDI2_QUEUE_ID_NIC_4_0 = 172,
+	GAUDI2_QUEUE_ID_NIC_4_1 = 173,
+	GAUDI2_QUEUE_ID_NIC_4_2 = 174,
+	GAUDI2_QUEUE_ID_NIC_4_3 = 175,
+	GAUDI2_QUEUE_ID_NIC_5_0 = 176,
+	GAUDI2_QUEUE_ID_NIC_5_1 = 177,
+	GAUDI2_QUEUE_ID_NIC_5_2 = 178,
+	GAUDI2_QUEUE_ID_NIC_5_3 = 179,
+	GAUDI2_QUEUE_ID_NIC_6_0 = 180,
+	GAUDI2_QUEUE_ID_NIC_6_1 = 181,
+	GAUDI2_QUEUE_ID_NIC_6_2 = 182,
+	GAUDI2_QUEUE_ID_NIC_6_3 = 183,
+	GAUDI2_QUEUE_ID_NIC_7_0 = 184,
+	GAUDI2_QUEUE_ID_NIC_7_1 = 185,
+	GAUDI2_QUEUE_ID_NIC_7_2 = 186,
+	GAUDI2_QUEUE_ID_NIC_7_3 = 187,
+	GAUDI2_QUEUE_ID_NIC_8_0 = 188,
+	GAUDI2_QUEUE_ID_NIC_8_1 = 189,
+	GAUDI2_QUEUE_ID_NIC_8_2 = 190,
+	GAUDI2_QUEUE_ID_NIC_8_3 = 191,
+	GAUDI2_QUEUE_ID_NIC_9_0 = 192,
+	GAUDI2_QUEUE_ID_NIC_9_1 = 193,
+	GAUDI2_QUEUE_ID_NIC_9_2 = 194,
+	GAUDI2_QUEUE_ID_NIC_9_3 = 195,
+	GAUDI2_QUEUE_ID_NIC_10_0 = 196,
+	GAUDI2_QUEUE_ID_NIC_10_1 = 197,
+	GAUDI2_QUEUE_ID_NIC_10_2 = 198,
+	GAUDI2_QUEUE_ID_NIC_10_3 = 199,
+	GAUDI2_QUEUE_ID_NIC_11_0 = 200,
+	GAUDI2_QUEUE_ID_NIC_11_1 = 201,
+	GAUDI2_QUEUE_ID_NIC_11_2 = 202,
+	GAUDI2_QUEUE_ID_NIC_11_3 = 203,
+	GAUDI2_QUEUE_ID_NIC_12_0 = 204,
+	GAUDI2_QUEUE_ID_NIC_12_1 = 205,
+	GAUDI2_QUEUE_ID_NIC_12_2 = 206,
+	GAUDI2_QUEUE_ID_NIC_12_3 = 207,
+	GAUDI2_QUEUE_ID_NIC_13_0 = 208,
+	GAUDI2_QUEUE_ID_NIC_13_1 = 209,
+	GAUDI2_QUEUE_ID_NIC_13_2 = 210,
+	GAUDI2_QUEUE_ID_NIC_13_3 = 211,
+	GAUDI2_QUEUE_ID_NIC_14_0 = 212,
+	GAUDI2_QUEUE_ID_NIC_14_1 = 213,
+	GAUDI2_QUEUE_ID_NIC_14_2 = 214,
+	GAUDI2_QUEUE_ID_NIC_14_3 = 215,
+	GAUDI2_QUEUE_ID_NIC_15_0 = 216,
+	GAUDI2_QUEUE_ID_NIC_15_1 = 217,
+	GAUDI2_QUEUE_ID_NIC_15_2 = 218,
+	GAUDI2_QUEUE_ID_NIC_15_3 = 219,
+	GAUDI2_QUEUE_ID_NIC_16_0 = 220,
+	GAUDI2_QUEUE_ID_NIC_16_1 = 221,
+	GAUDI2_QUEUE_ID_NIC_16_2 = 222,
+	GAUDI2_QUEUE_ID_NIC_16_3 = 223,
+	GAUDI2_QUEUE_ID_NIC_17_0 = 224,
+	GAUDI2_QUEUE_ID_NIC_17_1 = 225,
+	GAUDI2_QUEUE_ID_NIC_17_2 = 226,
+	GAUDI2_QUEUE_ID_NIC_17_3 = 227,
+	GAUDI2_QUEUE_ID_NIC_18_0 = 228,
+	GAUDI2_QUEUE_ID_NIC_18_1 = 229,
+	GAUDI2_QUEUE_ID_NIC_18_2 = 230,
+	GAUDI2_QUEUE_ID_NIC_18_3 = 231,
+	GAUDI2_QUEUE_ID_NIC_19_0 = 232,
+	GAUDI2_QUEUE_ID_NIC_19_1 = 233,
+	GAUDI2_QUEUE_ID_NIC_19_2 = 234,
+	GAUDI2_QUEUE_ID_NIC_19_3 = 235,
+	GAUDI2_QUEUE_ID_NIC_20_0 = 236,
+	GAUDI2_QUEUE_ID_NIC_20_1 = 237,
+	GAUDI2_QUEUE_ID_NIC_20_2 = 238,
+	GAUDI2_QUEUE_ID_NIC_20_3 = 239,
+	GAUDI2_QUEUE_ID_NIC_21_0 = 240,
+	GAUDI2_QUEUE_ID_NIC_21_1 = 241,
+	GAUDI2_QUEUE_ID_NIC_21_2 = 242,
+	GAUDI2_QUEUE_ID_NIC_21_3 = 243,
+	GAUDI2_QUEUE_ID_NIC_22_0 = 244,
+	GAUDI2_QUEUE_ID_NIC_22_1 = 245,
+	GAUDI2_QUEUE_ID_NIC_22_2 = 246,
+	GAUDI2_QUEUE_ID_NIC_22_3 = 247,
+	GAUDI2_QUEUE_ID_NIC_23_0 = 248,
+	GAUDI2_QUEUE_ID_NIC_23_1 = 249,
+	GAUDI2_QUEUE_ID_NIC_23_2 = 250,
+	GAUDI2_QUEUE_ID_NIC_23_3 = 251,
+	GAUDI2_QUEUE_ID_ROT_0_0 = 252,
+	GAUDI2_QUEUE_ID_ROT_0_1 = 253,
+	GAUDI2_QUEUE_ID_ROT_0_2 = 254,
+	GAUDI2_QUEUE_ID_ROT_0_3 = 255,
+	GAUDI2_QUEUE_ID_ROT_1_0 = 256,
+	GAUDI2_QUEUE_ID_ROT_1_1 = 257,
+	GAUDI2_QUEUE_ID_ROT_1_2 = 258,
+	GAUDI2_QUEUE_ID_ROT_1_3 = 259,
+	GAUDI2_QUEUE_ID_CPU_PQ = 260,
+	GAUDI2_QUEUE_ID_SIZE
+};
+
 /*
  * Engine Numbering
  *
@@ -242,6 +521,85 @@ enum gaudi_engine_id {
 	GAUDI_ENGINE_ID_SIZE
 };
 
+enum gaudi2_engine_id {
+	GAUDI2_DCORE0_ENGINE_ID_EDMA_0 = 0,
+	GAUDI2_DCORE0_ENGINE_ID_EDMA_1,
+	GAUDI2_DCORE0_ENGINE_ID_MME,
+	GAUDI2_DCORE0_ENGINE_ID_TPC_0,
+	GAUDI2_DCORE0_ENGINE_ID_TPC_1,
+	GAUDI2_DCORE0_ENGINE_ID_TPC_2,
+	GAUDI2_DCORE0_ENGINE_ID_TPC_3,
+	GAUDI2_DCORE0_ENGINE_ID_TPC_4,
+	GAUDI2_DCORE0_ENGINE_ID_TPC_5,
+	GAUDI2_DCORE0_ENGINE_ID_DEC_0,
+	GAUDI2_DCORE0_ENGINE_ID_DEC_1,
+	GAUDI2_DCORE1_ENGINE_ID_EDMA_0,
+	GAUDI2_DCORE1_ENGINE_ID_EDMA_1,
+	GAUDI2_DCORE1_ENGINE_ID_MME,
+	GAUDI2_DCORE1_ENGINE_ID_TPC_0,
+	GAUDI2_DCORE1_ENGINE_ID_TPC_1,
+	GAUDI2_DCORE1_ENGINE_ID_TPC_2,
+	GAUDI2_DCORE1_ENGINE_ID_TPC_3,
+	GAUDI2_DCORE1_ENGINE_ID_TPC_4,
+	GAUDI2_DCORE1_ENGINE_ID_TPC_5,
+	GAUDI2_DCORE1_ENGINE_ID_DEC_0,
+	GAUDI2_DCORE1_ENGINE_ID_DEC_1,
+	GAUDI2_DCORE2_ENGINE_ID_EDMA_0,
+	GAUDI2_DCORE2_ENGINE_ID_EDMA_1,
+	GAUDI2_DCORE2_ENGINE_ID_MME,
+	GAUDI2_DCORE2_ENGINE_ID_TPC_0,
+	GAUDI2_DCORE2_ENGINE_ID_TPC_1,
+	GAUDI2_DCORE2_ENGINE_ID_TPC_2,
+	GAUDI2_DCORE2_ENGINE_ID_TPC_3,
+	GAUDI2_DCORE2_ENGINE_ID_TPC_4,
+	GAUDI2_DCORE2_ENGINE_ID_TPC_5,
+	GAUDI2_DCORE2_ENGINE_ID_DEC_0,
+	GAUDI2_DCORE2_ENGINE_ID_DEC_1,
+	GAUDI2_DCORE3_ENGINE_ID_EDMA_0,
+	GAUDI2_DCORE3_ENGINE_ID_EDMA_1,
+	GAUDI2_DCORE3_ENGINE_ID_MME,
+	GAUDI2_DCORE3_ENGINE_ID_TPC_0,
+	GAUDI2_DCORE3_ENGINE_ID_TPC_1,
+	GAUDI2_DCORE3_ENGINE_ID_TPC_2,
+	GAUDI2_DCORE3_ENGINE_ID_TPC_3,
+	GAUDI2_DCORE3_ENGINE_ID_TPC_4,
+	GAUDI2_DCORE3_ENGINE_ID_TPC_5,
+	GAUDI2_DCORE3_ENGINE_ID_DEC_0,
+	GAUDI2_DCORE3_ENGINE_ID_DEC_1,
+	GAUDI2_DCORE0_ENGINE_ID_TPC_6,
+	GAUDI2_ENGINE_ID_PDMA_0,
+	GAUDI2_ENGINE_ID_PDMA_1,
+	GAUDI2_ENGINE_ID_ROT_0,
+	GAUDI2_ENGINE_ID_ROT_1,
+	GAUDI2_PCIE_ENGINE_ID_DEC_0,
+	GAUDI2_PCIE_ENGINE_ID_DEC_1,
+	GAUDI2_ENGINE_ID_NIC0_0,
+	GAUDI2_ENGINE_ID_NIC0_1,
+	GAUDI2_ENGINE_ID_NIC1_0,
+	GAUDI2_ENGINE_ID_NIC1_1,
+	GAUDI2_ENGINE_ID_NIC2_0,
+	GAUDI2_ENGINE_ID_NIC2_1,
+	GAUDI2_ENGINE_ID_NIC3_0,
+	GAUDI2_ENGINE_ID_NIC3_1,
+	GAUDI2_ENGINE_ID_NIC4_0,
+	GAUDI2_ENGINE_ID_NIC4_1,
+	GAUDI2_ENGINE_ID_NIC5_0,
+	GAUDI2_ENGINE_ID_NIC5_1,
+	GAUDI2_ENGINE_ID_NIC6_0,
+	GAUDI2_ENGINE_ID_NIC6_1,
+	GAUDI2_ENGINE_ID_NIC7_0,
+	GAUDI2_ENGINE_ID_NIC7_1,
+	GAUDI2_ENGINE_ID_NIC8_0,
+	GAUDI2_ENGINE_ID_NIC8_1,
+	GAUDI2_ENGINE_ID_NIC9_0,
+	GAUDI2_ENGINE_ID_NIC9_1,
+	GAUDI2_ENGINE_ID_NIC10_0,
+	GAUDI2_ENGINE_ID_NIC10_1,
+	GAUDI2_ENGINE_ID_NIC11_0,
+	GAUDI2_ENGINE_ID_NIC11_1,
+	GAUDI2_ENGINE_ID_SIZE
+};
+
 /*
  * ASIC specific PLL index
  *
@@ -275,6 +633,22 @@ enum hl_gaudi_pll_index {
 	HL_GAUDI_PLL_MAX
 };
 
+enum hl_gaudi2_pll_index {
+	HL_GAUDI2_CPU_PLL = 0,
+	HL_GAUDI2_PCI_PLL,
+	HL_GAUDI2_SRAM_PLL,
+	HL_GAUDI2_HBM_PLL,
+	HL_GAUDI2_NIC_PLL,
+	HL_GAUDI2_DMA_PLL,
+	HL_GAUDI2_MESH_PLL,
+	HL_GAUDI2_MME_PLL,
+	HL_GAUDI2_TPC_PLL,
+	HL_GAUDI2_IF_PLL,
+	HL_GAUDI2_VID_PLL,
+	HL_GAUDI2_MSS_PLL,
+	HL_GAUDI2_PLL_MAX
+};
+
 /**
  * enum hl_goya_dma_direction - Direction of DMA operation inside a LIN_DMA packet that is
  *                              submitted to the GOYA's DMA QMAN. This attribute is not relevant
@@ -326,7 +700,8 @@ enum hl_server_type {
 	HL_SERVER_GAUDI_HLS1 = 1,
 	HL_SERVER_GAUDI_HLS1H = 2,
 	HL_SERVER_GAUDI_TYPE1 = 3,
-	HL_SERVER_GAUDI_TYPE2 = 4
+	HL_SERVER_GAUDI_TYPE2 = 4,
+	HL_SERVER_GAUDI2_HLS2 = 5
 };
 
 /* Opcode for management ioctl
@@ -376,6 +751,7 @@ enum hl_server_type {
  *                            Razwi initiator.
  *                            Razwi cause, was it a page fault or MMU access error.
  * HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES - Retrieve valid page sizes for device memory allocation
+ * HL_INFO_TPM - Retrieve tpm attestation data.
  * HL_INFO_REGISTER_EVENTFD   - Register eventfd for event notifications.
  * HL_INFO_UNREGISTER_EVENTFD - Unregister eventfd
  * HL_INFO_GET_EVENTS         - Retrieve the last occurred events
@@ -405,6 +781,7 @@ enum hl_server_type {
 #define HL_INFO_CS_TIMEOUT_EVENT		24
 #define HL_INFO_RAZWI_EVENT			25
 #define HL_INFO_DEV_MEM_ALLOC_PAGE_SIZES	26
+#define HL_INFO_TPM				27
 #define HL_INFO_REGISTER_EVENTFD		28
 #define HL_INFO_UNREGISTER_EVENTFD		29
 #define HL_INFO_GET_EVENTS			30
@@ -428,8 +805,10 @@ enum hl_server_type {
  * @device_id: PCI device ID of the ASIC.
  * @module_id: Module ID of the ASIC for mezzanine cards in servers
  *             (From OCP spec).
+ * @decoder_enabled_mask: Bit-mask that represents which decoders are enabled.
  * @first_available_interrupt_id: The first available interrupt ID for the user
  *                                to be used when it works with user interrupts.
+ *                                Relevant for Gaudi2 and later.
  * @server_type: Server type that the Gaudi ASIC is currently installed in.
  *               The value is according to enum hl_server_type
  * @cpld_version: CPLD version on the board.
@@ -441,9 +820,15 @@ enum hl_server_type {
  * @tpc_enabled_mask: Bit-mask that represents which TPCs are enabled. Relevant
  *                    for Goya/Gaudi only.
  * @dram_enabled: Whether the DRAM is enabled.
+ * @mme_master_slave_mode: Indicate whether the MME is working in master/slave
+ *                         configuration. Relevant for Greco and later.
  * @cpucp_version: The CPUCP f/w version.
  * @card_name: The card name as passed by the f/w.
+ * @tpc_enabled_mask_ext: Bit-mask that represents which TPCs are enabled.
+ *                        Relevant for Greco and later.
  * @dram_page_size: The DRAM physical page size.
+ * @edma_enabled_mask: Bit-mask that represents which EDMAs are enabled.
+ *                     Relevant for Gaudi2 and later.
  * @number_of_user_interrupts: The number of interrupts that are available to the userspace
  *                             application to use. Relevant for Gaudi2 and later.
  * @device_mem_alloc_default_page_size: default page size used in device memory allocation.
@@ -456,7 +841,7 @@ struct hl_info_hw_ip_info {
 	__u32 num_of_events;
 	__u32 device_id;
 	__u32 module_id;
-	__u32 reserved;
+	__u32 decoder_enabled_mask;
 	__u16 first_available_interrupt_id;
 	__u16 server_type;
 	__u32 cpld_version;
@@ -466,12 +851,13 @@ struct hl_info_hw_ip_info {
 	__u32 psoc_pci_pll_div_factor;
 	__u8 tpc_enabled_mask;
 	__u8 dram_enabled;
-	__u8 pad[2];
+	__u8 reserved;
+	__u8 mme_master_slave_mode;
 	__u8 cpucp_version[HL_INFO_VERSION_MAX_LEN];
 	__u8 card_name[HL_INFO_CARD_NAME_MAX_LEN];
-	__u64 reserved2;
+	__u64 tpc_enabled_mask_ext;
 	__u64 dram_page_size;
-	__u32 reserved3;
+	__u32 edma_enabled_mask;
 	__u16 number_of_user_interrupts;
 	__u16 pad2;
 	__u64 reserved4;
@@ -722,6 +1108,44 @@ struct hl_info_dev_memalloc_page_sizes {
 	__u64 page_order_bitmask;
 };
 
+#define HL_TPM_PCR_DATA_BUF_SZ		256
+#define HL_TPM_PCR_QUOTE_BUF_SZ		510	/* (512 - 2) 2 bytes used for size */
+#define HL_TPM_SIGNATURE_BUF_SZ		255	/* (256 - 1) 1 byte used for size */
+#define HL_TPM_PUB_DATA_BUF_SZ		510	/* (512 - 2) 2 bytes used for size */
+#define HL_TPM_CERTIFICATE_BUF_SZ	2046	/* (2048 - 2) 2 bytes used for size */
+
+/**
+ * struct hl_info_tpm - attestation data of the boot from the TPM
+ * @nonce: number only used once. random number provided by host. this also passed to the quote
+ *         command as a qualifying data.
+ * @pcr_quote_len: length of the attestation quote data in bytes
+ * @pub_data_len: length of the public data in bytes
+ * @certificate_len: length of the certificate in bytes
+ * @pcr_num_reg: number of PCR registers in the pcr_data array
+ * @pcr_reg_len: length of each PCR register in the pcr_data array in bytes
+ * @quote_sig_len: length of the attestation signature in bytes
+ * @pcr_data: raw values of the PCR registers from the TPM
+ * @pcr_quote: attestation data structure (TPM2B_ATTEST) from the TPM
+ * @public_data: public key and certificate info from the TPM (outPublic + name + qualifiedName)
+ * @certificate: certificate for the attestation data, read from the TPM NV mem
+ * @quote_sig: signature structure (TPMT_SIGNATURE) of the attestation data
+ */
+struct hl_info_tpm {
+	__u32 nonce;
+	__u16 pcr_quote_len;
+	__u16 pub_data_len;
+	__u16 certificate_len;
+	__u8 pcr_num_reg;
+	__u8 pcr_reg_len;
+	__u8 quote_sig_len;
+	__u8 pcr_data[HL_TPM_PCR_DATA_BUF_SZ];
+	__u8 pcr_quote[HL_TPM_PCR_QUOTE_BUF_SZ];
+	__u8 public_data[HL_TPM_PUB_DATA_BUF_SZ];
+	__u8 certificate[HL_TPM_CERTIFICATE_BUF_SZ];
+	__u8 quote_sig[HL_TPM_SIGNATURE_BUF_SZ];
+	__u8 pad0[2];
+};
+
 enum gaudi_dcores {
 	HL_GAUDI_WS_DCORE,
 	HL_GAUDI_WN_DCORE,
@@ -742,6 +1166,7 @@ enum gaudi_dcores {
  * @period_ms: Period value, in milliseconds, for utilization rate in range 100ms - 1000ms in 100 ms
  *             resolution. Currently not in use.
  * @pll_index: Index as defined in hl_<asic type>_pll_index enumeration.
+ * @tpm_nonce: Nonce number used for tpm attestation.
  * @eventfd: event file descriptor for event notifications.
  * @pad: Padding to 64 bit.
  */
@@ -755,6 +1180,7 @@ struct hl_info_args {
 		__u32 ctx_id;
 		__u32 period_ms;
 		__u32 pll_index;
+		__u32 tpm_nonce;
 		__u32 eventfd;
 	};
 
@@ -821,16 +1247,16 @@ union hl_cb_args {
 /* HL_CS_CHUNK_FLAGS_ values
  *
  * HL_CS_CHUNK_FLAGS_USER_ALLOC_CB:
- *      Indicates if the CB was allocated and mapped by userspace.
- *      User allocated CB is a command buffer allocated by the user, via malloc
- *      (or similar). After allocating the CB, the user invokes “memory ioctl”
- *      to map the user memory into a device virtual address. The user provides
- *      this address via the cb_handle field. The interface provides the
- *      ability to create a large CBs, Which aren’t limited to
- *      “HL_MAX_CB_SIZE”. Therefore, it increases the PCI-DMA queues
- *      throughput. This CB allocation method also reduces the use of Linux
- *      DMA-able memory pool. Which are limited and used by other Linux
- *      sub-systems.
+ *      Indicates if the CB was allocated and mapped by userspace
+ *      (relevant to greco and above). User allocated CB is a command buffer,
+ *      allocated by the user, via malloc (or similar). After allocating the
+ *      CB, the user invokes - “memory ioctl” to map the user memory into a
+ *      device virtual address. The user provides this address via the
+ *      cb_handle field. The interface provides the ability to create a
+ *      large CBs, Which aren’t limited to “HL_MAX_CB_SIZE”. Therefore, it
+ *      increases the PCI-DMA queues throughput. This CB allocation method
+ *      also reduces the use of Linux DMA-able memory pool. Which are limited
+ *      and used by other Linux sub-systems.
  */
 #define HL_CS_CHUNK_FLAGS_USER_ALLOC_CB 0x1
 
@@ -840,12 +1266,17 @@ union hl_cb_args {
  */
 struct hl_cs_chunk {
 	union {
-		/* For external queue, this represents a Handle of CB on the
+		/* Goya/Gaudi:
+		 * For external queue, this represents a Handle of CB on the
 		 * Host.
 		 * For internal queue in Goya, this represents an SRAM or
 		 * a DRAM address of the internal CB. In Gaudi, this might also
 		 * represent a mapped host address of the CB.
 		 *
+		 * Greco onwards:
+		 * For H/W queue, this represents either a Handle of CB on the
+		 * Host, or an SRAM, a DRAM, or a mapped host address of the CB.
+		 *
 		 * A mapped host address is in the device address space, after
 		 * a host address was mapped by the device MMU.
 		 */
@@ -910,11 +1341,12 @@ struct hl_cs_chunk {
 	__u32 pad[10];
 };
 
-/* SIGNAL and WAIT/COLLECTIVE_WAIT flags are mutually exclusive */
+/* SIGNAL/WAIT/COLLECTIVE_WAIT flags are mutually exclusive */
 #define HL_CS_FLAGS_FORCE_RESTORE		0x1
 #define HL_CS_FLAGS_SIGNAL			0x2
 #define HL_CS_FLAGS_WAIT			0x4
 #define HL_CS_FLAGS_COLLECTIVE_WAIT		0x8
+
 #define HL_CS_FLAGS_TIMESTAMP			0x20
 #define HL_CS_FLAGS_STAGED_SUBMISSION		0x40
 #define HL_CS_FLAGS_STAGED_SUBMISSION_FIRST	0x80
@@ -1174,14 +1606,19 @@ union hl_wait_cs_args {
 
 /* Opcode to allocate device memory */
 #define HL_MEM_OP_ALLOC			0
+
 /* Opcode to free previously allocated device memory */
 #define HL_MEM_OP_FREE			1
+
 /* Opcode to map host and device memory */
 #define HL_MEM_OP_MAP			2
+
 /* Opcode to unmap previously mapped host and device memory */
 #define HL_MEM_OP_UNMAP			3
+
 /* Opcode to map a hw block */
 #define HL_MEM_OP_MAP_BLOCK		4
+
 /* Opcode to create DMA-BUF object for an existing device memory allocation
  * and to export an FD of that DMA-BUF back to the caller
  */
@@ -1400,7 +1837,16 @@ struct hl_debug_params_bmon {
 
 	/* Trace source ID */
 	__u32 id;
-	__u32 pad;
+
+	/* Control register */
+	__u32 control;
+
+	/* Two more address ranges that the user can request to filter */
+	__u64 start_addr2;
+	__u64 end_addr2;
+
+	__u64 start_addr3;
+	__u64 end_addr3;
 };
 
 struct hl_debug_params_spmu {
@@ -1409,7 +1855,11 @@ struct hl_debug_params_spmu {
 
 	/* Number of event types selection */
 	__u32 event_types_num;
-	__u32 pad;
+
+	/* TRC configuration register values */
+	__u32 pmtrc_val;
+	__u32 trc_ctrl_host_val;
+	__u32 trc_en_host_val;
 };
 
 /* Opcode for ETR component */
@@ -1524,16 +1974,23 @@ struct hl_debug_args {
  * (or if its the first CS for this context). The user can also order the
  * driver to run the "restore" phase explicitly
  *
+ * Goya/Gaudi:
  * There are two types of queues - external and internal. External queues
  * are DMA queues which transfer data from/to the Host. All other queues are
  * internal. The driver will get completion notifications from the device only
  * on JOBS which are enqueued in the external queues.
  *
+ * Greco onwards:
+ * There is a single type of queue for all types of engines, either DMA engines
+ * for transfers from/to the host or inside the device, or compute engines.
+ * The driver will get completion notifications from the device for all queues.
+ *
  * For jobs on external queues, the user needs to create command buffers
  * through the CB ioctl and give the CB's handle to the CS ioctl. For jobs on
  * internal queues, the user needs to prepare a "command buffer" with packets
  * on either the device SRAM/DRAM or the host, and give the device address of
  * that buffer to the CS ioctl.
+ * For jobs on H/W queues both options of command buffers are valid.
  *
  * This IOCTL is asynchronous in regard to the actual execution of the CS. This
  * means it returns immediately after ALL the JOBS were enqueued on their
@@ -1542,7 +1999,7 @@ struct hl_debug_args {
  *
  * Upon successful enqueue, the IOCTL returns a sequence number which the user
  * can use with the "Wait for CS" IOCTL to check whether the handle's CS
- * external JOBS have been completed. Note that if the CS has internal JOBS
+ * non-internal JOBS have been completed. Note that if the CS has internal JOBS
  * which can execute AFTER the external JOBS have finished, the driver might
  * report that the CS has finished executing BEFORE the internal JOBS have
  * actually finished executing.
-- 
2.25.1

