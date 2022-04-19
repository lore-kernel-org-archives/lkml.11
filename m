Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE7FCC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 16:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242962AbiDSQ4l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 12:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349413AbiDSQuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:50:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA2943B288
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:48:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0E71063;
        Tue, 19 Apr 2022 09:48:10 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.10.212])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 26FAC3F73B;
        Tue, 19 Apr 2022 09:48:09 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, dietmar.eggemann@arm.com,
        vincent.guittot@linaro.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        lukasz.luba@arm.com
Subject: [PATCH] arch_topology: Trace the update thermal pressure
Date:   Tue, 19 Apr 2022 17:48:01 +0100
Message-Id: <20220419164801.29078-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add trace event to capture the moment of the call for updating the thermal
pressure value. It's helpful to investigate how often those events occurs
in a system dealing with throttling. This trace event is needed since the
old 'cdev_update' might not be used by some drivers. Also, the new trace
event shows capacity value, not a cooling state.

We already have a trace point 'pelt_thermal_tp' which after a change to
trace event can be paired with this new 'thermal_pressure_update' and
derive more insight what is going on in the system under pressure
(and why).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/base/arch_topology.c   |  4 ++++
 include/trace/events/thermal.h | 19 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1d6636ebaac5..4f0392de3081 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -19,6 +19,8 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 
+#include <trace/events/thermal.h>
+
 static DEFINE_PER_CPU(struct scale_freq_data __rcu *, sft_data);
 static struct cpumask scale_freq_counters_mask;
 static bool scale_freq_invariant;
@@ -195,6 +197,8 @@ void topology_update_thermal_pressure(const struct cpumask *cpus,
 
 	th_pressure = max_capacity - capacity;
 
+	trace_thermal_pressure_update(cpu, th_pressure);
+
 	for_each_cpu(cpu, cpus)
 		WRITE_ONCE(per_cpu(thermal_pressure, cpu), th_pressure);
 }
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 8a5f04888abd..1bf08ee1a25b 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -65,6 +65,25 @@ TRACE_EVENT(cdev_update,
 	TP_printk("type=%s target=%lu", __get_str(type), __entry->target)
 );
 
+TRACE_EVENT(thermal_pressure_update,
+
+	TP_PROTO(int cpu, unsigned long thermal_pressure),
+
+	TP_ARGS(cpu, thermal_pressure),
+
+	TP_STRUCT__entry(
+		__field(int, cpu)
+		__field(unsigned long, thermal_pressure)
+	),
+
+	TP_fast_assign(
+		__entry->cpu = cpu;
+		__entry->thermal_pressure = thermal_pressure;
+	),
+
+	TP_printk("cpu=%d thermal_pressure=%lu", __entry->cpu, __entry->thermal_pressure)
+);
+
 TRACE_EVENT(thermal_zone_trip,
 
 	TP_PROTO(struct thermal_zone_device *tz, int trip,
-- 
2.17.1

