Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 18:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350075AbiC3SjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 14:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351282AbiC3Sd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:33:26 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22B34DF4C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:30:45 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u3so28930543ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KXz4jX/1RvaOeW5K5aku8Xx+S8uCJJg7lNaIyrndCYc=;
        b=frqv9Lra3sJ1hmBQk1xcR/thRy/JxxiQUadtvz+DMIkXvKrJabZbpPUhpx+Ve91aKc
         fLtY+UckqqT5YbdQA6Bky2RLFbQGh3k/vghn4LAPKw2vzDDLZU8Djq3wr+waC5oPb6L1
         OmcgLSd750msUztwjdciWczDq24pauhcEFfzo8gsEcqI3INuIwXc8ZKgtbeeROpqBcea
         TWj8QVrS7lwjkJ/gwXL55djUOd1ZT2y0CjXJB2SaDuaaaaenT5X+byGZTDIlcyjz0gxd
         tZKQNwA4kvDKzqYqykOxvB1FCoKLfdgKaUrBgUw1JjNJ9dp679PQP6+DUBuAvPampRj8
         TsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KXz4jX/1RvaOeW5K5aku8Xx+S8uCJJg7lNaIyrndCYc=;
        b=tJjgWctKdaYO8Wi5vcgO8PtHNTruibXCsJsdakjWUEVIEzsbI+e4lp/zFQTWhFlA48
         wQO7dQJUoJGCluegGYWo0mlWYzODMQPCSsH6Y3fCET4APHObS3t4yLAeB4Wn/AX/6sJ5
         Dz3lJzcVDp4Om3gvsdFKKdeQfcrV6z2vIeuEA5rPmbBmm2bTPq5aYtb7dk2wk7Q61gZq
         dfLbU4p0KMX/xw/G6izU2Ex5QxTZyCUQIRokGS3a163ahwFOVO/i8x/bGGYPwtVyErwW
         gdUTewEHjcIwNU1804Ng+T3tGm3lGwL6dmDLwp1Sid2v/NaUWCo0M4RZMvMs5S8pwp+C
         /4dA==
X-Gm-Message-State: AOAM532F7WHRCGFNEmXD3LKdG6YqoB9/d8aRNgNjUNBhjENxp9Q0b/fX
        DpUtF5P2fka4lJQvRBssaDCFkFeJoWU5qJn/pGhQ8Q==
X-Google-Smtp-Source: ABdhPJxkJ9NLcGGxc1sMNi6f38U3o2OW0nZw+JbR7XSZZ4ykgVP08KAUGWyfphqVLg8WNP0f2n2s2VFEsZJtak2cP9w=
X-Received: by 2002:a2e:988e:0:b0:24a:cf5d:24cf with SMTP id
 b14-20020a2e988e000000b0024acf5d24cfmr7486340ljj.282.1648665039455; Wed, 30
 Mar 2022 11:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220325152758.335626-1-pgonda@google.com> <d0366a14-6492-d2b9-215e-2ee310d9f8ae@redhat.com>
 <CAMkAt6rACYqFXA_6pa9JUnx0=3vyM6PeaNkq-Yih4KM6saf6PQ@mail.gmail.com> <632d3601-ecf4-12f3-4f3b-408c35f028f6@redhat.com>
In-Reply-To: <632d3601-ecf4-12f3-4f3b-408c35f028f6@redhat.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 30 Mar 2022 12:30:28 -0600
Message-ID: <CAMkAt6q-wTxiQnFXhiw3gR_8ktfz9pLp3gZS3EFakGcBgxUJ2A@mail.gmail.com>
Subject: Re: [PATCH v2] Add KVM_EXIT_SHUTDOWN metadata for SEV-ES
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>, Marc Orr <marcorr@google.com>,
        Sean Christopherson <seanjc@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 10:53 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 3/25/22 16:31, Peter Gonda wrote:
> > On Fri, Mar 25, 2022 at 9:29 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> >>
> >> On 3/25/22 16:27, Peter Gonda wrote:
> >>> SEV-ES guests can request termination using the GHCB's MSR protocol. See
> >>> AMD's GHCB spec section '4.1.13 Termination Request'. Currently when a
> >>> guest does this the userspace VMM sees an KVM_EXIT_UNKNOWN (-EVINAL)
> >>> return code from KVM_RUN. By adding a KVM_EXIT_SHUTDOWN_ENTRY to kvm_run
> >>> struct the userspace VMM can clear see the guest has requested a SEV-ES
> >>> termination including the termination reason code set and reason code.
> >>>
> >>> Signed-off-by: Peter Gonda <pgonda@google.com>
> >>> Cc: Paolo Bonzini <pbonzini@redhat.com>
> >>> Cc: Borislav Petkov <bp@alien8.de>
> >>> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> >>> Cc: Brijesh Singh <brijesh.singh@amd.com>
> >>> Cc: Joerg Roedel <jroedel@suse.de>
> >>> Cc: Marc Orr <marcorr@google.com>
> >>> Cc: Sean Christopherson <seanjc@google.com>
> >>> Cc: kvm@vger.kernel.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>
> >> This is missing an update to Documentation/.
> >>
> >
> > My mistake. I'll send another revision. Is the behavior of
> > KVM_CAP_EXIT_SHUTDOWN_REASON OK? Or should we only return 1 for SEV-ES
> > guests?
>
> No, you can return 1 unconditionally, but you should also set reason and
> clear ndata in the other cases that return KVM_EXIT_SHUTDOWN.


Sounds good! Done in V3, thanks
