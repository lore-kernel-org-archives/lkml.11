Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16773C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 09:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiBYJmi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 04:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiBYJmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:42:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA153179245
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:42:04 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645782123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efX+H2rgkzwdZvYPaOM+FuXl2oq5kYZSxp45UAThfkM=;
        b=rFXxlalUEXoNGQQ47Gzqv6aS2/mrkGo/t1PnZWVywj7Vog7x0dZCYRJg8dcbIfDvol5F9M
        qjWIkPIrE7BgEgCvgVIZrNgVHXGGn/7eUyi0fn11qJux30RDrq1s18YEzmRDbPAYriYIYk
        0JP6G5VYN5QCnaxtUHpyi2284YnNIYDF2bLwpX4y6e415uvLPgAx1mMQ5XQKwpea9+9SrK
        4FF5+JbgYP4AvxjbsvQ5w917yZ5KMDdYUkH63MUQ0wsZ62HsWlJdsnBYFBy5tgMfYKvmNe
        OzMr9V5QAiDiYQM48CS1OQNiIKk8jDrgwV7nl7gt6qhJsW5UssS3FJV071tJxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645782123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=efX+H2rgkzwdZvYPaOM+FuXl2oq5kYZSxp45UAThfkM=;
        b=+XZqOiLppzmIaM/mPWLw/QAWci06dk9LAhgv6ilnpiMDHV1hPz6RjuyeOHorjQmac5Rtvc
        O2L7kluAqyhB0IAg==
To:     Willy Tarreau <w@1wt.eu>, David Laight <David.Laight@ACULAB.COM>
Cc:     'Steven Rostedt' <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: Strange output on the console
In-Reply-To: <878rtzwal7.fsf@jogness.linutronix.de>
References: <20220224230035.36547137@gandalf.local.home>
 <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
 <20220225063637.GA18039@1wt.eu> <878rtzwal7.fsf@jogness.linutronix.de>
Date:   Fri, 25 Feb 2022 10:48:02 +0106
Message-ID: <875yp3wadx.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-25, John Ogness <john.ogness@linutronix.de> wrote:
> Your first message says you attached a dmesg. Does this mean you dumped
> the kernel log directly into the attached file? ...or was that a screen
> capture in the attached file?

Sorry, I just noticed the userspace output at the end, clearly showing
it is a capture of the console output.

John
