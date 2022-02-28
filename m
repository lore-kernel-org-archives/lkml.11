Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C360EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 12:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiB1Mq0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 07:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236721AbiB1MqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:46:07 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453ED74878
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:45:13 -0800 (PST)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K6g6g15L0zdfkN;
        Mon, 28 Feb 2022 20:43:55 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 20:45:10 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Feb 2022 20:45:10 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <f.fangjian@huawei.com>, <huangguangbin2@huawei.com>,
        <lipeng321@huawei.com>, <shenjian15@huawei.com>,
        <moyufeng@huawei.com>
Subject: [PATCH V2 0/2] drivers/perf: hisi: Add driver for HNS3 PMU
Date:   Mon, 28 Feb 2022 20:39:53 +0800
Message-ID: <20220228123955.30284-1-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds driver for HNS3(HiSilicon network system version 3)
PMU and doc to descript it.

Change logs:
V1 -> V2:
 - Modify the comments of John Garry.
 - Link: https://lore.kernel.org/linux-arm-kernel/20220117015222.9617-1-huangguangbin2@huawei.com/

Guangbin Huang (2):
  drivers/perf: hisi: Add description for HNS3 PMU driver
  drivers/perf: hisi: add driver for HNS3 PMU

 Documentation/admin-guide/perf/hns3-pmu.rst |  136 ++
 MAINTAINERS                                 |    6 +
 drivers/perf/hisilicon/Kconfig              |   10 +
 drivers/perf/hisilicon/Makefile             |    1 +
 drivers/perf/hisilicon/hns3_pmu.c           | 1632 +++++++++++++++++++
 include/linux/cpuhotplug.h                  |    1 +
 6 files changed, 1786 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hns3-pmu.rst
 create mode 100644 drivers/perf/hisilicon/hns3_pmu.c

-- 
2.33.0

