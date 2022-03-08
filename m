Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C7AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 21:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350377AbiCHVP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 16:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234717AbiCHVP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:15:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7025E43AD5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:15:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14438B81D86
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3955AC340EB;
        Tue,  8 Mar 2022 21:14:57 +0000 (UTC)
Date:   Tue, 8 Mar 2022 16:14:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <20220308161455.036e9933@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

A ChromeOS bug report showed a lockdep splat that I first thought was a bad
backport. But when looking at upstream, I don't see how it would work there
either. The lockdep splat had:

[56064.673346] Call Trace:
[56064.676066]  dump_stack+0xb9/0x117
[56064.679861]  ? print_usage_bug+0x2af/0x2c2
[56064.684434]  mark_lock_irq+0x25e/0x27d
[56064.688618]  mark_lock+0x11a/0x16c
[56064.692412]  mark_held_locks+0x57/0x87
[56064.696595]  ? _raw_spin_unlock_irq+0x2c/0x40
[56064.701460]  lockdep_hardirqs_on+0xb1/0x19d
[56064.706130]  _raw_spin_unlock_irq+0x2c/0x40
[56064.710799]  sched_core_balance+0x8a/0x4af
[56064.715369]  ? __balance_callback+0x1f/0x9a
[56064.720030]  __balance_callback+0x4f/0x9a
[56064.724506]  rt_mutex_setprio+0x43a/0x48b
[56064.728982]  task_blocks_on_rt_mutex+0x14d/0x1d5

Where I see:

task_blocks_on_rt_mutex() {
  spin_lock(pi_lock);
  rt_mutex_setprio() {
    balance_callback() {
      sched_core_balance() {
        spin_unlock_irq(rq);

Where spin_unlock_irq() enables interrupts while holding the pi_lock, and
BOOM, lockdep (rightfully) complains.

The above was me looking at mainline, not the kernel that blew up. So, I'm
guessing that this is a bug in mainline as well.

-- Steve
