Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A2EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391949AbiEFMb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 08:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391975AbiEFMb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:31:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1E769CF7
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651840023; x=1683376023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5ZmIqJMdjmQT6Lr5XLTTSb2o3piQNy4WM6RC+APymAA=;
  b=R7cOQ1w5nFHuEZ6yCyx5Or3k3inO+FS5CgBuA7+Y4D8ttpO9a+MkViMr
   amf9yR9MPnEurypunp5soCSuM/UboIFEAoFYA2fU79CmTDKKdF3ONfHwD
   41CR5nHhpQIVXWUahtgY/bRtxnjWyvH8u8ovcWCyf9YW3eX77oUwplTh8
   H8Zbn0pZ90R5NQgzT6xoTug/gYtrCCY86XlD4VDRoB+x2iTGfLW1ovNCA
   vxFdxNIjXLKbif8Z1uWzwMAES5bf3wT8WP2ktyf3jpNpb3xgNAr7i3cu+
   SjwFvcGQxsawoH4B/z9ojVKTnob9d5gu1SUmRQajzzqP4XSpqHtwZpgNk
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045889"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709441213"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:27:00 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 23/23] perf tools: Allow system-wide events to keep their own threads
Date:   Fri,  6 May 2022 15:26:01 +0300
Message-Id: <20220506122601.367589-24-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506122601.367589-1-adrian.hunter@intel.com>
References: <20220506122601.367589-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System-wide events do not have threads, so do not propagate threads to
them.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/lib/perf/evlist.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 9a6801b53274..e6c98a6e3908 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -52,8 +52,11 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 		evsel->cpus = perf_cpu_map__get(evsel->own_cpus);
 	}
 
-	perf_thread_map__put(evsel->threads);
-	evsel->threads = perf_thread_map__get(evlist->threads);
+	if (!evsel->system_wide) {
+		perf_thread_map__put(evsel->threads);
+		evsel->threads = perf_thread_map__get(evlist->threads);
+	}
+
 	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
 }
 
-- 
2.25.1

