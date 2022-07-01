Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C247FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 16:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiGAQOA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiGAQN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:13:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D547393E8
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:13:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EABB6251A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12CAAC341C8;
        Fri,  1 Jul 2022 16:13:54 +0000 (UTC)
Date:   Fri, 1 Jul 2022 12:13:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [BUG] str not used in cdns3 trace events
Message-ID: <20220701121353.17a0b1ae@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm doing updates to add __vstring (dynamically created strings in trace
events) and came across the trace events in:

  drivers/usb/cdns3/trace.h

Where there is several cases of this:

+DECLARE_EVENT_CLASS(cdns3_log_usb_irq,
+       TP_PROTO(struct cdns3_device *priv_dev, u32 usb_ists),
+       TP_ARGS(priv_dev, usb_ists),
+       TP_STRUCT__entry(
+               __field(enum usb_device_speed, speed)
+               __field(u32, usb_ists)
+               __dynamic_array(char, str, CDNS3_MSG_MAX)
+       ),
+       TP_fast_assign(
+               __entry->speed = cdns3_get_speed(priv_dev);
+               __entry->usb_ists = usb_ists;
+       ),
+       TP_printk("%s", cdns3_decode_usb_irq(__get_str(str), __entry->speed,
+                                            __entry->usb_ists))
+);

I see you create a dynamic array for "str" and even reference it in the
print with __get_str(str). But it is never assigned in TP_fast_assign().

This looks to be a bug to me. Can you explain this please?

-- Steve
