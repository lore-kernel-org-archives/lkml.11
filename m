Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06B71C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 19:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbiCITJR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 14:09:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiCITJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:09:08 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA2E1301B1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 11:08:08 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so4028900oos.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 11:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1BBNE2Z7xX/iDpDVd9HNA0LnoK1/Orld3Zm6k/q29x8=;
        b=lDmU2VnYoVeM3FVwcJOoCigYGj5OQmzCSFQ0KsRWXe2H2Z4Vo955ANEQr5DvQu14qI
         kGb6onkYhTgB5ProD4HdFakT3fS15Ssr7pzeC0Oa0F6KOl70mZvW0BtQzIc2G6BnX88u
         SWeyZ6yyZkmx8lAApeC44f/pz9ivsrFcQnUnfkPMKdwM6Pgo++NQELAYjS4Xjcv8HDzF
         Nf0quzenTygQIHVQ+Q086Paf1DfXTlWRX20YI2XgZv8f780W5BD+R/q5sD7b6MdvuAul
         PgwvWUKp4w58wSxb8L93Koc70v8SyuaLnEy1jbs4dqrTMtXJqgQyVBhwiRWJxgo11BIX
         ICbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1BBNE2Z7xX/iDpDVd9HNA0LnoK1/Orld3Zm6k/q29x8=;
        b=sQK9yftYNKzjYsSneff6EAFwC5pbnk3LziF/B8FoGxf3euVajWdWMv/Ycz3Ln57qEP
         7WFJv1FiqMB534XQvmNjxxYJ6AaaWkN6kUgvGvVztDg5I7faO3oNCL3Wrx+QEc4BpGfl
         kbDb5GS7KfpyixqAjOZ4q4eVF5FE/yIiPGx8LKmGfvgW7RJFIX7QADk2VMlOdy35opZ0
         dR/xbKPMj++Q3Ygt0XPomSEKLxPGFA1gbBt0OGpV4JUtyYYxqWT/yH1S5J/RSFAPB5tx
         IapDMvRflC+0UmcrQeSTSgHORMO+uh7caz4tAZ4ZzCR1ievOifR3zeqcOsfP2S9bzecg
         lOFA==
X-Gm-Message-State: AOAM530rZRtPlc9Nk4YToAk7xq17pne9y31cO9uIJ2VO8mlEjZEkt22Q
        ITy1VWXLHotid+xsiIsSW7SAPubBNQTKeb3ajkgw3w==
X-Google-Smtp-Source: ABdhPJwFi13QGLJKlJtbkRi+1a/3SPoP12jbbPuWk7HzYhR/TImuzsPjfel2rRsfJsgxw2z0/TrZhP/zlz9mte658RQ=
X-Received: by 2002:a05:6870:1041:b0:d3:521b:f78a with SMTP id
 1-20020a056870104100b000d3521bf78amr6277551oaj.13.1646852887716; Wed, 09 Mar
 2022 11:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20220301143650.143749-1-mlevitsk@redhat.com> <20220301143650.143749-5-mlevitsk@redhat.com>
 <CALMp9eRjY6sX0OEBeYw4RsQKSjKvXKWOqRe=GVoQnmjy6D8deg@mail.gmail.com> <6a7f13d1-ed00-b4a6-c39b-dd8ba189d639@redhat.com>
In-Reply-To: <6a7f13d1-ed00-b4a6-c39b-dd8ba189d639@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 9 Mar 2022 11:07:56 -0800
Message-ID: <CALMp9eRRT6pi6tjZvsFbEhrgS+zsNg827iLD4Hvzsa4PeB6W-Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] KVM: x86: nSVM: support PAUSE filter threshold and
 count when cpu_pm=on
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:47 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 3/9/22 19:35, Jim Mattson wrote:
> > I didn't think pause filtering was virtualizable, since the value of
> > the internal counter isn't exposed on VM-exit.
> >
> > On bare metal, for instance, assuming the hypervisor doesn't intercept
> > CPUID, the following code would quickly trigger a PAUSE #VMEXIT with
> > the filter count set to 2.
> >
> > 1:
> > pause
> > cpuid
> > jmp 1
> >
> > Since L0 intercepts CPUID, however, L2 will exit to L0 on each loop
> > iteration, and when L0 resumes L2, the internal counter will be set to
> > 2 again. L1 will never see a PAUSE #VMEXIT.
> >
> > How do you handle this?
> >
>
> I would expect that the same would happen on an SMI or a host interrupt.
>
>         1:
>         pause
>         outl al, 0xb2
>         jmp 1
>
> In general a PAUSE vmexit will mostly benefit the VM that is pausing, so
> having a partial implementation would be better than disabling it
> altogether.

Indeed, the APM does say, "Certain events, including SMI, can cause
the internal count to be reloaded from the VMCB." However, expanding
that set of events so much that some pause loops will *never* trigger
a #VMEXIT seems problematic. If the hypervisor knew that the PAUSE
filter may not be triggered, it could always choose to exit on every
PAUSE.

Having a partial implementation is only better than disabling it
altogether if the L2 pause loop doesn't contain a hidden #VMEXIT to
L0.
