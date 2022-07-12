Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BC0C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 22:58:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbiGLW60 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGLW6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 18:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439E5A439F;
        Tue, 12 Jul 2022 15:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D11BB61734;
        Tue, 12 Jul 2022 22:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B07C3411C;
        Tue, 12 Jul 2022 22:58:22 +0000 (UTC)
Date:   Tue, 12 Jul 2022 18:58:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: [PATCH v2] tracing: devlink: Use static array for string in
 devlink_trap_report even
Message-ID: <20220712185820.002d9fb5@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The trace event devlink_trap_report uses the __dynamic_array() macro to
determine the size of the input_dev_name field. This is because it needs
to test the dev field for NULL, and will use "NULL" if it is. But it also
has the size of the dynamic array as a fixed IFNAMSIZ bytes. This defeats
the purpose of the dynamic array, as this will reserve that amount of
bytes on the ring buffer, and to make matters worse, it will even save
that size in the event as the event expects it to be dynamic (for which it
is not).

Since IFNAMSIZ is just 16 bytes, just make it a static array and this will
remove the meta data from the event that records the size.

Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Changes since v1: https://lkml.kernel.org/r/20220703111809.40cd1c3f@rorschach.local.home

   - The old version tried to do the same logic in the __dynamic_array() to
     calculate the size of the string, but actually failed to by not using
     the correct variable. Just use __array() instead, as IFNAMSIZ is just
     16 bytes anyway.

   - Cc'd more maintainers by running get_maintainers.pl from the call of
     the tracepoint and not just the include/trace/events file.

 include/trace/events/devlink.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/devlink.h b/include/trace/events/devlink.h
index 2814f188d98c..24969184c534 100644
--- a/include/trace/events/devlink.h
+++ b/include/trace/events/devlink.h
@@ -186,7 +186,7 @@ TRACE_EVENT(devlink_trap_report,
 		__string(driver_name, devlink_to_dev(devlink)->driver->name)
 		__string(trap_name, metadata->trap_name)
 		__string(trap_group_name, metadata->trap_group_name)
-		__dynamic_array(char, input_dev_name, IFNAMSIZ)
+		__array(char, input_dev_name, IFNAMSIZ)
 	),
 
 	TP_fast_assign(
@@ -197,15 +197,14 @@ TRACE_EVENT(devlink_trap_report,
 		__assign_str(driver_name, devlink_to_dev(devlink)->driver->name);
 		__assign_str(trap_name, metadata->trap_name);
 		__assign_str(trap_group_name, metadata->trap_group_name);
-		__assign_str(input_dev_name,
-			     (input_dev ? input_dev->name : "NULL"));
+		strscpy(__entry->input_dev_name, input_dev ? input_dev->name : "NULL", IFNAMSIZ);
 	),
 
 	TP_printk("bus_name=%s dev_name=%s driver_name=%s trap_name=%s "
 		  "trap_group_name=%s input_dev_name=%s", __get_str(bus_name),
 		  __get_str(dev_name), __get_str(driver_name),
 		  __get_str(trap_name), __get_str(trap_group_name),
-		  __get_str(input_dev_name))
+		  __entry->input_dev_name)
 );
 
 #endif /* _TRACE_DEVLINK_H */
-- 
2.35.1

