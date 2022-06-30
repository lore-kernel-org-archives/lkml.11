Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CDDC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jun 2022 12:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234158AbiF3M2O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jun 2022 08:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234186AbiF3M2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 08:28:09 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286AA3389C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:28:04 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-101dc639636so25562698fac.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 05:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fars46ihWldzKhsiNp4tOcZid3mM1cwp7AwPJo3kkUU=;
        b=bTOtzm38zOtR3lMJW1aUnOeqOXAUTvOMcGRyLA35X+GYu3K7EZz4uGRDNM2vzbbqjh
         L7JLqK8qBPUQeSkSuoTYml3Gh8QEP6uFYZduWKa9pLcI7C5poyh5Yh7yoA/PMkxN2Uj9
         ioPX/n+0mjFoTzx7Q4v8Q2ApT8aBTBhAJ1mv8bNDH8O2G5H7aHRNvgJEiJqZb0XWexM2
         /7BLF+h9ajFd85J0ib+Ji8Tf/NF4utGZzBfrXV/tViCcEI2YY980y0HJFYgJrgnYRIlj
         Y6gY7n/JhxOtE3rhYHqU/joag5k2eFjwUXYfz9R7d7LpOVjy3XUCSuqCue7/n5RjaSYc
         RRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fars46ihWldzKhsiNp4tOcZid3mM1cwp7AwPJo3kkUU=;
        b=FIQ85y8kmmrunu/HoWyHJZ2sQVlh+4pYJ4F0/Py/5HAjbVMsRqNeVxm9zvm078XJ8e
         FQ/AmvGnLlXB95fXYL9VxinITAOc7/4kPFmLTAP+mh7YYaxBsbFCtIURI15YXgOJSS8V
         2zonfm7+XP1qTcIWUjn+dFTYpyA28K0hh82jFbe0ZXTed6CUE1TVfwW/Zf1MeXR7u4+Y
         4CRLv9M1WT5sffp+EcHhuEbSZu+aEuG7x67sjpXYQAhOb8O2LaGaQRPRoLPwDzMnoD/+
         FW0x0HP0Zwkf38iLTbJKHTAb3jcaRHyNMuEeZVXCdi+XpPQxmrZb/8PrOeJYhHQUk6qP
         ZVrQ==
X-Gm-Message-State: AJIora8RPYJSfJcOD45KFvBWBV9yKlftDa91DC+TxKepzyrwGyD9MZkv
        iJ+hmYtC09rwn30cSYO9iIm7vzZ3+iUoE5moEMVthoiWJ7k=
X-Google-Smtp-Source: AGRyM1v1MxDC1t3LTB6jb9AsKX5TiYcjEhwXDUUunBTCUOP5R8BGTgMAFtLCPbF2ta6bXigG8/gfBLKUJSoOFCozPIU=
X-Received: by 2002:a05:6870:c596:b0:101:6409:ae62 with SMTP id
 ba22-20020a056870c59600b001016409ae62mr6252583oab.112.1656592083389; Thu, 30
 Jun 2022 05:28:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-29-vkuznets@redhat.com>
 <CALMp9eRCbgYVGtAwpDWhytQSjeGeAOuqKZXVg3RpV92uKV5u0A@mail.gmail.com> <87tu82siuw.fsf@redhat.com>
In-Reply-To: <87tu82siuw.fsf@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 30 Jun 2022 05:27:52 -0700
Message-ID: <CALMp9eQ+L1HPXcw1mysx3tYeN-=mGrZCxjZWDcJwtdfZZ6z8Dg@mail.gmail.com>
Subject: Re: [PATCH v2 28/28] KVM: nVMX: Use cached host MSR_IA32_VMX_MISC
 value for setting up nested MSR
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 12:36 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Jim Mattson <jmattson@google.com> writes:
>
> > On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
> >>
> >> vmcs_config has cased host MSR_IA32_VMX_MISC value, use it for setting
> >> up nested MSR_IA32_VMX_MISC in nested_vmx_setup_ctls_msrs() and avoid the
> >> redundant rdmsr().
> >>
> >> No (real) functional change intended.
> >
> > Just imaginary functional change? :-)
> >
>
> Well, yea) The assumption here is that MSR_IA32_VMX_MISC's value doesn't
> change underneath KVM, caching doesn't change anything then. It is, of
> course, possible that when KVM runs as a nested hypervisor on top of
> something else, it will observe different values. I truly hope this is
> purely imaginary :-)

It is also theoretically possible that a late-loadable microcode patch
could change the value of the MSR, but Intel wouldn't do that to us,
would they?
