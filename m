Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E1AEC46467
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348339AbiDNOwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344857AbiDNNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:44:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F1CBF38BCD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:40:26 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E8F9139F;
        Thu, 14 Apr 2022 06:40:26 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CA933F70D;
        Thu, 14 Apr 2022 06:40:24 -0700 (PDT)
Date:   Thu, 14 Apr 2022 14:40:21 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v3 0/3] kasan, arm64, scs: collect stack traces from
 Shadow Call Stack
Message-ID: <YlgkRXkCLeQ5IcaD@lakrids>
References: <cover.1649877511.git.andreyknvl@google.com>
 <YlgVa+AP0g4IYvzN@lakrids>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlgVa+AP0g4IYvzN@lakrids>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:36:59PM +0100, Mark Rutland wrote:
> As I suspected, you're hitting a known performance oddity with QEMU TCG
> mode where pointer authentication is *incredibly* slow when using the
> architected QARMA5 algorithm (enabled by default with `-cpu max`).

> This overhead has nothing to do with the *nature* of the unwinder, and
> is an artifact of the *platform* and the *structure* of the code.
> There's plenty that can be done to avoid that overhead

FWIW, from a quick look, disabling KASAN instrumentation for the
stacktrace object alone (with no other changes) has a significant impact
(compounded by the TCG QARMA5 slowdown), and I note that x86 doesn't
both instrumenting its stacktrace code anyway, so we could consider
doing likewise.

Atop that, replacing set_bit() with __set_bit() brings the regular
unwinder *really* close to the earlier SCS unwinder figures. I know that
the on_accessible_stack() calculations and checks could be ammortized
with some refactoring (which I'd planned to do anyway), so I think it's
plausible that with some changes to the existing unwinder we can bring
the difference into the noise.

> generic kasan w/ `-cpu max`
> ---------------------------
> 
> master-no-stack-traces: 12.66
> master:                 18.39 (+45.2%)
> master-no-stack-depot:  17.85 (+40.1%)
> up-scs-stacks-v3:       13.54 (+7.0%)

master-noasan:            15.67 (+23.8%)
master-noasan-__set_bit:  14.61 (+15.5%)

> Generic KASAN w/ `-cpu max,pauth-impdef=true`
> ---------------------------------------------
> 
> master-no-stack-traces: 2.69
> master:                 3.35 (+24.5%)
> master-no-stack-depot:  3.54 (+31.5%)
> up-scs-stacks-v3:       2.80 (+4.1%)

master-noasan:            3.05 (+13.0%)
master-noasan-__set_bit:  2.96 (+10.0%)

> Generic KASAN w/ `-cpu max,pauth=false`
> ---------------------------------------
> 
> master-no-stack-traces: 1.92
> master:                 2.27  (+18.2%)
> master-no-stack-depot:  2.22  (+15.6%)
> up-scs-stacks-v3:       2.06  (+7.3%)

master-noasan:             2.14 (+11.4%)
master-noasan-__set_bit:   2.10 (+9.4%)

Thanks,
Mark.
