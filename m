Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D5FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 01:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiBQB2D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:28:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiBQB2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 20:28:01 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78769C3C0A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 17:27:47 -0800 (PST)
X-QQ-mid: bizesmtp76t1645061254tfsrxxo5
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 17 Feb 2022 09:27:28 +0800 (CST)
X-QQ-SSF: 01400000002000B0E000B00A0000000
X-QQ-FEAT: F3yR32iATbg1yTWtYZrkwc0LvGRXLpKq+G+hKFTKMOMUCscU9D8H9mHRfpnx7
        5hWHQqTrCCtrt/DnDGqeqpcC8P0ms+D1H3lSo9P/x05r/8uf+GbE0zIWTUaSjVDdmwV2OMx
        CkF63pHCkoUnhhnd3TLRssQAF4u3+/k/69I0CnPyCr4bDJOaS2fUpyhO7Qco146itjwdY5x
        YMifdlTSwZL1nELqEeF2496M/yVydrV/evNa3FIUWF/WjZP/Qe6XsBxJ0Rqg/9Exy8YC0m2
        CaKJaQ/DyP5YoFEMuXjpoa+VakimcqYkU2I7OJlfYfS3EHpiLTL4AyXyo4JhcOxAPU8jEF3
        byyOY8L
X-QQ-GoodBg: 2
From:   tangmeng <tangmeng@uniontech.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org
Cc:     linux-kernel@vger.kernel.org, tangmeng <tangmeng@uniontech.com>
Subject: [PATCH] perf cpumap: Migrate to libperf cpumap api
Date:   Thu, 17 Feb 2022 09:27:26 +0800
Message-Id: <20220217012726.27858-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from directly accessing the perf_cpu_map__cpu to using the
appropriate libperf API when possible. Using the API simplifies
the job of refactoring use of perf_cpu_map__cpu.

Signed-off-by: tangmeng <tangmeng@uniontech.com>
---
 tools/perf/util/cpumap.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 12b2243222b0..986d580d8984 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -508,17 +508,18 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size)
 						"%s%d", COMMA,
 						map->map[i].cpu);
 			}
-		} else if (((i - start) != (cpu.cpu - map->map[start].cpu)) || last) {
+		} else if (((i - start) != (cpu.cpu - perf_cpu_map__cpu(map, start).cpu)) || last) {
 			int end = i - 1;
 
 			if (start == end) {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d", COMMA,
-						map->map[start].cpu);
+						perf_cpu_map__cpu(map, start).cpu);
 			} else {
 				ret += snprintf(buf + ret, size - ret,
 						"%s%d-%d", COMMA,
-						map->map[start].cpu, map->map[end].cpu);
+						perf_cpu_map__cpu(map, start).cpu,
+						perf_cpu_map__cpu(map, end).cpu);
 			}
 			first = false;
 			start = i;
-- 
2.20.1



