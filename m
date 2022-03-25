Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE23C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 19:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbiCYT7n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiCYT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 15:59:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F74B2C1155
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 12:48:50 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648237699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6emZs1CfnbX39mIA+PHTwRbSSCV7fyUlvgeieLB7mgE=;
        b=aauP/id25Ij1DYcfQqQEpPx+Llzb8HJKO9CYtrSr77iBzrMUo2wNcl7Cgy3OKdwTJaiEIG
        R1gtkogQ9xtAOpj2tanlLICnZVQId2J7dT2/XLioARKvxgtxohmku/SnkzFNkAM8jnm7RZ
        VrGME9JkWCDU8kuNXfVZ9QemUuqyV0+xOEosxehIi1YN+WllpQ8llEYXdc635RRGLFWLnc
        y7NhkAY49E44RuKLt3pWWelIOD4YAC7AiGpmMUx2IlcA3KvH1+b3oTgcAhmseuQausQcMJ
        Ngyd8yFanNJuBup6bQ0RRu3o76/pgQkahLQtZ7F3DGqJyp70r47pWjZDF+nBxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648237699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6emZs1CfnbX39mIA+PHTwRbSSCV7fyUlvgeieLB7mgE=;
        b=RB3sQ3ZoWTLz7ZlDVfHE3wdXQyUzSmLzy95tXQ066YvsSSiahi23VD/PrWCmVbgHUWmHYj
        t/XuLHM9n1ha/3Cw==
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     geert+renesas@glider.be, linux-kernel@vger.kernel.org,
        yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] hrtimer: Remove a warning message in hrtimer_interrupt()
In-Reply-To: <20220224092848.3755-1-yamamoto.rei@jp.fujitsu.com>
References: <20211224023924.91851-1-yamamoto.rei@jp.fujitsu.com>
 <20220224092848.3755-1-yamamoto.rei@jp.fujitsu.com>
Date:   Fri, 25 Mar 2022 20:48:18 +0100
Message-ID: <87h77lhkzh.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24 2022 at 18:28, Rei Yamamoto wrote:
> It seems the warning message in hrtimer_interrupt() has
> no an intention.
> The required action for the warning message in hrtimer_interrupt() 
> is not clear.

The required action is to figure out why the hrtimer interrupt is
looping for a long time.

> Remove this message not to confuse user.

No. This message is interesting because as a consequence of an overly
long hrtimer interrupt the hrtimer interrupt will be deferred so tasks
can make progress. That means for the time of deferral there will be no
hrtimers fire, which is confusing if the message is removed because you
cannot figure out the reason.

Thanks,

        tglx

