Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF22C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 07:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344715AbiCUHES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 03:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245498AbiCUHEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:04:12 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EE4757C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 00:02:48 -0700 (PDT)
Received: from kwepemi100022.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KMQVt5GcjzCqvP;
        Mon, 21 Mar 2022 15:00:38 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi100022.china.huawei.com (7.221.188.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 15:02:43 +0800
Received: from localhost.localdomain (10.67.164.66) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Mar 2022 15:02:43 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Add Support for HiSilicon CPA PMU
Date:   Mon, 21 Mar 2022 15:01:22 +0800
Message-ID: <20220321070124.41338-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for HiSilicon CPA PMU driver. Json file in perf tool
is applied in 
https://lore.kernel.org/linux-arm-kernel/YhkhSZp+a715Ldzr@kernel.org/.

Change since v2:
- Associate CPA PMUs with CPUs online, rather than CPUs in the nearest SCCL.
- Move CPA power management to probe and remove function.
- Address the comments from John.
- Link: https://lore.kernel.org/linux-arm-kernel/20220224111129.41416-1-liuqi115@huawei.com/

Change since v1:
- Address the comments from John.
- Link: https://lore.kernel.org/linux-arm-kernel/20220214114228.40859-1-liuqi115@huawei.com/

Qi Liu (2):
  drivers/perf: hisi: Associate PMUs in SICL with CPUs online
  drivers/perf: hisi: Add Support for CPA PMU

 drivers/perf/hisilicon/Makefile              |   2 +-
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c | 400 +++++++++++++++++++
 drivers/perf/hisilicon/hisi_uncore_pa_pmu.c  |  18 +-
 drivers/perf/hisilicon/hisi_uncore_pmu.c     |   4 +
 drivers/perf/hisilicon/hisi_uncore_pmu.h     |   1 +
 include/linux/cpuhotplug.h                   |   1 +
 6 files changed, 414 insertions(+), 12 deletions(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c

-- 
2.24.0

