Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA37C4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348080AbiBIELS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346424AbiBID2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:28:16 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7958AC06174F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 19:28:15 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644377292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=GDCExg53kc/pHnmsDC2kZisurgtykX/e2jcjrzmkqmY=;
        b=WYNjJYp+G80Mo0gl59SFMkAqBA5GW/4eXFU/GA+47VFJm1m9pr0J/uZ5huP8LvvkX+stxa
        ETi6iU9C6Mj/dqPePKX0a/kzCkk/QmlKkD9kZqjDo8qMEBDf098agsFlT3CuhdApzfYDys
        rqK5PvzIW4ECHKiOrhSxA1oRtnWR6uk=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tee: amdtee: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:27:43 +0800
Message-Id: <20220209032745.38570-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/tee/amdtee/call.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/amdtee/call.c b/drivers/tee/amdtee/call.c
index 07f36ac834c8..cec6e70f0ac9 100644
--- a/drivers/tee/amdtee/call.c
+++ b/drivers/tee/amdtee/call.c
@@ -122,7 +122,7 @@ static int amd_params_to_tee_params(struct tee_param *tee, u32 count,
 }
 
 static DEFINE_MUTEX(ta_refcount_mutex);
-static struct list_head ta_list = LIST_HEAD_INIT(ta_list);
+static LIST_HEAD(ta_list);
 
 static u32 get_ta_refcount(u32 ta_handle)
 {
-- 
2.25.1

