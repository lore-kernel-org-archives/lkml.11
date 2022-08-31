Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B57ECAAD4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Aug 2022 00:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiHaA3G (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Aug 2022 20:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbiHaA3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 20:29:03 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F33C4DF02
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:29:02 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so19898887fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 17:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hQSQ2t7pP/IrhN8cc8IxfDAA5qJwx3EBn20OUJ8e824=;
        b=gXU09nL1FZDT/NiNH6BzjQIvxgEpNbKmNOuJ5Y9ld61xdcnMk4bZ2Y4wwtZOjc4IjS
         b/CadcuFLNoAhYpOGE/9v67ayb1O3nUZOvZ+HK2hQYazfOys+qjx3WrPe8BRwVyO2T/2
         Z7a1yEKJRrIkSy0nKsDiHG3R43qGjMVKaHI7PuHcTYnzf+WwVn1bNkibxIx+0sB2EqUD
         PuluCgxx/6Bj40MH/9US67dBJz8llTLfFgZaC9wDsmrBn0xKIZAF7XKYu1lqLs9M3KPA
         lxYBphTghIeUQ+sqichlfd839bOOVt8nmmc86SAnEYCrksVFmqaczDCiiZ6z1lbOY7yU
         RzMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hQSQ2t7pP/IrhN8cc8IxfDAA5qJwx3EBn20OUJ8e824=;
        b=JjeiYeKxva6+YeeyvvYBN7nTcoK3gzPUOubl54Rm9Nwe8yfx+ee7OCsA8FfB7ITsO6
         XUz7weNX1Au6cCQc6jkBCz42jmClauI+oEP+7CZGJADZjUEcdkOGKWjlawk6jug46RLt
         79sBcdHZIP/ecnFWaf3CvHxWBBr+fvVB4nD7PvBR+vsDmz5aFmMavK6HtRRidPrVl66I
         dFG7oMMACa3+Jyz7WTdib1MTCUyodW7xRg4d4PPkvDgPKj35IDcjSHJRKlLUfUoCf5wI
         rNhv9MzE/bgsq0XdcfMfsNIVaFV5OTa5+ybqYW9LrIL21yGALWx7jEw3AhdvxaYsGQ0p
         rPkw==
X-Gm-Message-State: ACgBeo2j+X8y2bqAwo+F0dpf3RTQCTL5uW+TsUhZqxYKUI1LPeMUroJ3
        sz5CONwpt0o8AK4YqwLXfsKX63xqvp/jlAgWj5CgCQ==
X-Google-Smtp-Source: AA6agR4/a4IL9f29Af20SDpmYJsn+mOKbowLXYovGrFOJDBUWqoq7xnux+Mj/PtmwXhdYMdOLqvNOZX0OVmTqZbJj1c=
X-Received: by 2002:aca:170f:0:b0:343:171f:3596 with SMTP id
 j15-20020aca170f000000b00343171f3596mr221718oii.181.1661905741375; Tue, 30
 Aug 2022 17:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220831000721.4066617-1-seanjc@google.com>
In-Reply-To: <20220831000721.4066617-1-seanjc@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 30 Aug 2022 17:28:50 -0700
Message-ID: <CALMp9eToxFXZVz=8ZXWdrZAdQRn9V54g0VEaKDmmpqvPrYXQoA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Reword comments about generating nested CR0/4
 read shadows
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 5:07 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Reword the comments that (attempt to) document nVMX's overrides of the
> CR0/4 read shadows for L2 after calling vmx_set_cr0/4().  The important
> behavior that needs to be documented is that KVM needs to override the
> shadows to account for L1's masks even though the shadows are set by the
> common helpers (and that setting the shadows first would result in the
> correct shadows being clobbered).
>
> This also fixes a repeated "we we" reported by Jason.
>
> Cc: Jason Wang <wangborong@cdjrlc.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
