Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2E6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbiDFQz7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238454AbiDFQzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:55:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357DC3408B3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 07:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A7E4ACE20CB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:19:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E379C385A3;
        Wed,  6 Apr 2022 14:19:44 +0000 (UTC)
Date:   Wed, 6 Apr 2022 10:19:42 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, mbenes@suse.cz, x86@kernel.org
Subject: Re: drivers/gpu/drm/i915/i915.prelink.o: warning: objtool:
 __intel_wait_for_register_fw.cold()+0xce: relocation to !ENDBR:
 vlv_allow_gt_wake.cold+0x0
Message-ID: <20220406101942.7abaf7dc@gandalf.local.home>
In-Reply-To: <20220406072913.GC34954@worktop.programming.kicks-ass.net>
References: <202204041241.Hw855BWm-lkp@intel.com>
        <YkxLqznOz0ldTz5a@hirez.programming.kicks-ass.net>
        <20220406000500.5hlaqy5zrdqsg5mg@treble>
        <87czhv11k1.ffs@tglx>
        <20220406053251.6dyfxrjmmgdwocfc@treble>
        <20220406072913.GC34954@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 09:29:13 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Best would be for Steve to send a patch removing them all:
> 
> 
> arch/powerpc/kvm/book3s_xics.c:#define XICS_DBG(fmt...) trace_printk(fmt)
> drivers/gpu/drm/i915/gt/intel_gtt.h:#define DBG(...) trace_printk(__VA_ARGS__)
> drivers/gpu/drm/i915/i915_gem.h:#define GEM_TRACE(...) trace_printk(__VA_ARGS__)
> drivers/gpu/drm/i915/i915_gem.h:        trace_printk(__VA_ARGS__);                                      \
> drivers/hwtracing/stm/dummy_stm.c:      trace_printk("[%u:%u] [pkt: %x/%x] (%llx)\n", master, channel,
> drivers/infiniband/hw/hfi1/trace_dbg.h: trace_printk(fmt, ##__VA_ARGS__)
> drivers/tty/n_tty.c:# define n_tty_trace(f, args...)    trace_printk(f, ##args)
> drivers/usb/early/xhci-dbc.c:#define    xdbc_trace      trace_printk
> fs/ext4/inline.c:       trace_printk("inode %lu\n", dir->i_ino);
> fs/ext4/inline.c:               trace_printk("de: off %u rlen %u name %.*s nlen %u ino %u\n",
> 
> 
> All except i915 use CPP tokens that don't exist, local developer really
> has to take effort to enable it. i915 crud depends on a CONFIG_ symbols
> that all{yes,mod}config will happily set for you,

As I replied to Josh, when trace_printk() is used, you get nasty dmesg
reports, and those do show up in bug reports to vendors (I laugh every time
I see them.)

I'm not too worried if trace_printk() is called for debugging, and even
with CONFIG_ options.

I even have trace_printk() used for things like my ring_buffer benchmark
(which should never be run on production!)

Thus, if the code that has trace_printk() is truly for debugging, and not
something that would normally get applied in other people's trees, then
that actually falls into its use case.

-- Steve
