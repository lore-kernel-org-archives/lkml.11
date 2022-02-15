Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE48C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 15:03:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiBOPDO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:03:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238916AbiBOPDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:03:12 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75B21EAED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:03:02 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 786BB1F37B;
        Tue, 15 Feb 2022 15:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644937381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0gbq+obhVRP6OP+JltZuW9ENrPmrcdyhOP5tK9eyo/k=;
        b=WaWRdhWEUmCU8v6DEVlJDCb5Yf36kXQWWkbxY41sYJ8yYTIc5oEzmMBqr1I7eXi7mf9RzF
        D7gOAJmGzNuAPb/sk55G/zP/ZWJ8yhKoy0r2Our+pLo4z0g6h7BFKNeR/KdN/BE5nrFCdq
        SvZ5DnjFrvY91Rg5n4HCtqf8vu8IiDE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5D857A3B8E;
        Tue, 15 Feb 2022 15:03:01 +0000 (UTC)
Date:   Tue, 15 Feb 2022 16:03:00 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 05/13] printk: call boot_delay_msec() in
 printk_delay()
Message-ID: <YgvApMQ9LyNd4dsF@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-6-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:15, John Ogness wrote:
> boot_delay_msec() is always called immediately before printk_delay()
> so just call it from within printk_delay().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
