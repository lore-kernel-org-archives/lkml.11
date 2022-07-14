Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B9C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 13:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbiGNNjE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239541AbiGNNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:39:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 898D119289;
        Thu, 14 Jul 2022 06:39:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AE5862090;
        Thu, 14 Jul 2022 13:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81832C34115;
        Thu, 14 Jul 2022 13:38:58 +0000 (UTC)
Date:   Thu, 14 Jul 2022 09:38:57 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 08/13 v2] USB: mtu3: tracing: Use the new __vstring() helper
Message-ID: <20220714093857.1135e95a@gandalf.local.home>
In-Reply-To: <20220705224750.354926535@goodmis.org>
References: <20220705224453.120955146@goodmis.org>
        <20220705224750.354926535@goodmis.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d6485fe54bd4f04256a8500156a7c05cb3fb9592 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
Date: Tue, 5 Jul 2022 18:45:01 -0400
Subject: [PATCH] USB: mtu3: tracing: Use the new __vstring() helper

Instead of open coding a __dynamic_array() with a fixed length (which
defeats the purpose of the dynamic array in the first place). Use the new
__vstring() helper that will use a va_list and only write enough of the
string into the ring buffer that is needed.

Link: https://lkml.kernel.org/r/20220705224750.354926535@goodmis.org

Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---

Changes since v1: remove ',' that fails the build.

 drivers/usb/mtu3/mtu3_trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/mtu3/mtu3_trace.h b/drivers/usb/mtu3/mtu3_trace.h
index 1b897636daf2..ef3c17e2f8a6 100644
--- a/drivers/usb/mtu3/mtu3_trace.h
+++ b/drivers/usb/mtu3/mtu3_trace.h
@@ -25,11 +25,11 @@ TRACE_EVENT(mtu3_log,
 	TP_ARGS(dev, vaf),
 	TP_STRUCT__entry(
 		__string(name, dev_name(dev))
-		__dynamic_array(char, msg, MTU3_MSG_MAX)
+		__vstring(msg, vaf->fmt, vaf->va)
 	),
 	TP_fast_assign(
 		__assign_str(name, dev_name(dev));
-		vsnprintf(__get_str(msg), MTU3_MSG_MAX, vaf->fmt, *vaf->va);
+		__assign_vstr(msg, vaf->fmt, vaf->va);
 	),
 	TP_printk("%s: %s", __get_str(name), __get_str(msg))
 );
-- 
2.35.1

