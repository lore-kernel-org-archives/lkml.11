Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605A8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 11:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357096AbiCYLnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345320AbiCYLni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:43:38 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08204D110E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648208524; x=1679744524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fAuPCIxYwYRiStXmYr6H/J9NL4UCaX3dtU3zNedcnKI=;
  b=Erzl4m6+f91Ui2ATexocVAEE0LgAGxS8CznErYVSNDyK/RasHZis38nC
   KLKDtwqlx99DtFYRriTNYJyEk6OrjDx0DOqMGJQCA8gyn6TVhjHm+FqWu
   4uhxp8Up7sY3Gdr7D7UkGjB34xvtXCsymXLd/1sWqoxX+at59mDnvjB8l
   Kv+yNW+gly6eKQBYiixTRa3YUe6Zu3MnBjcgwVkvIXhRw4WpTxTd4XFEw
   axUAPK41oDN8gMirG1ervlMCG1d+75lBuZ07zN/hVvsWYXgskJj6OdaOR
   nreqj7rStkH7+R8DPeKkzZdRossvBUOaeqUCU31k/5Aj4qtHL6sYcrVlf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="258809513"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="258809513"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:42:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="638194590"
Received: from smile.fi.intel.com ([10.237.72.59])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:42:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1nXiJp-006MIY-Uz;
        Fri, 25 Mar 2022 13:41:25 +0200
Date:   Fri, 25 Mar 2022 13:41:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <Yj2qZT6gdRYpkSIR@smile.fi.intel.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic>
 <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 03:58:47PM -0700, Linus Torvalds wrote:
> On Tue, Mar 22, 2022 at 3:20 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > Ah, you say build error because you have CONFIG_WERROR=y.
> 
> EVERYBODY should have CONFIG_WERROR=y on at least x86-64 and other
> serious architectures, unless you have some completely random
> experimental (and broken) compiler.
> 
> New compiler warnings are not acceptable.

What about old one? I have already complained in the early discussion that
`make W=1 ...` is broken by this change. Enabling it without fixing
_existing_ warnings on W=1 is not suitable for somebody. Now, I have to
modify my configs to disable WERROR because of inability to built at all.

(Yes, I understand that I may drop W=1, but that's not the point. since I
 want to have clean builds of a new code on level 1 of warnings)

-- 
With Best Regards,
Andy Shevchenko


