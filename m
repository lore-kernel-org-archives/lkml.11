Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284DFC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 22:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbiGEWtQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 18:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiGEWsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:48:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C31CB04
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61D54B81A46
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC97C341E9;
        Tue,  5 Jul 2022 22:47:51 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1o8rKh-001yMb-24;
        Tue, 05 Jul 2022 18:47:51 -0400
Message-ID: <20220705224750.896553364@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Jul 2022 18:45:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 11/13] scsi: qla2xxx: tracing: Use the new __vstring() helper
References: <20220705224453.120955146@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Instead of open coding a __dynamic_array() with a fixed length (which
defeats the purpose of the dynamic array in the first place). Use the new
__vstring() helper that will use a va_list and only write enough of the
string into the ring buffer that is needed.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/qla.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/qla.h b/include/trace/events/qla.h
index 5857cf682ee7..e7fd55e7dc3d 100644
--- a/include/trace/events/qla.h
+++ b/include/trace/events/qla.h
@@ -22,11 +22,11 @@ DECLARE_EVENT_CLASS(qla_log_event,
 
 	TP_STRUCT__entry(
 		__string(buf, buf)
-		__dynamic_array(char, msg, QLA_MSG_MAX)
+		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
 		__assign_str(buf, buf);
-		vsnprintf(__get_str(msg), QLA_MSG_MAX, vaf->fmt, *vaf->va);
+		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 
 	TP_printk("%s %s", __get_str(buf), __get_str(msg))
-- 
2.35.1
