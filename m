Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1524C28D13
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 02:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiHWCWE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbiHWCWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:22:02 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D445AC73
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 19:22:01 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MBXtv1VQrzXdyX;
        Tue, 23 Aug 2022 10:17:43 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 10:21:59 +0800
Received: from huawei.com (10.67.174.169) by dggpemm500001.china.huawei.com
 (7.185.36.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 23 Aug
 2022 10:21:59 +0800
From:   Chen Lifu <chenlifu@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <feng.tang@intel.com>, <gregkh@linuxfoundation.org>,
        <peterz@infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <chenlifu@huawei.com>
Subject: [PATCH -next] x86/tsc: Make art_related_clocksource static
Date:   Tue, 23 Aug 2022 10:18:21 +0800
Message-ID: <20220823021821.3052159-1-chenlifu@huawei.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The symbol is not used outside of the file, so mark it static.

Fixes the following warning:

arch/x86/kernel/tsc.c:53:20: warning:
	symbol 'art_related_clocksource' was not declared. Should it be static?

Signed-off-by: Chen Lifu <chenlifu@huawei.com>
---
 arch/x86/kernel/tsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index cafacb2e58cc..a78e73da4a74 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -49,11 +49,11 @@ static DEFINE_STATIC_KEY_FALSE(__use_tsc);
 int tsc_clocksource_reliable;
 
 static u32 art_to_tsc_numerator;
 static u32 art_to_tsc_denominator;
 static u64 art_to_tsc_offset;
-struct clocksource *art_related_clocksource;
+static struct clocksource *art_related_clocksource;
 
 struct cyc2ns {
 	struct cyc2ns_data data[2];	/*  0 + 2*16 = 32 */
 	seqcount_latch_t   seq;		/* 32 + 4    = 36 */
 
-- 
2.37.1

