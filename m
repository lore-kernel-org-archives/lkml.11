Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE1EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 09:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbiBYJiS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:38:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234665AbiBYJiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:38:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E92A622BD64
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:37:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645781861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7clqAVqcVNCOSSAPXmaeOBIZw4MCC68xC/iDFtYSF8=;
        b=m4Vfck2Wgjt8EMvdJksQ26y6sCVsRW95f/IMtkzxahJ6CYgrZOu4mJ1KXI0/imJH6rOGa3
        NdLRFfIENwRLeA0sDhrou6KbISZilWPAuY2Cac+Y1+FJHV7pFNIOJ4V/dTYaDLTdaXJAQE
        FzIyBT+T44Lx0D/894uYdgnErPDltLuc/24tOqdHbku1w25Bx5y7HTCzlk7ncPTfTon8L/
        dv/WglaDym9FZqmNM0+9SRsaIc1/7VIX37Ve6YAkyrmOqFZNgr8ZRkdCsdwjpmhy8vyWvH
        pJbM1U6gJl6ueYhEOpXALgqPntx49uDgjnox7dY6hxLohqYRzIJfHeYIOhF1lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645781861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X7clqAVqcVNCOSSAPXmaeOBIZw4MCC68xC/iDFtYSF8=;
        b=7g68RAB/qCu3aGEhiCQWzWKIqHRYM0w8Te6KAReINx+ZnuDeO6ANEqqyxVQ/Ld1rK+GUbG
        VHzVSCi+78NzQ6Dw==
To:     Willy Tarreau <w@1wt.eu>, David Laight <David.Laight@ACULAB.COM>
Cc:     'Steven Rostedt' <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: Strange output on the console
In-Reply-To: <20220225063637.GA18039@1wt.eu>
References: <20220224230035.36547137@gandalf.local.home>
 <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
 <20220225063637.GA18039@1wt.eu>
Date:   Fri, 25 Feb 2022 10:43:40 +0106
Message-ID: <878rtzwal7.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2022-02-25, Willy Tarreau <w@1wt.eu> wrote:
>> > And it always seems to happen right after:
>> > 
>> >   Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
>> > 
>> > Maybe this is a serial issue and not a printk one? :-/

Your first message says you attached a dmesg. Does this mean you dumped
the kernel log directly into the attached file? ...or was that a screen
capture in the attached file?

It is an important distinction because if garbage is landing in the
kernel buffer, it is not related to serial at all.

John
