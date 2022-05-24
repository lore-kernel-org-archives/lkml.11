Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29476C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 24 May 2022 18:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240124AbiEXSCo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 May 2022 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiEXSCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:02:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4847DF53
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=y1TnWebPhJ1BojdW0cvueZgENLRV8F2gmqpv6bJIuPc=; b=Fpqfein5bh92hXEpVGleAKPEuZ
        yWch4DkG4Dx1jtgWEfvCef0HqeHBC5L1gYIXmDtb4MmCqTATCSYmlGOQ1vI/9OZIR15L1Au0EVlUd
        ijhgcll3q96D6F9krdEPKqSj+AqUY/pb9cdFQtxvs8ea/wtVuJGkfwslMTzxEMk9rEnmk0F98U1J/
        vF0dHBaOyHvK9xQo6W0IjRaskFXRYhd1RklUvQBdk7Vtw4fBl8hzECMNzC+97AAd7399VxIWPhred
        CtW2NtgHjpkUGdNfL/pUADxg8UafiifiLetN+tQ8nEI1j5sKcfiAd2+TsyV6We74E++c+BvbgUBjF
        SL1CJSJA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ntYrG-00HIoU-JF; Tue, 24 May 2022 18:02:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AFF113002BE;
        Tue, 24 May 2022 20:02:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0E1C201A996B; Tue, 24 May 2022 20:02:12 +0200 (CEST)
Date:   Tue, 24 May 2022 20:02:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, aik@ozlabs.ru,
        sv@linux.ibm.com, rostedt@goodmis.org, jpoimboe@redhat.com,
        naveen.n.rao@linux.vnet.ibm.com, mbenes@suse.cz,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 5/7] objtool: Enable objtool to run only on files
 with ftrace enabled
Message-ID: <Yo0dpDuK3ilphNAA@hirez.programming.kicks-ass.net>
References: <cover.1653398233.git.christophe.leroy@csgroup.eu>
 <cf3013dfad89ad5ac7d16d56dced72d7c138a20e.1653398233.git.christophe.leroy@csgroup.eu>
 <Yo0dgyqAOuwU6gHq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo0dgyqAOuwU6gHq@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:01:39PM +0200, Peter Zijlstra wrote:
> On Tue, May 24, 2022 at 03:17:45PM +0200, Christophe Leroy wrote:
> > From: Sathvika Vasireddy <sv@linux.ibm.com>
> > 
> > This patch makes sure objtool runs only on the object files
> > that have ftrace enabled, instead of running on all the object
> > files.
> > 
> > Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> > Signed-off-by: Sathvika Vasireddy <sv@linux.ibm.com>
> > Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> >  scripts/Makefile.build | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index 2e0c3f9c1459..06ceffd92921 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -258,8 +258,8 @@ else
> >  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'y': skip objtool checking for a file
> >  # 'OBJECT_FILES_NON_STANDARD_foo.o := 'n': override directory skip for a file
> >  
> > -$(obj)/%.o: objtool-enabled = $(if $(filter-out y%, \
> > -	$(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y)
> > +$(obj)/%.o: objtool-enabled = $(and $(if $(filter-out y%, $(OBJECT_FILES_NON_STANDARD_$(basetarget).o)$(OBJECT_FILES_NON_STANDARD)n),y),        \
> > +        $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),y),y)
> 
> I think this breaks x86, quite a bit of files have ftrace disabled but
> very much must run objtool anyway.

Also; since the Changelog gives 0 clue as to what problem it's trying to
solve, I can't suggest anything.
