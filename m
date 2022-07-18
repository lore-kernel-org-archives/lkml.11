Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74159C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jul 2022 13:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiGRNKp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jul 2022 09:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiGRNKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:10:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC221E3F5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:10:29 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Lmj3T2PM1zFq9Y;
        Mon, 18 Jul 2022 21:09:25 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemi500012.china.huawei.com
 (7.221.188.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 18 Jul
 2022 21:10:25 +0800
From:   Xu Qiang <xuqiang36@huawei.com>
To:     <maz@kernel.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <xuqiang36@huawei.com>,
        <rui.xiang@huawei.com>
Subject: [PATCH -next 0/2] Fix a bug and commit a code optimization
Date:   Mon, 18 Jul 2022 13:07:57 +0000
Message-ID: <20220718130759.67777-1-xuqiang36@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xu Qiang (2):
  irqdomain: fix possible uninitialized variable in irq_find_mapping()
  irqdomain: Replace revmap_direct_max_irq field with hwirq_max field

 kernel/irq/irqdomain.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
2.17.1

