Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253BFC00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 14:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbiHAO0y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 10:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbiHAO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:26:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE60D1BE9C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:26:48 -0700 (PDT)
Date:   Mon, 1 Aug 2022 16:26:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659364007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXNbE+CrfQls7lAueunZZAuWwyqhIjnfIFJdeDpt5x8=;
        b=lKUwIlTipqFXwsuy7e7dGdA4aCX78a5cenHiQx5maS5yP9DoZwsciQg8z9zcm27pD1AOm1
        P2cgcGhUhxzyDPtklGxN5aNSDphfJVGwZ0VWIXuueEJnbZ7SqyUJ8jQwA5X8Um8Z9wSkMv
        qWGxMYZb+SGhuF3kjI2UZYat55dzdxhCpr67KBqCMa2pAliCZu3wYxeTWtU7TtWs5NCPzR
        6CQXVoSnlyDpiV3HGv7+7+jAgQZpYPSwIHEf8dGIl7X3d+sQxyoU23NBJ94OfFqIi3ApMn
        9QECqIxM3FIkbaXYWIlTH0PkErDgRgTvzAVZOh62bx7rODYLK/HP002SEHoslQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659364007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yXNbE+CrfQls7lAueunZZAuWwyqhIjnfIFJdeDpt5x8=;
        b=iM8hsZyo9pCKc6pHOx5yCgimXlS7qQnMRyEXOG56P7EL5lKRYhgTYJIhCa8DAONBNOVnvv
        8A+P+honpfGHhPAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mike Galbraith <efault@gmx.de>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5] lib/vsprintf: defer filling siphash key on RT
Message-ID: <YufiprsbKxO7r9F5@linutronix.de>
References: <CAHmME9qP2ZR6oQY3bf8W42RHW+-DamrzT=Gh1XJ3O7f72NU_bQ@mail.gmail.com>
 <20220801141245.124787-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220801141245.124787-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-01 16:12:45 [+0200], Jason A. Donenfeld wrote:
> Sebastian - again, feel free to take this and modify it as needed. Just
> posting ideas... -Jason

The plan is to make CONFIG_PROVE_RAW_LOCK_NESTING part of LOCKDEP once
the issues have been sorted out.

Sebastian
