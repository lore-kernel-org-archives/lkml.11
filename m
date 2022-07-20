Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1888C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 08:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiGTIO1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 04:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240502AbiGTIOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 04:14:11 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647A76C107
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 01:13:29 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LnpKv2VClzjWwT;
        Wed, 20 Jul 2022 16:10:43 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Jul 2022 16:13:27 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <guodong.xu@linaro.org>,
        <hesham.almatary@huawei.com>, <john.garry@huawei.com>,
        <shenyang39@huawei.com>, <kprateek.nayak@amd.com>,
        <yu.c.chen@intel.com>, <wuyun.abel@bytedance.com>
Subject: [RESEND PATCH v5 0/2] sched/fair: Scan cluster before scanning LLC in wake-up path
Date:   Wed, 20 Jul 2022 16:11:48 +0800
Message-ID: <20220720081150.22167-1-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the follow-up work to support cluster scheduler. Previously
we have added cluster level in the scheduler for both ARM64[1] and
X86[2] to support load balance between clusters to bring more memory
bandwidth and decrease cache contention. This patchset, on the other
hand, takes care of wake-up path by giving CPUs within the same cluster
a try before scanning the whole LLC to benefit those tasks communicating
with each other.

[1] 778c558f49a2 ("sched: Add cluster scheduler level in core and related Kconfig for ARM64")
[2] 66558b730f25 ("sched: Add cluster scheduler level for x86")

Change since v4:
- rename cpus_share_resources to cpus_share_lowest_cache to be more informative, per Tim
- return -1 when nr==0 in scan_cluster(), per Abel
Thanks!
Link: https://lore.kernel.org/lkml/20220609120622.47724-1-yangyicong@hisilicon.com/

Change since v3:
- fix compile error when !CONFIG_SCHED_CLUSTER, reported by lkp test.
Link: https://lore.kernel.org/lkml/20220608095758.60504-1-yangyicong@hisilicon.com/

Change since v2:
- leverage SIS_PROP to suspend redundant scanning when LLC is overloaded
- remove the ping-pong suppression
- address the comment from Tim, thanks.
Link: https://lore.kernel.org/lkml/20220126080947.4529-1-yangyicong@hisilicon.com/

Change since v1:
- regain the performance data based on v5.17-rc1
- rename cpus_share_cluster to cpus_share_resources per Vincent and Gautham, thanks!
Link: https://lore.kernel.org/lkml/20211215041149.73171-1-yangyicong@hisilicon.com/

Barry Song (2):
  sched: Add per_cpu cluster domain info and cpus_share_lowest_cache API
  sched/fair: Scan cluster before scanning LLC in wake-up path

 include/linux/sched/sd_flags.h |  7 ++++++
 include/linux/sched/topology.h |  8 ++++++-
 kernel/sched/core.c            | 12 ++++++++++
 kernel/sched/fair.c            | 44 +++++++++++++++++++++++++++++++---
 kernel/sched/sched.h           |  2 ++
 kernel/sched/topology.c        | 15 ++++++++++++
 6 files changed, 84 insertions(+), 4 deletions(-)

-- 
2.24.0

