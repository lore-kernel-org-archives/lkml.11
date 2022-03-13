Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA578C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Mar 2022 08:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiCMIIa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Mar 2022 04:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiCMII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 04:08:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C0DD951
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 00:07:20 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id c7so10442108qka.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 00:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ajKY1YqMlkGanqNAhqSycoWS8C+k2srcf3gUvvcgkY=;
        b=fu9fFdZlg3Qi/N2ooY6PidW6HwYNMT3dVV27fOq6ZaYQlSzPbPYsU/d0vg2xbqRcKI
         Nyzs75aDHGxURPRM56U5RDmDtFgKiMeAnZ7xxMsJm+paYNm4kyNFuaUmmIM0JTl+5PQL
         sm+24tmMqhhkAV5EUc87s5yoKCiSWEQvuelWraafWUpQUQDFgZPy/hifponydXDzRwSH
         2RAwkBwOqO4kK597qElU6TObE5/CTKQS3zex/vw2bQHp+rR2YxMMCEKRZJ3ICD9ifPSC
         lEleLRw0duOrmCaCC9TYFfJhZ1EVy0iNmFfgTU9zCbGQ8CKfPOruZDyqLt+rSaVcBbgL
         zcyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ajKY1YqMlkGanqNAhqSycoWS8C+k2srcf3gUvvcgkY=;
        b=qijxAZ1s2EP05uJWJgbpRw8duTOhujuIr46IQNBSEaBgIcJZ2GSCe1W7AYez2EhINi
         zeMxkQn55UJMTYc8K2PmxVsp8EKlJgcMI/A4DlRItcqbEWYjJoww9Z5IztQczsoYzCNg
         xOqgfawPza2DhnYKOT7fv+n0/TUPK/01m3D4Hwn1SgqXRqhtYVS2bBO37seg/ODsfEj1
         27lkAf5HJzic2smuMnOT8KGJCQ3JRxcJj30Fw4fFvM7wLuKFGKwU8vls7BgtuCTSWrc9
         t/OoRaigRxDiVjm1wiYMy6RLDZuXFESqonxDLTITfprEsEyl5G6JTDmUrDaPqv0egEB4
         Zayg==
X-Gm-Message-State: AOAM531sxWMN4uTBV/XVH7W2ZDhLp92lT0zE3ceHH8b8QX4G69CvQUs2
        eOHIeH/vaOb7Pn+qEiBvEx4=
X-Google-Smtp-Source: ABdhPJxlAdB8WxySBLebs3HdxsKJVyls2z3NviBOw5EWywuPO15ZdLmQc/AxmNG026Nx2XL0Y6z7bw==
X-Received: by 2002:a05:620a:24c8:b0:67d:c9f4:8271 with SMTP id m8-20020a05620a24c800b0067dc9f48271mr243927qkn.96.1647158839584;
        Sun, 13 Mar 2022 00:07:19 -0800 (PST)
Received: from mail.google.com ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b002e02be9c0easm8879802qts.69.2022.03.13.00.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 00:07:19 -0800 (PST)
Date:   Sun, 13 Mar 2022 16:07:11 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ingo Molnar <mingo@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: ftrace: no need to acquire text_mutex when
 executed in stop_machine
Message-ID: <20220313080711.mrzsgtxpbycug2vm@mail.google.com>
References: <20220310045454.672097-1-changbin.du@gmail.com>
 <20220310092742.4fcc7131@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310092742.4fcc7131@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 09:27:42AM -0500, Steven Rostedt wrote:
> On Thu, 10 Mar 2022 12:54:54 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > It's safe to patch text segment in stop_machine. No race is possible here.
> > Besides, there is a false positive for the lock assertion in
> > patch_insn_write() since the lock is not held by cpu migration thread.
> > 
> > So we actually don't need our ftrace_arch_code_modify_prepare/post(). And
> > the lock assertion in patch_insn_write() should be removed to avoid
> > producing lots of false positive warnings.
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> 
> Ideally, RISC-V should try to get off of the stop_machine approach, and
> move to the breakpoint modification.
>
yes, that's a further step. I can feel a obvious stall to enable ftrace running
in QEMU. (maybe qemu-riscv tcg is too slow...)

> -- Steve

-- 
Cheers,
Changbin Du
