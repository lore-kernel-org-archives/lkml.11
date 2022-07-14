Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827B5C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jul 2022 17:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240141AbiGNRDz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiGNRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:03:51 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BE2101D6;
        Thu, 14 Jul 2022 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oRwEr6A1IVEPWhQvPx2mv6RXTE8efFlDv1Ac9Jh+3F0=; b=W8cAbI9PJJ2ZuOKisQBeoqGNwX
        S49wbRFE4KYRcnaaELLQA+KryloAn8zV5zk+qE7uRMb7hM9vXr3PVXcRuwviUc5UWZzjY6OzAkWU2
        ujKZZsakaWz3GQFF0k5R7h9ORar+A/QBhuQHlPXAWQ+q2mqI5/cEK8mecOpcmj2R7v/7DGyNxosGB
        t1DXcjK1UPWyBJR4R2wVmyEVGrx9KLXnFww+d51IdyvO/rSTlMW4Ra/vuRmvRm1r2Tr1/AU0fXrqd
        R5sUiIts3pMitsoBB/u68f/6BZenuUeu9dPb7J1VC1ko+igtM+mKWbsipGB/D7kn4VAB2KYsSRWxD
        5mJ5V/5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oC2FS-003t8G-Jo; Thu, 14 Jul 2022 17:03:35 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4E297980185; Thu, 14 Jul 2022 19:03:32 +0200 (CEST)
Date:   Thu, 14 Jul 2022 19:03:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        antonio.gomez.iglesias@linux.intel.com
Subject: Re: [PATCH] x86/bugs: Switch to "auto" when "ibrs" selected on
 Enhanced IBRS parts
Message-ID: <YtBMZMaOnA8g8m0a@worktop.programming.kicks-ass.net>
References: <0456b35fb9ef957d9a9138e0913fb1a3fd445dff.1657747493.git.pawan.kumar.gupta@linux.intel.com>
 <Ys/7RiC9Z++38tzq@quatroqueijos>
 <YtABEwRnWrJyIKTY@worktop.programming.kicks-ass.net>
 <20220714160106.c6efowo6ptsu72ne@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714160106.c6efowo6ptsu72ne@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 09:01:06AM -0700, Josh Poimboeuf wrote:

> > Yeah this; if the user asks for IBRS, we should give him IBRS. I hate
> > the 'I know better, let me change that for you' mentality.
> 
> eIBRS CPUs don't even have legacy IBRS so I don't see how this is even
> possible.

You can still WRMSR a lot on them. Might not make sense but it 'works'.
