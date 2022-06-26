Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E572FC433EF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jun 2022 09:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiFZJVm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jun 2022 05:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234151AbiFZJVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 05:21:40 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9789311177
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 02:21:39 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8F9402B;
        Sun, 26 Jun 2022 02:21:39 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.71.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43DBD3F792;
        Sun, 26 Jun 2022 02:21:37 -0700 (PDT)
Date:   Sun, 26 Jun 2022 10:21:33 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     andrey.konovalov@linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        kernel-team@android.com, Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] arm64: kasan: do not instrument stacktrace.c
Message-ID: <YrglHeC9NPKsC2/7@FVFF77S0Q05N>
References: <c4c944a2a905e949760fbeb29258185087171708.1653317461.git.andreyknvl@google.com>
 <165599625020.2988777.9370908523559678089.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165599625020.2988777.9370908523559678089.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 08:31:32PM +0100, Will Deacon wrote:
> On Mon, 23 May 2022 16:51:51 +0200, andrey.konovalov@linux.dev wrote:
> > From: Andrey Konovalov <andreyknvl@google.com>
> > 
> > Disable KASAN instrumentation of arch/arm64/kernel/stacktrace.c.
> > 
> > This speeds up Generic KASAN by 5-20%.
> > 
> > As a side-effect, KASAN is now unable to detect bugs in the stack trace
> > collection code. This is taken as an acceptable downside.
> > 
> > [...]
> 
> Applied to arm64 (for-next/stacktrace), thanks! I had to fix conflicts
> in both of the patches, so please can you take a quick look at the result?
> 
> [1/2] arm64: kasan: do not instrument stacktrace.c
>       https://git.kernel.org/arm64/c/802b91118d11
> [2/2] arm64: stacktrace: use non-atomic __set_bit
>       https://git.kernel.org/arm64/c/446297b28a21

I take it that was just the s/frame/state/ conflict?

FWIW, that looks good to me; thanks for sorting that out!

Mark.
