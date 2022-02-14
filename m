Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32222C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiBNTCe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 14:02:34 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiBNTCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:02:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7843A8888
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:01:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A14CFB8164B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDD6DC340E9;
        Mon, 14 Feb 2022 18:57:40 +0000 (UTC)
Date:   Mon, 14 Feb 2022 13:57:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/ftrace.c:7157:20: error: unused function
 'ftrace_startup_enable'
Message-ID: <20220214135739.60b2149e@gandalf.local.home>
In-Reply-To: <Ygp64CsyyKyRykqE@dev-arch.archlinux-ax161>
References: <202202132037.4aN017dU-lkp@intel.com>
        <20220214102000.1d3af66e@gandalf.local.home>
        <Ygp64CsyyKyRykqE@dev-arch.archlinux-ax161>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 08:53:04 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> I will be honest, I don't know why the robot flagged 172f7ba9772c as the
> commit that introduced this warning but it seems legitimate if
> CONFIG_DYNAMIC_FTRACE is not enabled, since ftrace_startup_enable() is
> only ever used within an '#ifdef CONFIG_DYNAMIC_FTRACE' block so I guess
> the stub is unnecessary?

I'm all fine for clean up patches, but I don't like "new warning" message
reports for things that use to be OK, but now are a warning.

In other words, if a bot updates its warnings, it should do a full pass of
the kernel before it starts on new commits, to flag all existing warnings
as OK (but possibly work for someone to clean up), but should not ever send
as a new warning message to the authors.

So, I'm going to ignore this. If someone wants to send me a clean up patch,
I'll test it and take it, but I do not have the time to clean up new
warnings that use to be OK unless they uncovered a real bug.

-- Steve
