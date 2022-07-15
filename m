Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC09EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jul 2022 21:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbiGOVYa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jul 2022 17:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiGOVY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:24:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7FF43E68;
        Fri, 15 Jul 2022 14:24:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F02E617B1;
        Fri, 15 Jul 2022 21:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE25C34115;
        Fri, 15 Jul 2022 21:24:25 +0000 (UTC)
Date:   Fri, 15 Jul 2022 17:24:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 13/23] USB: mtu3: tracing: Use the new
 __vstring() helper
Message-ID: <20220715172423.6b57b9eb@gandalf.local.home>
In-Reply-To: <962e59c25e981676014157cd111db9e16e237339.camel@mediatek.com>
References: <20220714164256.403842845@goodmis.org>
        <20220714164330.311734558@goodmis.org>
        <962e59c25e981676014157cd111db9e16e237339.camel@mediatek.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 18:01:44 +0800
Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:

>  irq/254-1120100-137     [000] d..1.   266.629662: mtu3_log:
> 11201000.usb: ep0_state SETUPr-speed
> 
> "r-speed" seems the remain of last log;

I found an off-by-one bug in the vstring patch. I'll rebase, test and try
again.

In the mean time, care to add this on top to make sure it's fixed?

Thanks!

-- Steve

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index e6f8ba52a958..b18759a673c6 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -922,16 +922,16 @@ perf_trace_buf_submit(void *raw_data, int size, int rctx, u16 type,
  * gcc warns that you can not use a va_list in an inlined
  * function. But lets me make it into a macro :-/
  */
-#define __trace_event_vstr_len(fmt, va)		\
-({						\
-	va_list __ap;				\
-	int __ret;				\
-						\
-	va_copy(__ap, *(va));			\
-	__ret = vsnprintf(NULL, 0, fmt, __ap);	\
-	va_end(__ap);				\
-						\
-	min(__ret, TRACE_EVENT_STR_MAX);	\
+#define __trace_event_vstr_len(fmt, va)			\
+({							\
+	va_list __ap;					\
+	int __ret;					\
+							\
+	va_copy(__ap, *(va));				\
+	__ret = vsnprintf(NULL, 0, fmt, __ap) + 1;	\
+	va_end(__ap);					\
+							\
+	min(__ret, TRACE_EVENT_STR_MAX);		\
 })
 
 #endif /* _LINUX_TRACE_EVENT_H */
