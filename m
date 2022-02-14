Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 15:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346105AbiBNPUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:20:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiBNPUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:20:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0192119C25
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:20:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FA90B81151
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 15:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855FCC340E9;
        Mon, 14 Feb 2022 15:20:01 +0000 (UTC)
Date:   Mon, 14 Feb 2022 10:20:00 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     chongjiapeng <jiapeng.chong@linux.alibaba.com>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: kernel/trace/ftrace.c:7157:20: error: unused function
 'ftrace_startup_enable'
Message-ID: <20220214102000.1d3af66e@gandalf.local.home>
In-Reply-To: <202202132037.4aN017dU-lkp@intel.com>
References: <202202132037.4aN017dU-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2022 21:03:29 +0800
kernel test robot <lkp@intel.com> wrote:

> All errors (new ones prefixed by >>):
> 
> >> kernel/trace/ftrace.c:7157:20: error: unused function 'ftrace_startup_enable' [-Werror,-Wunused-function]  
>    static inline void ftrace_startup_enable(int command) { }
>                       ^
>    1 error generated.

Strange. I always thought that static inline functions do not cause
warnings when not used? Especially, since they are often in headers when
things are turned off. Or is it because this is in a C file?

Is this a new warning caused by a commit, or is it a new warning because
the compiler now complains about it?

-- Steve


> 
> 
> vim +/ftrace_startup_enable +7157 kernel/trace/ftrace.c
