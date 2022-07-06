Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A9AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 23:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbiGFXwE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiGFXwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:52:02 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3A92D1E5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:52:02 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id i126so21671957oih.4
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BL7W23oHq0JL/M8TNGzxaqsF4OCN+5iCjxJ+fwRF/M8=;
        b=W7Bxxt3rS48fnDgjqLePmCkjfVy8mPWiRP1Ek/okWVaAlUCn9Beu2Yhhpq72FX22vI
         2clQpJeMjPH/7FGZvt/ndKFWuhQAp2+/Rdk+EBYzZwwF26S9vXx0yJPTmat8wT8VtZ6x
         MSIy3jbrFXJEuTg8x394WsVqxD3/olXhh5Hw19OancK78mDmiOxvuSoXhPhHZaMo3lSa
         fx91Gj1tf35/hxtpIRDHBpqSRJbvJlebuNDuE6RBjb2poG9ivmkGPHEIFSlscl4uJklc
         6SA3V8WcYy35GE5a9VgfKvV9f1/fsFP2re5yYG11rwR4X97SI/LY5CBo+ezoqqpjwwnD
         I6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BL7W23oHq0JL/M8TNGzxaqsF4OCN+5iCjxJ+fwRF/M8=;
        b=b5foPeuTXOD9bE7nuhvWe+GalMFfBqTMKsJigg8CdBs0Qhi4JsXI5aQq+9PzWtTjo4
         Iok9M8dUogmniGpqD/lzsl3iDtJhbym+mtlGuL5hh0FLvi9oFXPQOTAwTKNbZ02q49Mj
         BrfYF5/wfkxkP1k8AaXOfSrpZUAvt6m3QYDoJEyIkFh8kxuZZoOKdpHekzsOcTJy0f2I
         s0yeGyr9QqAn1qsPHXwB7XpWrvXOv67MBkXiNmuM/KfqSul5EAAo5IrtPFgKtApvoEdT
         3sQmgsUFLAZ4XnKhzpQ4fuJU/8R1LANfONUAXzLrAGJfFUbzPofFpBYW5LIsBgttSJ5W
         AMew==
X-Gm-Message-State: AJIora/06+klM/bcFPz6x07iOJy7+CJOeUbB1d1Qjcd1AQB80wRmFGWv
        IuTibQbQCFoG+RI90ED51R/fTwBiJkEs1GElOOgPu1Gumfs=
X-Google-Smtp-Source: AGRyM1uu9XjOrKLX28cVqi4dnKMz2RP55IVUsLf3ms+qDAp/4RaMrlk+119BjbDPEHCq2pfyEQKg2yD6xs8AXxbxhNc=
X-Received: by 2002:a05:6808:2124:b0:335:7483:f62d with SMTP id
 r36-20020a056808212400b003357483f62dmr764472oiw.112.1657151521323; Wed, 06
 Jul 2022 16:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com> <20220614204730.3359543-6-seanjc@google.com>
In-Reply-To: <20220614204730.3359543-6-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 6 Jul 2022 16:51:50 -0700
Message-ID: <CALMp9eSH1O8keAVxZzfdvV1vu0AJBhaXVUfkSgYgCPOoSB5=Jw@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] KVM: nVMX: Prioritize TSS T-flag #DBs over
 Monitor Trap Flag
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 1:47 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Service TSS T-flag #DBs prior to pending MTFs, as such #DBs are higher
> priority than MTF.  KVM itself doesn't emulate TSS #DBs, and any such

Is there a KVM erratum for that?

> exceptions injected from L1 will be handled by hardware (or morphed to
> a fault-like exception if injection fails), but theoretically userspace
> could pend a TSS T-flag #DB in conjunction with a pending MTF.
>
> Note, there's no known use case this fixes, it's purely to be technically
> correct with respect to Intel's SDM.

A test would be nice. :-)
