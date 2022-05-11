Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9423FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 03:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240980AbiEKDPz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 23:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240625AbiEKDPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 23:15:49 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25E0120B7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 20:15:45 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kyg4R6NF9zfbVg;
        Wed, 11 May 2022 11:14:31 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 11:15:43 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <gregkh@linuxfoundation.org>, <salah.triki@gmail.com>,
        <trix@redhat.com>, <speakup@linux-speakup.org>,
        <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] accessiblity: speakup: Add missing misc_deregister in softsynth_probe
Date:   Wed, 11 May 2022 11:29:37 +0800
Message-ID: <20220511032937.2736738-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

softsynth_probe misses a call misc_deregister() in an error path, this
patch fixes that.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 drivers/accessibility/speakup/speakup_soft.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accessibility/speakup/speakup_soft.c b/drivers/accessibility/speakup/speakup_soft.c
index 1ced2721513e..99f1d4ac426a 100644
--- a/drivers/accessibility/speakup/speakup_soft.c
+++ b/drivers/accessibility/speakup/speakup_soft.c
@@ -397,6 +397,7 @@ static int softsynth_probe(struct spk_synth *synth)
 	synthu_device.name = "softsynthu";
 	synthu_device.fops = &softsynthu_fops;
 	if (misc_register(&synthu_device)) {
+		misc_deregister(&synth_device);
 		pr_warn("Couldn't initialize miscdevice /dev/softsynthu.\n");
 		return -ENODEV;
 	}
--
2.31.1

