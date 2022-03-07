Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CB5C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 10:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbiCGKqA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 05:46:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241339AbiCGKpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:45:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E419D049
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:06:38 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646647576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RN44zCuRIGGGqebOlHfgM9DE8lcIKyN/M1OeVoWELUE=;
        b=i9d0481y4Wj7ZziKnEomUNmqIQAEX8QWUb5BqEABcv6aEku9vfUrva+NZWkt9SibTY4yD9
        rpHVUw58paY57ZwxIyapIbjCZA5trP7E2/0RZNTvDp57ep4VkIUwn2mWEV+JI1uRm8FUbB
        /z5cJPFOJYjc3Kc+I0WBRGD6850ttJ/kF4O/KhzPPI7kq7Pm3tm8TvgU88m8p1m8F1YDss
        UkaodPlxNyYSl5CaOknZk0haNEcl8hai+aTQ5iH6YrSB5WG0Wq7kSX2+j+RYMnhOKaT9g7
        dswaUyE6jCT0Dn2UD/Zr1flkdIJeoDKwv55qKMLVlpSjHq3+eTRDzgpxP6oJfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646647576;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RN44zCuRIGGGqebOlHfgM9DE8lcIKyN/M1OeVoWELUE=;
        b=tjrNF07sAzgJSVE+j9VIw3x0FpFj+rGAS1Nac0btbU11P+mOFg6Z9Wej8SKx1/sHtI3XBH
        9UlNls3FOMq8k/Dw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: two locations: was: Re: [PATCH printk v1 03/13] printk: use
 percpu flag instead of cpu_online()
In-Reply-To: <YiI61ppIW+FsrzPu@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <Yg0C+UtoegnybA4q@alley> <87v8wwh0jw.fsf@jogness.linutronix.de>
 <YiI61ppIW+FsrzPu@alley>
Date:   Mon, 07 Mar 2022 11:12:15 +0106
Message-ID: <87mti22i20.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-04, Petr Mladek <pmladek@suse.com> wrote:
>> If the context is preemptible, I do not think it will ever see
>> !cpu_online(). So I think if the cpu_online() check is limited to
>> unlocking when console_trylock() was used, it will be correct.
>
> This would require calling console_lock()/console_unlock()
> in a hotplug code when cpu_online() already returns false.
> Do I get it correctly?

Yes, but there is also the other side: Are there preemptible code paths
that are calling console_trylock()? And if yes, then why are they not
using console_lock()?

There is only a handfull of console_trylock() users (about 10
sites). Most of them appear to be differentiating from preemptible and
non-preemptible contexts. I will investigate them in detail.

If the raw_smp_processor_id() is changed to smp_processor_id() within
the console_trylock()/console_unlock() call path, then at least the
kernel's lock debugging would identify if there are preemptible contexts
that are using console_trylock().

John
