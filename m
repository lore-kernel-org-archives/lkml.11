Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F696C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jun 2022 14:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358832AbiFVOvI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jun 2022 10:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358301AbiFVOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:50:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE823E0ED
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:50:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 289056194B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 14:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB600C34114;
        Wed, 22 Jun 2022 14:50:19 +0000 (UTC)
Date:   Wed, 22 Jun 2022 10:50:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        christophe.leroy@csgroup.eu, naveen.n.rao@linux.vnet.ibm.com,
        mbenes@suse.cz
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
Message-ID: <20220622105017.04630f12@rorschach.local.home>
In-Reply-To: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 13:24:53 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> Hi,
> 
> I recently noticed that __mcount_loc is 64bit wide, containing absolute
> addresses. Since __mcount_loc is a permanent section (not one we drop
> after boot), this bloats the kernel memory usage for no real purpose.

Wait, it's not dropped? Nothing uses it after it is read. It should be
dropped when init data is dropped.

From include/asm-generic/vmlinux.lds.h

/* init and exit section handling */
#define INIT_DATA                                                       \
        KEEP(*(SORT(___kentry+*)))                                      \
        *(.init.data init.data.*)                                       \
        MEM_DISCARD(init.data*)                                         \
        KERNEL_CTORS()                                                  \
        MCOUNT_REC()                                                    \  <<----
        *(.init.rodata .init.rodata.*)                                  \
        FTRACE_EVENTS()                                                 \
        TRACE_SYSCALLS()                                                \
        KPROBE_BLACKLIST()                                              \
        ERROR_INJECT_WHITELIST()                                        \
        MEM_DISCARD(init.rodata)                                        \


So it should be dropped after boot.

-- Steve

> 
> The below patch adds __mcount_loc_32 and objtool support to generate it.
> This saves, on an x86_64-defconfig + FTRACE, 23975*4 ~= 94K of permanent
> storage.
> 
> XXX hobbled sorttable for now
> XXX compile tested only
> 
