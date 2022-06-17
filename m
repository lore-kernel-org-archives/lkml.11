Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E250C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 04:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379942AbiFQEOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jun 2022 00:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379910AbiFQEOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 00:14:03 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D90365D1C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 21:14:02 -0700 (PDT)
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LPQbg6G81z1K9VP;
        Fri, 17 Jun 2022 12:11:59 +0800 (CST)
Received: from dggpeml500018.china.huawei.com (7.185.36.186) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 12:14:00 +0800
Received: from huawei.com (10.67.174.191) by dggpeml500018.china.huawei.com
 (7.185.36.186) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 12:13:59 +0800
From:   Zhang Qiao <zhangqiao22@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>,
        <zhangqiao22@huawei.com>
Subject: [PATCH 0/2] scheduler loadbalancer cleanup
Date:   Sat, 18 Jun 2022 02:11:49 +0800
Message-ID: <20220617181151.29980-1-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.191]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500018.china.huawei.com (7.185.36.186)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Qiao (2):
  sched/fair: Remove redundant word " *"
  sched: Remove unused function group_first_cpu()

 kernel/sched/fair.c  | 2 +-
 kernel/sched/sched.h | 9 ---------
 2 files changed, 1 insertion(+), 10 deletions(-)

-- 
2.18.0.huawei.25

