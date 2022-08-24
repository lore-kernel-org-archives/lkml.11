Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E6CC00140
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Aug 2022 17:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240205AbiHXRc6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Aug 2022 13:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240198AbiHXRcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:32:55 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95D8D7E005;
        Wed, 24 Aug 2022 10:32:54 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27OHTUfQ030081;
        Wed, 24 Aug 2022 12:29:30 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 27OHTUCL030078;
        Wed, 24 Aug 2022 12:29:30 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 24 Aug 2022 12:29:29 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Michael Matz <matz@suse.de>,
        linux-toolchains@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sev: Mark snp_abort() noreturn
Message-ID: <20220824172929.GA25951@gate.crashing.org>
References: <20220824152420.20547-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824152420.20547-1-bp@alien8.de>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, Aug 24, 2022 at 05:24:20PM +0200, Borislav Petkov wrote:
> Mark both the function prototype and definition as noreturn in order to
> prevent the compiler from doing transformations which confuse objtool
> like so:
> 
>   vmlinux.o: warning: objtool: sme_enable+0x71: unreachable instruction

Would -Wmissing-noreturn have caught this?  It sounds like you need this
(and then fix all resulting warnings) to not upset objtool?

It is nice to have this anyway (if there aren't a zillion false
positives), but it seems objtool is very fragile.


Segher
