Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2858C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 12:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351984AbiDSMD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Apr 2022 08:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244321AbiDSMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:01:25 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438481FA67
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 04:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=DzuI/hP4j8qyKw02hy+UWxmxPErK21aY6wcTdlY7vX0=; b=dYA53jEasPAswBQt9fprgbs7Q6
        Pr1tFn/7z5/Q1Q901av7xURJmYYp5Es4BaV7Tcnowc/kX8mmc9S/NdwlGtjcY2YiDE4G3LKanvS7B
        wLmYO1TIUFsmwKEkKVmsT7awSo0MtIWQjX7HIWu6S+CQA08Ml2uaPmxr427ZgqeqEFrBfHJj+W2BT
        mLDfsoN5tsUe63kLOA1Lzd1OZZElV4ku6xScEaEkuO37s/wLg/9JM8/4yKcJRyqzClDJ9qvaqsYD3
        632Ihd6pLS0RdjcDGfgjOomBVlV/cEtKR31yUOp33Gy9tC6QvzejJUyooy4b/muCHrqjRaLywR+X1
        LhcoX+qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ngmUF-006oN1-7J; Tue, 19 Apr 2022 11:57:39 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id A3E4B986195; Tue, 19 Apr 2022 13:57:37 +0200 (CEST)
Date:   Tue, 19 Apr 2022 13:57:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH v2 06/25] x86/xen: Add ANNOTATE_ENDBR to startup_xen()
Message-ID: <20220419115737.GU2731@worktop.programming.kicks-ass.net>
References: <cover.1650300597.git.jpoimboe@redhat.com>
 <a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com>
 <b94cbac6-0a4d-8e4a-ec58-bbd46e385d45@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b94cbac6-0a4d-8e4a-ec58-bbd46e385d45@citrix.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:42:12AM +0000, Andrew Cooper wrote:
> On 18/04/2022 17:50, Josh Poimboeuf wrote:
> > The startup_xen() kernel entry point is referenced by the ".note.Xen"
> > section, but is presumably not indirect-branched to.
> 
> It's the real entrypoint of the VM.  It's "got to" by setting %rip
> during vcpu setup.
> 
> We could in principle support starting a PV VM with CET active, but that
> sounds like an enormous quantity of effort for very little gain.  CET
> for Xen PV requires paravirt anyway (because the kernel runs in CPL!=0)
> so decisions like this can wait until someone feels like doing the work.
> 
> >   Add ANNOTATE_ENDBR
> > to silence future objtool warnings.
> >
> > Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: xen-devel@lists.xenproject.org
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> FWIW, Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>, preferably
> with the commit message tweaked to remove the uncertainty.

Something like so then?

---
Subject: x86/xen: Add ANNOTATE_ENDBR to startup_xen()
From: Josh Poimboeuf <jpoimboe@redhat.com>
Date: Mon, 18 Apr 2022 09:50:25 -0700

From: Josh Poimboeuf <jpoimboe@redhat.com>

The startup_xen() kernel entry point is referenced by the ".note.Xen"
section, and is the real entry point of the VM. It *will* be
indirectly branched to, *however* currently Xen doesn't support PV VM
with CET active.

Add ANNOTATE_ENDBR to silence future objtool warnings.

Fixes: ed53a0d97192 ("x86/alternative: Use .ibt_endbr_seal to seal indirect calls")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andrew Cooper <andrew.cooper3@citrix.com>
Link: https://lkml.kernel.org/r/a87bd48b06d11ec4b98122a429e71e489b4e48c3.1650300597.git.jpoimboe@redhat.com
