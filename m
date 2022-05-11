Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1351C433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 16:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbiEKQqo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 12:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbiEKQqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:46:42 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C165C3E5DE
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:46:41 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id l16so3380068oil.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W61e8Beb9C0rrwvWLXvghQlyTT+OB/E10KtzePQGPL4=;
        b=qC9ruXYKycYwwp57PRsAW7znvOrSbuqcW3DHuxmCh8nzW+k7q0H4EMctn5Db56iE9w
         BQUNkHYBv0e1KN8wS5B4c2X+nV6NdLj1L4+1sX5mdPb/HhrVcO7hftDDTa6Ivf8VhygV
         zYT2wAKPWZTlwaSOMHoTgc+0Ds3IOtsZe823PbdqC/ZytU6UZCucfxBpiXtxoHVJw9Nk
         pGaXtQOIXbfEt6GDSauFwDf8DnFn2HVx4NjifRnqW2BscLvu8RGaq1RkZn+PAVSUG1yn
         UgabdoqhuYNsW4wT9mH483cVT0UhHo4AmOtsiAbsMTgLCs8NNkxmzPOW0oUCMwTiCRlO
         5xKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W61e8Beb9C0rrwvWLXvghQlyTT+OB/E10KtzePQGPL4=;
        b=kXivjcC4Dma3/N2oHGU3Ji1oWVdNVIzQti3FDAsmlN0fyKH+A3uHjVYwuE+JGZT5Q0
         QZy8LfzWo0egavZCSTyxo/iIiNZhfjlJdxCviuuEWj7fEotZYDCXa2oO8owlG9Hs9UiU
         QXlaUGA/YlRW8zDx6AWbugif8s42TQbbz/js+8wcbLUHcv7T2vnrbN/VWFRL6Cy+TvUx
         9wYt5ECuJRpw15myGg1umlIW5RuvletNoUOZEqtS3UeuvoaMi5fUVMdpatteNoQfaKaD
         DSmfUauNVaflU/bSK1fJAYJ/I/e2J+4HJc35Z/4qhFHw1sv5+D+VrXMubo0JBG33anid
         pMdg==
X-Gm-Message-State: AOAM531rwyacpRryXYbi9/IW1X/CWy1PLIsvjDjboqzsbTwVsWwqmygL
        xUxjki7HMzkJbZwzg9wcOUuH8d9ysUh09nzSG5VR7A==
X-Google-Smtp-Source: ABdhPJxCJQhYe8mNvl+SI2wOrKJVTqqrGltMynBtx7qbJZ2lNzlNv9Ueg8nAxnwgbCGZ3s25dNuNfz9A2qGigUkeOiw=
X-Received: by 2002:a05:6808:a11:b0:325:e5c1:5912 with SMTP id
 n17-20020a0568080a1100b00325e5c15912mr3000582oij.204.1652287600719; Wed, 11
 May 2022 09:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220412195846.3692374-1-zhanwei@google.com> <YnmqgFkhqWklrQIw@google.com>
In-Reply-To: <YnmqgFkhqWklrQIw@google.com>
From:   Wei Zhang <zhanwei@google.com>
Date:   Wed, 11 May 2022 18:45:00 +0200
Message-ID: <CAN86XOYNpzEUN0aL9g=_GQFz5zdXX9Pvcs_TDmBVyJZDTfXREg@mail.gmail.com>
Subject: Re: [PATCH 0/2] KVM: x86: Fix incorrect VM-exit profiling
To:     Sean Christopherson <seanjc@google.com>
Cc:     Suleiman Souhlal <suleiman@google.com>,
        Sangwhan Moon <sxm@google.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, the profiling is about finding out which instructions in the
guest trigger VM exits and the corresponding frequencies.

Basically this will give a histogram array in /proc/profile. So if
'array[A] == T', we know that the instruction at (_stext + A) triggers
VM exits T times. readprofile command could read the information and
show a summary.




On Tue, May 10, 2022 at 1:57 AM Sean Christopherson <seanjc@google.com> wrote:
>
> On Tue, Apr 12, 2022, Wei Zhang wrote:
> > The profile=kvm boot option has been useful because it provides a
> > convenient approach to profile VM exits.
>
> What exactly are you profiling?  Where the guest executing at any given exit?  Mostly
> out of curiosity, but also in the hope that we might be able to replace profiling with
> a dedicated KVM stat(s).
