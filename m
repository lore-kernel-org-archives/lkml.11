Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65170C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 22:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiCUWxe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 18:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiCUWxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 18:53:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8120883B0E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:32:34 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647898632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UX/7v0u3KE8MJrBCQwgWLG7WTu14xXAYSO+Yxy+PVNM=;
        b=2vZy37bcZvuZno8ZxMqP9y7WHaxto1i2NppHCVOFkB14YTnPd0DTHVlwbTUjNAInX588Jc
        soX1jHs+THzZOyL4OusdWJoyDNlsymJf8BDgi8NbAL8KIOmiVc37x4ZNFN9cvrBuxzWiFI
        cnZLlbiMSRFgsENYkLEFq7mROFOTyb78d/GswM3JSc4qBa1h/gH56GndkMnYvMDRAw17fO
        m+qRbotXI9fGWMvAH1i2huAh9ALdzvjS6QwrD8Lx4j1FHNBC1pZJi2ny2HRtL6ZMzPDT+G
        36u5vK1ZVNM9dHeeNeDE/4NtMLGYZH+eloR7SlTGb+gXbb+E3VmKaop+vcrkww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647898632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UX/7v0u3KE8MJrBCQwgWLG7WTu14xXAYSO+Yxy+PVNM=;
        b=i9d0cJwIHMIusT0plTcxsKiijSaTt8k+k85oKM18jOwm6mnkI9rDXnhQ2L9Jkm4Wtm6ous
        mo7NQvKcjut9MiDg==
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] x86/irq for v5.18-rc1
In-Reply-To: <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
References: <164786042536.122591.4459156564791679956.tglx@xen13>
 <164786043041.122591.4693682080153649212.tglx@xen13>
 <CAHk-=wg_Kyh4zVmBSc4H79jH+yv9wN7dMsf-5x=EDrORbL3fuQ@mail.gmail.com>
Date:   Mon, 21 Mar 2022 22:37:12 +0100
Message-ID: <87lex3asxj.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21 2022 at 12:17, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 4:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> I pulled this and then I unpulled it.
>
> Because that stupid IRT routing table code already been reported to cause bugs:
>
>     https://lore.kernel.org/all/a2791312-2957-27e6-43af-c805bbb90266@collabora.com/

I've missed that. My bad...

Thanks,

        tglx
