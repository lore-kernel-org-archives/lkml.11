Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664DCC28D13
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Aug 2022 21:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiHVVeG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 17:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237662AbiHVVeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:34:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D65D33419
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:34:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-337ed9110c2so164675857b3.15
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=PjKTkSpXN7z/1vO6BY9+ZapPx/17h+7Me4eIBkw8jXs=;
        b=tJw8ADOvD+JfoFv1mCrbL8K9kKBzqqJ1EKt8KjQblt7okK8atz7gbBE6d7S3t4H0i+
         3WifvVOXU8+vcq7InqpZxvC+4schTKAqIGm6pIGyHvoDfrUlZXYxpi/ols/FVXI7jJdw
         3bbaqhAW1NVUtEoMy5gI5wXpTNl5MHAw5Uo+tR5DqZmFvhWiLzAAuTiQG+qJeQmRfvp/
         YBpOIjq9X82GrRPGTW2fvGV3f7FwCISfZcRscWGJuW5z+wz1eNbl8fftQK2nqcDNYzAx
         TJ7qJuZtHsQKseBizo3gNLa3lUe+hzMv4yU7qNyhMGT1wM1dF0W3HKnNzQV30DfLVK5x
         UA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=PjKTkSpXN7z/1vO6BY9+ZapPx/17h+7Me4eIBkw8jXs=;
        b=bliA986eaQDNbUVAeOGAkvdRc9knhY1ibu9EDF6AtHLpeK//3YxexR2Q4O/KCk1y8k
         2MvtURcZy0RUAGsuh+SaXBne+rXcLtRiBnxircMw376B9RZ0hvuYJFdSJoV5BzN7PG3J
         1ObUiQQRgs98xefIjtriF2u2dyTMpiPqkFcnCVyofBqmL2x3HgCheLAs6Rjzg8oM/SKZ
         rHwNHxtEDH0v75U2idZIysDrW06nXhzJSlqfbQp4mHJsZ1rJSANiKwM+otOUBRn+g1sH
         OgYHGXjZSaWxn5QE7by203O/rViTHEtZ2VdCvEeGWUlN6Gk9yw8df3m7SE4piaVZuY7L
         IvbQ==
X-Gm-Message-State: ACgBeo2BovrUiwcmvhQ5vzP0r3H+lsIqovkjQRFsDQA50Xgw6hi/XbjW
        NfeR0ZPSt7Bmjy/HUE4OeZJBOq7qUOvC
X-Google-Smtp-Source: AA6agR6xatGqBGUTcHv4+qKQeK4H3e5wE2VOPYMYZxC/z3a/ux9ueLbCKnh/zlVXmCFy7KgAZCcd0b9ZUOrd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:2768:cfe4:142e:cbca])
 (user=irogers job=sendgmr) by 2002:a25:5051:0:b0:68f:f31f:b590 with SMTP id
 e78-20020a255051000000b0068ff31fb590mr19311377ybb.569.1661204041297; Mon, 22
 Aug 2022 14:34:01 -0700 (PDT)
Date:   Mon, 22 Aug 2022 14:33:51 -0700
Message-Id: <20220822213352.75721-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a-goog
Subject: [PATCH v1 1/2] perf stat: Clear reset_group for each stat run
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a weak group is broken then the reset_group flag remains set for
the next run. Having reset_group set means the counter isn't created
and ultimately a segfault.

A simple reproduction of this is:
perf stat -r2 -e '{cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles,cycles}:W
which will be added as a test in the next patch.

Fixes: 4804e0111662 ("perf stat: Use affinity for opening events")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 7fb81a44672d..54cd29d07ca8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -826,6 +826,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 	}
 
 	evlist__for_each_entry(evsel_list, counter) {
+		counter->reset_group = false;
 		if (bpf_counter__load(counter, &target))
 			return -1;
 		if (!evsel__is_bpf(counter))
-- 
2.37.2.609.g9ff673ca1a-goog

