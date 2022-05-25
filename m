Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802EEC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 May 2022 08:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiEYIQB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 May 2022 04:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241964AbiEYIPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:15:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6A98D880F3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:15:02 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 036D423A;
        Wed, 25 May 2022 01:15:02 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5C0683F73D;
        Wed, 25 May 2022 01:15:00 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3 14/16] arch_topology: Drop unnecessary check for uninitialised package_id
Date:   Wed, 25 May 2022 09:14:14 +0100
Message-Id: <20220525081416.3306043-15-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220525081416.3306043-14-sudeep.holla@arm.com>
References: <20220525081416.3306043-1-sudeep.holla@arm.com>
 <20220525081416.3306043-2-sudeep.holla@arm.com>
 <20220525081416.3306043-3-sudeep.holla@arm.com>
 <20220525081416.3306043-4-sudeep.holla@arm.com>
 <20220525081416.3306043-5-sudeep.holla@arm.com>
 <20220525081416.3306043-6-sudeep.holla@arm.com>
 <20220525081416.3306043-7-sudeep.holla@arm.com>
 <20220525081416.3306043-8-sudeep.holla@arm.com>
 <20220525081416.3306043-9-sudeep.holla@arm.com>
 <20220525081416.3306043-10-sudeep.holla@arm.com>
 <20220525081416.3306043-11-sudeep.holla@arm.com>
 <20220525081416.3306043-12-sudeep.holla@arm.com>
 <20220525081416.3306043-13-sudeep.holla@arm.com>
 <20220525081416.3306043-14-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the support of socket node parsing from the device tree and
assigning 0 as package_id in absence of socket nodes, there is no need
to check for invalid package_id. It is always initialised to 0 or values
from the device tree socket nodes.

Just drop that now redundant check for uninitialised package_id.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7876a7a82ec..b8f0d72908c8 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -606,7 +606,6 @@ static int __init parse_dt_topology(void)
 {
 	struct device_node *cn, *map;
 	int ret = 0;
-	int cpu;
 
 	cn = of_find_node_by_path("/cpus");
 	if (!cn) {
@@ -628,16 +627,6 @@ static int __init parse_dt_topology(void)
 
 	topology_normalize_cpu_scale();
 
-	/*
-	 * Check that all cores are in the topology; the SMP code will
-	 * only mark cores described in the DT as possible.
-	 */
-	for_each_possible_cpu(cpu)
-		if (cpu_topology[cpu].package_id < 0) {
-			ret = -EINVAL;
-			break;
-		}
-
 out_map:
 	of_node_put(map);
 out:
-- 
2.36.1

