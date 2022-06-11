Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B840EC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jun 2022 07:14:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiFKHOe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jun 2022 03:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiFKHOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 03:14:30 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A976167E9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 00:14:28 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LKptn3RXBz1K96J;
        Sat, 11 Jun 2022 15:12:33 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 11 Jun 2022 15:14:25 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 15:14:25 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>,
        <linux-accelerators@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangfei.gao@linaro.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH 0/2] crypto: hisilicon - supports device isolation feature
Date:   Sat, 11 Jun 2022 15:08:06 +0800
Message-ID: <20220611070808.49219-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hardware error isolation feature for ACC. Defines a driver debugfs
node that used to configures the hardware error frequency. When the error
frequency is exceeded, the device will be isolated. The isolation strategy 
can be defined in each driver module. e.g. Defining the isolation strategy
for ACC, if the AER error frequency exceeds the value of setting for a 
certain period of time, The device will not be available in user space. The
VF device use the PF device isolation strategy. as well as the isolation 
strategy should not be set during device use.

Kai Ye (2):
  uacce: supports device isolation feature
  crypto: hisilicon/qm - defining the device isolation strategy

 drivers/crypto/hisilicon/qm.c | 149 +++++++++++++++++++++++++++++++---
 drivers/misc/uacce/uacce.c    |  76 +++++++++++++++++
 include/linux/hisi_acc_qm.h   |   8 ++
 include/linux/uacce.h         |  21 ++++-
 4 files changed, 241 insertions(+), 13 deletions(-)

-- 
2.33.0

