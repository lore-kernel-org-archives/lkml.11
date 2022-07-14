Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85576C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 16:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbiGNQnt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 12:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiGNQng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 12:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD504B0C4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 09:43:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F78E6204F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71101C341C8;
        Thu, 14 Jul 2022 16:43:29 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1oC1w0-004lLq-EH;
        Thu, 14 Jul 2022 12:43:28 -0400
Message-ID: <20220714164328.278538105@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 14 Jul 2022 12:42:58 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Tom Rix <trix@redhat.com>
Subject: [for-next][PATCH 02/23] tracing/histograms: Simplify create_hist_fields()
References: <20220714164256.403842845@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Yejian <zhengyejian1@huawei.com>

When I look into implements of create_hist_fields(), I think there can be
following two simplifications:
  1. If something wrong happened in parse_var_defs(), free_var_defs() would
     have been called in it, so no need goto free again after calling it;
  2. After calling create_key_fields(), regardless of the value of 'ret', it
     then always runs into 'out: ', so the judge of 'ret' is redundant.

Link: https://lkml.kernel.org/r/20220630013152.164871-1-zhengyejian1@huawei.com

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e87a46794079..fdf784620c28 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4455,7 +4455,7 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
 
 	ret = parse_var_defs(hist_data);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = create_val_fields(hist_data, file);
 	if (ret)
@@ -4466,8 +4466,7 @@ static int create_hist_fields(struct hist_trigger_data *hist_data,
 		goto out;
 
 	ret = create_key_fields(hist_data, file);
-	if (ret)
-		goto out;
+
  out:
 	free_var_defs(hist_data);
 
-- 
2.35.1
