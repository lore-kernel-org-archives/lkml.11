Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A0CC433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Apr 2022 19:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241764AbiDJTmn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Apr 2022 15:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbiDJTmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 15:42:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DF846B01
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:40:27 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649619625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FF23cSZ1l3Y5yPotVlxMxAKU+a4XmyD6dOumhinfpP4=;
        b=idd97FJ9/26MIUh5k3HejD2ofr204yiAixCK4spN/qliyMrOa6rGE62+4KS6AeNDWjWyxx
        k6YDCQ12aTM01SMMOdxNo2x18c+Ls/r3ESbucvJR2znC+OF0/yAzvddxgJuhWgPKFFIxiD
        NBF14DLSCs1r9YAOWHnhyVNnZy3UKjBWqAsd+r2jBvJ+JQFUiDcOZqIVrAJnl1t4IsxZi8
        8JrDGBhhDyt3zWn8B6WAKnq4zesXO17nafwjMk/v4A+ZfCWuenCVhEoOdWtcNWiZbHY4nm
        MMLlsVztvRvZsKG7dhTQbRKHrzQ2xI4+upZiTaf++ROuVcZBtqj1XEIbzveLNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649619625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FF23cSZ1l3Y5yPotVlxMxAKU+a4XmyD6dOumhinfpP4=;
        b=8y1kmnj6ZiKZCLeRkGK8BKGrhxnktGpECq6XCPfHqYwBMflRJANvDz2bj8uChbHsJTZwiV
        QertNFdJdM2IJhBQ==
To:     Chen Lifu <chenlifu@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] irq: print depth in __enable_irq WARNING
In-Reply-To: <20220325013359.2691092-1-chenlifu@huawei.com>
References: <20220325013359.2691092-1-chenlifu@huawei.com>
Date:   Sun, 10 Apr 2022 21:40:24 +0200
Message-ID: <87czhohglz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chen!

On Fri, Mar 25 2022 at 09:33, Chen Lifu wrote:

The subsystem prefix for the interrupt core is 'genirq' as you can easy
check via 'git log kernel/irq/manage.c'

> Since case 0 and 1 of desc->depth may print same warning messages as follows,
> according to the messages, we do not know in which case the warning is generated.
> This patch prints extra desc->depth in the warning messages to distinguish
> these cases.

This patch prints? The patch cannot print anything.

Please read the patch submission notes in Documentation/process/
including the tip tree specific rules in Documentation/process/maintainer-tip.html

>  void __enable_irq(struct irq_desc *desc)
>  {
>  	switch (desc->depth) {
>  	case 0:
>   err_out:
> -		WARN(1, KERN_WARNING "Unbalanced enable for IRQ %d\n",
> -		     irq_desc_get_irq(desc));
> +		WARN(1, KERN_WARNING "depth %u: Unbalanced enable for IRQ %d\n",
> +		     desc->depth, irq_desc_get_irq(desc));

If we change this then we really want separate messages which makes it
clear what this is about. Something like:

        if (likely(depth == 1)) {
        	if (WARN_ONCE(suspended, "Enable of suspended irq %d", irq))
                	return;
                ....
                return;
        }

        if (WARN_ONCE(!depth, "Unbalanced enable of irq %d", irq))
        	return;

	desc->depth--;

Hmm?

Thanks,

        tglx
