Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F76EC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 18:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbiCBSkO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 13:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbiCBSkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:40:11 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Mar 2022 10:39:27 PST
Received: from smtp5.emailarray.com (smtp5.emailarray.com [65.39.216.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6F64198F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:39:27 -0800 (PST)
Received: (qmail 79736 invoked by uid 89); 2 Mar 2022 18:32:46 -0000
Received: from unknown (HELO localhost) (amxlbW9uQGZsdWdzdmFtcC5jb21AMTYzLjExNC4xMzIuNQ==) (POLARISLOCAL)  
  by smtp5.emailarray.com with SMTP; 2 Mar 2022 18:32:46 -0000
Date:   Wed, 2 Mar 2022 10:32:45 -0800
From:   Jonathan Lemon <jonathan.lemon@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: IRTE entry not present errors for serial driver
Message-ID: <20220302183245.xzxaf6zz2yxmnsbm@bsd-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm running into an issue with the ptp_ocp driver that I can use some
help with.

This driver is for a PCIe board which has an FPGA providing UARTs
for communication with onboard chips.  The design uses MSI interrupts.

When the driver is initially loaded, tracepoints show that the 
the interrupt vector is activated and allocated:

  kworker/0:2-2827    [000] ..... 76495.343455: vector_activate: irq=82 is_managed=0 can_reserve=1 reserve=0
  kworker/0:2-2827    [000] d..1. 76495.343456: vector_alloc: irq=82 vector=37 reserved=1 ret=0
  kworker/0:2-2827    [000] d..1. 76495.343456: vector_update: irq=82 vector=37 cpu=3 prev_vector=0 prev_cpu=0
  kworker/0:2-2827    [000] d..1. 76495.343457: vector_config: irq=82 vector=37 cpu=3 apicdest=0x00000006

Later, when the serial device is /first/ opened, there are no errors
and serial communication proceeds without a problem.  When the tty
is closed, the MSI interrupt entry is deactivated:

  tio-3209    [008] d..1. 76557.424960: vector_deactivate: irq=82 is_managed=0 can_reserve=0 reserve=0

On the second (and subsequent) opens, a DMAR fault is observed, which
seems to indicate that an IRQ from the serial port was taken before the 
IRTE vector was updated.

  [76561.103090] DMAR: DRHD: handling fault status reg 2
  [76561.105092] DMAR: [INTR-REMAP] Request device [65:00.0] fault index 0x25 [fault reason 0x22] Present field in the IRTE entry is clear

  tio-3211    [002] d..1. 76561.108431: vector_activate: irq=82 is_managed=0 can_reserve=0 reserve=0

    (serial port closed)
  tio-3211    [002] d..1.  76564.596150: vector_deactivate: irq=82 is_managed=0 can_reserve=0 reserve=0


Why is the vector being deactivated when the tty device is closed,
if it is left activated on module load?

This is on net-next (5.17.0-rc4+)
-- 
Jonathan
