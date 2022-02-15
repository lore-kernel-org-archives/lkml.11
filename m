Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77239C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 15:46:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241124AbiBOPqL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 10:46:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiBOPpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:45:32 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41624333
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 07:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=esxeZM4q/UNDHpoEiVgydHmJA07+/Q3fcOjToRBk7e4=; b=Kpyy6zHsncrLBdN3W8+SLV1um+
        u6dw+y/n2VWj3scnjt2WRjNuAUnhKaZx/jvO4El8mBTvl28eQunsrQiBmxZl4TLxCCfWFd28/rzsC
        lwRqC4MLn2YkkanzAiJHZv2dYaGnrzGQnhlI418EjAflVkAMnFZaFC+TO3cjwpdafOtxyaa51KrOC
        AfcISlOoJ01ZQSAtcOgtatCC9mkBxdd/HieoSdsuQYivmn1NS5WW9Oc5oyLluwOkIxaXXantk2YmQ
        iqwHaYjrFlZMpcyPcP5GBphaHBZvWligIWB5O+e5sv1A39pQ6NT8oKw5EUTwxUSaWSYEPOCBPJvyT
        hwO3ipUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJzx3-00A8ip-T5; Tue, 15 Feb 2022 15:41:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 420E73001F3;
        Tue, 15 Feb 2022 16:41:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21C352D7640D3; Tue, 15 Feb 2022 16:41:13 +0100 (CET)
Date:   Tue, 15 Feb 2022 16:41:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        H Peter Anvin <hpa@zytor.com>
Subject: Re: [PATCH V2 0/2] perf/x86/intel/pt: Add support for event tracing
 and TNT disabling
Message-ID: <YgvJmf0kc4+EXqmC@hirez.programming.kicks-ass.net>
References: <20220126104815.2807416-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126104815.2807416-1-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 12:48:13PM +0200, Adrian Hunter wrote:
> Alexander Shishkin (2):
>       perf/x86/intel/pt: Add a capability and config bit for event tracing
>       perf/x86/intel/pt: Add a capability and config bit for disabling TNTs
> 
>  arch/x86/events/intel/pt.c       | 16 ++++++++++++++++
>  arch/x86/include/asm/intel_pt.h  |  2 ++
>  arch/x86/include/asm/msr-index.h |  2 ++
>  3 files changed, 20 insertions(+)

patches look Ok otherwise, I'll queue then in perf/core
