Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5216FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Apr 2022 22:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245697AbiDDWa4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Apr 2022 18:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244432AbiDDW3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 18:29:18 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C2B340C3
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 14:51:40 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id p15so19805915lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NUAR6ohw0c+cB2iG3OTNJ9/QNM3sctZv6ga716kg9Qs=;
        b=CiI/2hwLVlzRwZmZQ24QW/virYnoTO28HHhkZCPbk0q70mPEbPm5thEzkvoCzzbBdR
         sh5buC1GVITJxV/Ll7JbCxKFfrqRSPZWO8H5mSof7BuhT19cEgNIyM5O+NTgxRLmy6lg
         a8Xm7KzIvEwFLoiJFB5BYunyw1eSAekwAsH+Cmc7LauP9ou8IXcbTK44QQwoAIN7WBA0
         5QscXUIFiiY6/fI5iznyG2p/G6tKvqdU51KHD4ajgv1PquooV3tl5pV0TQhVe25MkFWR
         rQnuoZAHO7EPnGmTwyjy14SNV1861P0Wvx+e879uSCS5VPOTH2xjN14mcZpJUHwQqUJO
         Svhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NUAR6ohw0c+cB2iG3OTNJ9/QNM3sctZv6ga716kg9Qs=;
        b=fIbZf2+YTFyGeVEg7dXNPaIo9+Gqgqqh75vHtUU/j5QIvyJIeB4yche+XiKLL/e8MD
         MgGGzlrZjQaZMeq9x17879hH4cXwAlHqM/C56/efbtAyp/xMtvqSUBelq/4OEl5s77jm
         Pl2MNqlF+fD+ioq1Zn0Gmpk3cd/d1X1TEeZVGQ/EBizIC6nEv+L0qAyiONSr9hLdY2+K
         xXKss4PoamfWEkcPE7g/Mvd3LVQbzE4M+QhzKfxgfMafqCX0Xr+Ap+dg41nYH9kpftu0
         rJe1iztRidG7VAddnumwJe+89asQtUjzjoqrx10Q6Nu6+epGufhogNCmNMpCEMQk98H3
         a66w==
X-Gm-Message-State: AOAM530WnOx/8CMfiUefmkcveTSkOxx4/CzN8iGs78awUsb8Pm5knRA2
        s/cgLohNXzu4kMvmnkTHaGlTsGL47M8mOVJfi+FAMQ==
X-Google-Smtp-Source: ABdhPJwbPMtpyxeBt2rGXgRp6yuj6edZw7T/hRyccDnC+nwnfDBpO6n5uB/Pj7tLsTFmCvrkHLz6DrRcnfHf/95aYoc=
X-Received: by 2002:a05:6512:131b:b0:44b:75d:e3d0 with SMTP id
 x27-20020a056512131b00b0044b075de3d0mr252146lfu.685.1649109098578; Mon, 04
 Apr 2022 14:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220404194605.1569855-1-pgonda@google.com> <YktWfUbjz27OdbUA@google.com>
In-Reply-To: <YktWfUbjz27OdbUA@google.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Mon, 4 Apr 2022 15:51:27 -0600
Message-ID: <CAMkAt6r+DpuFcnhVMcLnj2tEDmefdCnwUP7axdLiRomCVmdjXg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Mark nested locking of vcpu->lock
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        John Sperbeck <jsperbeck@google.com>,
        David Rientjes <rientjes@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This is rather gross, and I'm guessing it adds extra work for the non-lockdep
> case, assuming the compiler isn't so clever that it can figure out that the result
> is never used.  Not that this is a hot path...
>
> Does each lock actually need a separate subclass?  If so, why don't the other
> paths that lock all vCPUs complain?
>
> If differentiating the two VMs is sufficient, then we can pass in SINGLE_DEPTH_NESTING
> for the second round of locks.  If a per-vCPU subclass is required, we can use the
> vCPU index and assign evens to one and odds to the other, e.g. this should work and
> compiles to a nop when LOCKDEP is disabled (compile tested only).  It's still gross,
> but we could pretty it up, e.g. add defines for the 0/1 param.

I checked and the perf vCPU subclassing is required. If I just only
use a SINGLE_DEPTH_NESTING on the second VM's vCPUs I still see the
warning.

This odds and evens approach seems much better. I'll update to use
that in the V2 unless there is a better idea.
