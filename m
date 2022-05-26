Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97481C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 20:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238983AbiEZUcT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 16:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238913AbiEZUcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:32:15 -0400
X-Greylist: delayed 936 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 26 May 2022 13:32:15 PDT
Received: from mail.codeweavers.com (mail.codeweavers.com [50.203.203.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1002FBA99F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5VYllHU10anpVUUYivEzMyIwr1agxY+1jmV5w60yc8k=; b=G516JXowGisfhh9C9HDuc3tY05
        32/3UQAJJp+4hF6T9aNabsV232CX2VVNNahx5lBpUBVG/XLjpVm9BS2dJcDYcLS41w1lzdecsvC04
        B65VgjDZJaKbIjOH8vPJi4e5ssuzPELSoe9rAzSoP9cDupTAPpgEcYFIV8LhnsiEzWRQ=;
Received: from [10.69.141.126] (helo=localhost)
        by mail.codeweavers.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <schapla@codeweavers.com>)
        id 1nuJuL-0001dX-Ch; Thu, 26 May 2022 15:16:33 -0500
From:   "Shawn M. Chapla" <schapla@codeweavers.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Shawn M . Chapla" <schapla@codeweavers.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH] perf data: Prefer sampled CPU when exporting JSON
Date:   Thu, 26 May 2022 16:14:47 -0400
Message-Id: <20220526201506.2028281-1-schapla@codeweavers.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU has been explicitly sampled (via --sample-cpu), prefer this
sampled value over the thread CPU value when exporting to JSON.

Signed-off-by: Shawn M. Chapla <schapla@codeweavers.com>
---
 tools/perf/util/data-convert-json.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index f1ab6edba446..613d6ae82663 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -149,6 +149,7 @@ static int process_sample_event(struct perf_tool *tool,
 	struct convert_json *c = container_of(tool, struct convert_json, tool);
 	FILE *out = c->out;
 	struct addr_location al, tal;
+	u64 sample_type = __evlist__combined_sample_type(evsel->evlist);
 	u8 cpumode = PERF_RECORD_MISC_USER;
 
 	if (machine__resolve(machine, &al, sample) < 0) {
@@ -168,7 +169,9 @@ static int process_sample_event(struct perf_tool *tool,
 	output_json_key_format(out, true, 3, "pid", "%i", al.thread->pid_);
 	output_json_key_format(out, true, 3, "tid", "%i", al.thread->tid);
 
-	if (al.thread->cpu >= 0)
+	if ((sample_type & PERF_SAMPLE_CPU))
+		output_json_key_format(out, true, 3, "cpu", "%i", sample->cpu);
+	else if (al.thread->cpu >= 0)
 		output_json_key_format(out, true, 3, "cpu", "%i", al.thread->cpu);
 
 	output_json_key_string(out, true, 3, "comm", thread__comm_str(al.thread));
-- 
2.36.1

