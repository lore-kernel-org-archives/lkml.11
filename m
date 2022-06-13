Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E41CCA47B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 20:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351520AbiFMU75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348989AbiFMUzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:55:48 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C61C3F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:28:25 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bd16so1043393oib.6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F1BsEzeoJMGJfvvWlT/Yu0nVhqbd5OzaqJq8yfmd928=;
        b=JE0WnPM6vgb2044eluqDd1QRq5BRoZM06OJVAu+pqiZAxQBntiuabuVIEJzTs29mq0
         LuWHt3nNEIguHoHF7n2TRWK8oxP49PJzX8zigOUmK/fufogl0VpOd/FSJhPcY9uVaBqC
         fFK6/zI+CTG48d48ohqGB+XgxBJ8bgy0GeIkBoHTddeBxaOsJVNfyINcbEjSj8tHY69G
         WViB6Ggo6eNlW1YLG1HkDKHj4dyBYBV2fMdGJItoNPdU+1XkzVNwAGH/OiwvR3mUClQl
         ovNg/5deQcZtwWLI0KZl/J4j2rCcyF70dcUGmybFGp3xv31hD2bETZFxAUK5cBqrcUoc
         TXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1BsEzeoJMGJfvvWlT/Yu0nVhqbd5OzaqJq8yfmd928=;
        b=tpqupJDR//khn88VfTuS9n1s2I0Cto5T/DPiYXjDonu2zzzUo6emkVp+u7QKJltHIW
         MDrQyIDgBqPqAdeFU/P6f1uDiNc8wU25DBlYcJqVLqNbCHgMOyELo+DbIpyLpLBN+fCB
         g2UbtmQ86Csjr+3UPt1JMurSh1Q93AkhWgLawVlgCXGHt59ac8oY+nF08M1UkMfBcWvY
         uKSLWWfvKtZNu8aYc5pkCJxqtDzigWBa+GctHf6vfOzIrdYmWbrSLlVOgNUb1EKizlHL
         cK/+mXHdZmWYcQy1wqspEkcTtF4KAi+0PFtVimI4LwerlDTZHPaBvPqmhGnejft7g4O1
         Nbyw==
X-Gm-Message-State: AOAM530hyUnYIaYk+r9nCIq+1C0Vh2cN55+AfeMvvYdyBQJKs4UIMJMu
        lGCr7LWnfwTuqFNdPvmj7XFM39PAr8zn7dqlRjyjFQ==
X-Google-Smtp-Source: ABdhPJwb061Tr8q4AswjXAIT3ltkV7Vxsykz1cnTDu6h03hM4CDgmE8X8tOldoAZyk7w/HTImFqlver27uiqFjBKnZ0=
X-Received: by 2002:a05:6808:1189:b0:32b:7fb5:f443 with SMTP id
 j9-20020a056808118900b0032b7fb5f443mr268221oil.269.1655152104815; Mon, 13 Jun
 2022 13:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <161188083424.28787.9510741752032213167.stgit@bmoger-ubuntu>
 <161188100955.28787.11816849358413330720.stgit@bmoger-ubuntu>
 <CALMp9eTU5h4juDyGePnuDN39FudYUqyAnnQdALZM8KfiMo93YA@mail.gmail.com>
 <5d380b11-079f-e941-25cf-747f66310695@amd.com> <CALMp9eRnC1RgRwj64TJcXdhhL6g835N_-E8FbeHVre6aX=18-A@mail.gmail.com>
 <17a3d97e-3087-e79a-120d-b4a45f6c4fba@amd.com>
In-Reply-To: <17a3d97e-3087-e79a-120d-b4a45f6c4fba@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 13 Jun 2022 13:28:13 -0700
Message-ID: <CALMp9eT1_G1yp30K=DqEUsV=yK_w9KoU_ANnSPq4ueqzBTkLZw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] KVM: SVM: Add support for Virtual SPEC_CTRL
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Babu Moger <babu.moger@amd.com>, pbonzini@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, tony.luck@intel.com, wanpengli@tencent.com,
        kvm@vger.kernel.org, peterz@infradead.org, seanjc@google.com,
        joro@8bytes.org, x86@kernel.org, kyung.min.park@intel.com,
        linux-kernel@vger.kernel.org, krish.sadhukhan@oracle.com,
        hpa@zytor.com, mgross@linux.intel.com, vkuznets@redhat.com,
        kim.phillips@amd.com, wei.huang2@amd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 1:16 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:

> Ah, yes, I get it now. I wasn't picking up on the aspect of running older
> KVM versions on the newer hardware, sorry.
>
> I understand what you're driving at, now. We do tell the hardware teams
> that add this type of feature that we need a VMCB enable bit, e.g. make it
> an opt in feature. I'll be sure to communicate that to them again so that
> this type of issue can be avoided in the future.

Thank you so much. Might I also ask that new features get promptly
documented in the APM?

It took us an incredibly long time to figure out why just one vCPU
thread would run slow on every GCE AMD instance. It wasn't always the
same thread, but the slow vCPU thread would still be slow even after
live migration. On a guest reboot, the slowness might migrate to a
different vCPU thread. How bizarre, right?

It turns out that, on UEFI-enabled images, one vCPU makes an EFI
firmware call, which sets IBRS. You can't see that IBRS is on from
within the guest, but it is, because of the sticky first non-zero
write behavior induced by virtual SPEC_CTRL.
