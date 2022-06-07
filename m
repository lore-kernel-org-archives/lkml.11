Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BD9CCA47C
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 00:15:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385107AbiFGWp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 18:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378970AbiFGV34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:29:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE574152BB6;
        Tue,  7 Jun 2022 12:02:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50459B822C0;
        Tue,  7 Jun 2022 19:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E156C385A2;
        Tue,  7 Jun 2022 19:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654628548;
        bh=AJpDc4CRCDEYezNwJ7xnI6htH0qAKgCFMdxiiCckPkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=elqTAPCSlFN6DiJ6Rflr2a3O6hSW2WsCBc7H1EHGhyt7vtsT3v0XfvJlzpGHs23RS
         6JtUEJ7/d9GjOIc5Gvm4exEk7khaRsXLJMlSNiowyvJl+6P4nPWhWFtb90gc1tzeb9
         exqzKVaoT+s2JZToDkHD33lyeFLAGRn+Ps02KDBw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yang Jihong <yangjihong1@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 367/879] perf tools: Add missing headers needed by util/data.h
Date:   Tue,  7 Jun 2022 18:58:05 +0200
Message-Id: <20220607165013.523342552@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Jihong <yangjihong1@huawei.com>

[ Upstream commit 4d27cf1d9de5becfa4d1efb2ea54dba1b9fc962a ]

'struct perf_data' in util/data.h uses the "u64" data type, which is
defined in "linux/types.h".

If we only include util/data.h, the following compilation error occurs:

  util/data.h:38:3: error: unknown type name ‘u64’
     u64    version;
     ^~~

Solution: include "linux/types.h." to add the needed type definitions.

Fixes: 258031c017c353e8 ("perf header: Add DIR_FORMAT feature to describe directory data")
Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20220429090539.212448-1-yangjihong1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/data.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index c9de82af5584..1402d9657ef2 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -4,6 +4,7 @@
 
 #include <stdio.h>
 #include <stdbool.h>
+#include <linux/types.h>
 
 enum perf_data_mode {
 	PERF_DATA_MODE_WRITE,
-- 
2.35.1



