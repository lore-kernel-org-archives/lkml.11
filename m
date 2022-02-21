Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB3C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 16:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379829AbiBUQEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 11:04:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbiBUQEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:04:10 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A8715A3E;
        Mon, 21 Feb 2022 08:03:47 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 15643210DC;
        Mon, 21 Feb 2022 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645459426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5FE3cwQ6zgpzMH3bNGS2ZplmWtxzZdsN1DYDBHL90ws=;
        b=eUDJ16xHS2VLLokLW4m+xZ7+oDU250PUgP0Df28Q2yiAcRPSfyy/YNTD4FW4oQZD5+h/ih
        30ZKHkI65hSCDPSMv/XqF9J+iSSB4x2qGgq8eIJU/O3nWafJct3H5xfUP7IZSovSqyWI5e
        qv0oZijzC3OZDlh8yNjro3FLIPsUj+M=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C819BA3B81;
        Mon, 21 Feb 2022 16:03:45 +0000 (UTC)
Date:   Mon, 21 Feb 2022 17:03:45 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, ojeda@kernel.org,
        alex.gaynor@gmail.com, wedsonaf@google.com,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] printk: make suppress_panic_printk static
Message-ID: <YhO34dtK6kBq+U+e@alley>
References: <20220216031957.9761-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216031957.9761-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-02-16 11:19:57, Jiapeng Chong wrote:
> This symbol is not used outside of printk.c, so marks it static.
> 
> Fix the following sparse warning:
> 
> kernel/printk/printk.c:100:19: warning: symbol 'suppress_panic_printk'
> was not declared. Should it be static?
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

The patch has been committed into printk/linux.git,
branch for-5.18-panic-deadlocks.

Best Regards,
Petr
