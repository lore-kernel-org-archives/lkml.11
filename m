Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB58C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 15:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347871AbiEZPLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 11:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbiEZPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 11:11:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47125237C6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 08:11:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D346B1688;
        Thu, 26 May 2022 08:11:00 -0700 (PDT)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.27.164])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80D493F66F;
        Thu, 26 May 2022 08:10:59 -0700 (PDT)
Date:   Thu, 26 May 2022 16:10:52 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        jpoimboe@redhat.com, linux-kernel@vger.kernel.org,
        elver@google.com, jbaron@akamai.com, rostedt@goodmis.org,
        ardb@kernel.org
Subject: Re: [PATCH 7/7] context_tracking: Always inline empty stubs
Message-ID: <Yo+YfEWLiCVekG5l@FVFF77S0Q05N.cambridge.arm.com>
References: <20220526105252.440440893@infradead.org>
 <20220526105958.134113388@infradead.org>
 <20220526150206.rqdiyouxmkdgm2jq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526150206.rqdiyouxmkdgm2jq@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 08:02:06AM -0700, Josh Poimboeuf wrote:
> On Thu, May 26, 2022 at 12:52:59PM +0200, Peter Zijlstra wrote:
> > Because GCC is seriously challenged..
> 
> Or are these CONFIG_DEBUG_SECTION_MISMATCH?

Does it matter?

The fact that CONFIG_DEBUG_SECTION_MISMATCH=y forces GCC to place these
out-of-line is really a debugging aid, since it shows us what it could
potentially leave out-of-line. It's not the *only* reason GCC might do this
(e.g. I see sanitizers and other debug options often have similar effects on
arm64).

So FWIW, for the patch:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

... as I'd like this for arm64, even if you don't beleive that's necessary for
x86.

Thanks,
Mark.
