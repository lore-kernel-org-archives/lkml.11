Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E12C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 17:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiBOR1O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 12:27:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbiBOR1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:27:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4855F140FD;
        Tue, 15 Feb 2022 09:26:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 72EF81F382;
        Tue, 15 Feb 2022 17:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644946018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yBgxgoZsveUgEspMXqC/qI2secN9IP8B/Gmo05h1B6E=;
        b=T0nTYJZBFfHUHaGMRTG3JqNCq7Ua6FsneNb/P+cU9EM+aXvzn0ihPCxLgu2v1VHitdCPvI
        B7Fyi2evWlQoZrZzY9fJJdrSodBDAxLakylLRcnuy2KD3961TFd/GC7LYniASf6cpcu8n8
        Phe9NngBxI9NJJHPE1Uiz9f6Ern+hk4=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EAA1BA3B81;
        Tue, 15 Feb 2022 17:26:57 +0000 (UTC)
Date:   Tue, 15 Feb 2022 18:26:57 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Docs: printk: add 'console=null|""' to
 admin/kernel-parameters
Message-ID: <YgviYXNc6zo2V+35@alley>
References: <20220215005615.11244-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215005615.11244-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-14 16:56:15, Randy Dunlap wrote:
> Tell about 'console=null|""' and how to use it.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: John Ogness <john.ogness@linutronix.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/admin-guide/kernel-parameters.txt |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> --- linux-next-20220214.orig/Documentation/admin-guide/kernel-parameters.txt
> +++ linux-next-20220214/Documentation/admin-guide/kernel-parameters.txt
> @@ -724,6 +724,12 @@
>  		hvc<n>	Use the hypervisor console device <n>. This is for
>  			both Xen and PowerPC hypervisors.
>  
> +		{ null | "" }
> +			Use to disable console output, i.e., to have kernel
> +			console messages discarded.
> +			This must be the first (or only) console= string
> +			used on the kernel command line.

It must be the only console= parameter on the command line. Otherwise,
the other consoles get enabled as well.

It might make sense to detect this situation and print a warning or
so. Nobody has sent a patch for this so far.

But there is even bigger problem. The default console is also used
as stdin/stdout/stderr for the init process. It might fail when there
is no console driver associated with it.

The problem with stdin/stdout/stderr does not happen when
CONFIG_NULL_TTY is enabled and ttynull driver is available.
Unfortunately, it can't be enabled by default because it can
be used by mistake, see the commit a91bd6223ecd46addc71e
("Revert "init/console: Use ttynull as a fallback when there
is no console").

And there is still a mystery that has not been explained yet,
see https://lore.kernel.org/r/a46e9a26-5b9f-f14c-26be-0b4d41fa7429@roeck-us.net

On the positive note. console=null mostly works. All the problems are
hard to reproduce.


Now, what to do with this patch. I would suggest two changes:

1. Replace "must be the first (or only)" with "must be the only"

2. Mention that it is suggested to enable CONFIG_NULL_TTY that
   will avoid problems with stdin/stdout/stderr of the init process.
   But it might cause the ttynull might be used even when a real
   console is configured. And that more details can be found
   in the commit a91bd6223ecd46addc71e ("Revert "init/console:
   Use ttynull as a fallback when there is no console").

   It might be enough to mention this in the commit message.

Best Regards,
Petr

