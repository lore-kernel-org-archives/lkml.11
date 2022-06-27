Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7587DC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 16:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239682AbiF0QwJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 12:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbiF0Qva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 12:51:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D5E61114F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 09:51:29 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1434175A;
        Mon, 27 Jun 2022 09:51:29 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A50543F792;
        Mon, 27 Jun 2022 09:51:27 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Qing Wang <wangqing@vivo.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Darren Hart <darren@os.amperecomputing.com>
Subject: [PATCH v5 16/19] arch_topology: Limit span of cpu_clustergroup_mask()
Date:   Mon, 27 Jun 2022 17:50:44 +0100
Message-Id: <20220627165047.336669-17-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627165047.336669-1-sudeep.holla@arm.com>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ionela Voinescu <ionela.voinescu@arm.com>

Currently the cluster identifier is not set on DT based platforms.
The reset or default value is -1 for all the CPUs. Once we assign the
cluster identifier values correctly, the cluster_sibling mask will be
populated and returned by cpu_clustergroup_mask() to contribute in the
creation of the CLS scheduling domain level, if SCHED_CLUSTER is
enabled.

To avoid topologies that will result in questionable or incorrect
scheduling domains, impose restrictions regarding the span of clusters,
as presented to scheduling domains building code: cluster_sibling should
not span more or the same CPUs as cpu_coregroup_mask().

This is needed in order to obtain a strict separation between the MC and
CLS levels, and maintain the same domains for existing platforms in
the presence of CONFIG_SCHED_CLUSTER, where the new cluster information
is redundant and irrelevant for the scheduler.

While previously the scheduling domain builder code would have removed MC
as redundant and kept CLS if SCHED_CLUSTER was enabled and the
cpu_coregroup_mask() and cpu_clustergroup_mask() spanned the same CPUs,
now CLS will be removed and MC kept.

Link: https://lore.kernel.org/r/20220621192034.3332546-18-sudeep.holla@arm.com
Cc: Darren Hart <darren@os.amperecomputing.com>
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/base/arch_topology.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 46fa1b70b02b..277b65cf3306 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -686,6 +686,14 @@ const struct cpumask *cpu_coregroup_mask(int cpu)
 
 const struct cpumask *cpu_clustergroup_mask(int cpu)
 {
+	/*
+	 * Forbid cpu_clustergroup_mask() to span more or the same CPUs as
+	 * cpu_coregroup_mask().
+	 */
+	if (cpumask_subset(cpu_coregroup_mask(cpu),
+			   &cpu_topology[cpu].cluster_sibling))
+		return get_cpu_mask(cpu);
+
 	return &cpu_topology[cpu].cluster_sibling;
 }
 
-- 
2.36.1

