Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26897C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jun 2022 16:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352873AbiFUQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiFUQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 12:27:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D96B21AD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:27:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16DC3B81A6A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D52B5C341C7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 16:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655828872;
        bh=Ow9D4yPO25VtNl7FIH7LrdA561YGWfpt8NV3HmX+5v4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=US9MeMpuQsEBK65ATBnqHn4e5RKa2YBVmkswS9nBUZOi2h2TsyxRhyry6a3l9JpbD
         aWktDLEN9y8JJnihtKcDFWNu7RbWTQg2hT6tFtTKoUHSpZQe4OHsAI50EgSISyr0Mu
         FlhLLbYQxOjZt/6IayLDNX9/9MiiFtBKqZGqeRWT9IgxDkYnRksrPcSkBWiZFdKYEj
         iprn8upEG0Kheov3FPBdXNZ3OSWwfM5Y9NF/ILFj4IKIvR6AYbj96YmqQhFPmC08Ol
         Q3eIgQBtWUqJxQItmCxHgSqivgFYuogw5b/pWuJ5TmdpdURaUd/R9/WQoXDEvDfmpJ
         SApob/jBWsO2w==
Received: by mail-lf1-f50.google.com with SMTP id c2so23309748lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 09:27:52 -0700 (PDT)
X-Gm-Message-State: AJIora/RnVdF8tRxH3sDW9iImWgHW0wq65EfPA7vXLgC8Ma7L03nHQYV
        qiF6fptTIWbt9oSmatOI6ISm5slXVDouVRUtWEQ=
X-Google-Smtp-Source: AGRyM1sxI+XlakcNa4QhOAb7YA04qoN7l8hSkBw/eUkQTFmYZnjwjwaSgLytd7wwJxfEq7/OBZCvYNAer69Ec5wQBxU=
X-Received: by 2002:a05:6512:1292:b0:479:6313:789e with SMTP id
 u18-20020a056512129200b004796313789emr17953388lfs.538.1655828870919; Tue, 21
 Jun 2022 09:27:50 -0700 (PDT)
MIME-Version: 1.0
References: <YqxkhV1YcI6e+xXp@worktop.programming.kicks-ass.net> <YqxoEJG6jGDWitg3@FVFF77S0Q05N>
In-Reply-To: <YqxoEJG6jGDWitg3@FVFF77S0Q05N>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Jun 2022 18:27:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFuPAUfknadWDXPDXA5LYFnr0MGeXvF5MAYJBLxfCWEWw@mail.gmail.com>
Message-ID: <CAMj1kXFuPAUfknadWDXPDXA5LYFnr0MGeXvF5MAYJBLxfCWEWw@mail.gmail.com>
Subject: Re: [RFC][PATCH] ftrace,objtool: PC32 based __mcount_loc
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jun 2022 at 13:40, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Fri, Jun 17, 2022 at 01:24:53PM +0200, Peter Zijlstra wrote:
> >
> > Hi,
> >
> > I recently noticed that __mcount_loc is 64bit wide, containing absolute
> > addresses. Since __mcount_loc is a permanent section (not one we drop
> > after boot), this bloats the kernel memory usage for no real purpose.
> >
> > The below patch adds __mcount_loc_32 and objtool support to generate it.
> > This saves, on an x86_64-defconfig + FTRACE, 23975*4 ~= 94K of permanent
> > storage.
>
> We have a similar issue on arm64, which is exacerbated by needing ABS64
> relocations (24 bytes per entry!) adding significant bloat when FTRACE is
> enabled.
>
> It'd be really nice if going forwards compilers could expose an option to
> generate PC32/PREL32 entries directly for this.
>

As opposed to generating absolute references today? Or as opposed to
having to rely on our own tooling?
