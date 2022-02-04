Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA5B9C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 21:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244486AbiBDVvu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbiBDVvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:51:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539ACC06173D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=DCfiIrrbnNqVJAuNcAgp3lkn6Twl2T1tBjE7PiLkNDM=; b=k8rkM+BzK9cutbxg1irUxHqTf2
        u+CSePpeWqqKKU0UbuSPrT/64d0SUfPP7NnZSA0Uk2E8QH/lJ6hUOKJXpHlvI+NuSZuEuP0csjcL0
        nP6SICyAu/BYuiWuuUhXNf0F/UHp2bP0M4bJVFGIhhVKH0h5W/Nfhz2daFcvJARuo0FUpdyVWmhS3
        jst0fESDpGDawuoT2VLiBQfBzE0Zg7+JIRszJGTOiCI6AcSs2tIWGgd8O+ek8cPVD0/dymiCGVT/W
        b60VGw7kXa8PrtEcXOqSwe8NZ6HayMD9SBtGkdX8N3H2Y7PdGDqehrwvHg1f+zR0Nci7dySDXrMJx
        3GGdvcEQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nG6UQ-005UoC-7O; Fri, 04 Feb 2022 21:51:34 +0000
Date:   Fri, 4 Feb 2022 13:51:34 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v1] printk: Fix incorrect __user type in
 proc_dointvec_minmax_sysadmin()
Message-ID: <Yf2f5lh9JEremKKr@bombadil.infradead.org>
References: <20220203145029.272640-1-mic@digikod.net>
 <YfyZAy+ZDZ4SXIFE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfyZAy+ZDZ4SXIFE@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 12:09:55PM +0900, Sergey Senozhatsky wrote:
> On (22/02/03 15:50), Mickaël Salaün wrote:
> > The move of proc_dointvec_minmax_sysadmin() from kernel/sysctl.c to
> > kernel/printk/sysctl.c introduced an incorrect __user attribute to the
> > buffer argument.  I spotted this change in [1] as well as the kernel
> > test robot.  Revert this change to please sparse:
> > 
> > kernel/printk/sysctl.c:20:51: warning: incorrect type in argument 3 (different address spaces)
> > kernel/printk/sysctl.c:20:51:    expected void *
> > kernel/printk/sysctl.c:20:51:    got void [noderef] __user *buffer
> > 
> > Fixes: faaa357a55e0 ("printk: move printk sysctl to printk/sysctl.c")
> > Link: https://lore.kernel.org/r/20220104155024.48023-2-mic@digikod.net [1]
> > Reported-by: kernel test robot <lkp@intel.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: John Ogness <john.ogness@linutronix.de>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Xiaoming Ni <nixiaoming@huawei.com>
> > Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
> > Link: https://lore.kernel.org/r/20220203145029.272640-1-mic@digikod.net
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
