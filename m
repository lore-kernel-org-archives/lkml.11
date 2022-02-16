Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C02C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Feb 2022 14:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234897AbiBPOPv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Feb 2022 09:15:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbiBPOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:15:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AA9C2604DB
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:15:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73B9106F;
        Wed, 16 Feb 2022 06:15:33 -0800 (PST)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EBB7D3F718;
        Wed, 16 Feb 2022 06:15:31 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:15:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, ardb@kernel.org,
        bp@alien8.de, broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mingo@redhat.com,
        ndesaulniers@google.com, peterz@infradead.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH v3 5/5] tools: update x86 string routines
Message-ID: <Yg0G/nr0D2KXHuwA@lakrids>
References: <20220211151445.2027553-1-mark.rutland@arm.com>
 <20220211151445.2027553-6-mark.rutland@arm.com>
 <20220216055952.ovrswb22lm53x5ns@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220216055952.ovrswb22lm53x5ns@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 09:59:52PM -0800, Josh Poimboeuf wrote:
> On Fri, Feb 11, 2022 at 03:14:45PM +0000, Mark Rutland wrote:
> > When building the perf tool the build system complains that the x86
> > string routines are out-of-date:
> > 
> > | Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
> > | diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
> > | Warning: Kernel ABI header at 'tools/arch/x86/lib/memset_64.S' differs from latest version at 'arch/x86/lib/memset_64.S'
> > | diff -u tools/arch/x86/lib/memset_64.S arch/x86/lib/memset_64.S
> > 
> > This is due to the way the asm-annotations for symbol aliasing were
> > reworked, which should have no functional/performance impact.
> > 
> > Import the latest versions, adding the new style SYM_FUNC_ALIAS(),
> > SYM_FUNC_ALIAS_LOAD(), SYM_FUNC_ALIAS_WEAK() macros into the perf
> > <linux/linkage.h> header. The old style SYM_FUNC_START_ALIAS() and
> > SYM_FUNC_END_ALIAS() macros are removed.
> > 
> > Other than removing the build-time warning, there should be no
> > functional change as a result of this patch.
> 
> These changes should probably be squashed with their corresponding
> original kernel changes to avoid breaking bisection for the warnings.
> And it helps to keep the interdependent changes together.

Sure; done for v4.

Doing that highlighted a couple of fixups I failed to make to the
tools/perf/ copy; I've fixed those up.

Thanks,
Mark.
