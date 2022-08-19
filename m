Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C931C32773
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235346AbiHSVyz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHSVyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 17:54:53 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0419DB56E5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:54:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so3911565otr.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 14:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jp2q8+wHvNQOixYx4PKbIaPjNkYkkJRhsagfB6IVqbE=;
        b=PPmhQwtBns0UgyOPryIOLzd4HAKVCFqN2ePPjyg7KUrvexio/mO780s7hYZIdav8VA
         ofv2yYu2kRM+d/fARgdaREQW7gT9+hs6/1Us91wLeLXSq+JlkqFNbn9LhJMcAqIAm7iQ
         ZglsA+78ZnGHsi+8z0ttBhHa5hOMdyYde/NX3WbqBrQHGODkF1XkeiQ12wY2kPembcvs
         SGgtXPK7Hh7JuEeoYMChxK6LpZKvHsTgLvwW73cWebWTSZKtIgZL7oMi3hYS2K0PEYLM
         AeZDsZbGMcfy7iEXTGjiNJ4HJKs7Z/Adt6IJAj6CagE1KCbiVRYrHT229QRx5Z5dTeGh
         YNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jp2q8+wHvNQOixYx4PKbIaPjNkYkkJRhsagfB6IVqbE=;
        b=BOqPSyC8pwaNfTYcGKz6Ca2D9FLR9co4gGeJHaamdxhFDL0kBUNa38nhxKk30DCq8s
         3Pr1QmMl+f8zd/D/leWt2aYJKpaiiq75z/W2Yd36KEcXVYgstzhjbYR0iox7alp/IdMX
         fBTeeCIfUqo8mA8aqXLu7BSHanyqbsBkvbjFnhPt0HRCWiMmpGRv0I5RwlQlub+ZT4Rq
         9B0bEannsI09kJoh38cczpP07nOUJwMR0PcIkkP8Gk6FQ36RwKikS4/DSLZCHDxYeZwa
         As2PXBUaMiM/1RSfn4uvLA8SjCONRYjedK+yMu49HjCWgRRxqF3qWp+GHeXVsshtMPLp
         6itw==
X-Gm-Message-State: ACgBeo1IzJgWZaMCgHEJ7HDnFLclLru8oLGl40NNWcTHRzu+erRhXH7P
        EncTOkRlT0cbVKWy/zVvKB36cSYowlK67wtLN873Dg==
X-Google-Smtp-Source: AA6agR4rsEZSBZHJ576KM0RJSQEpFJQ4IgGAUraiyLdVIuJPldc8K5JN4kYfaEyq0cRE7jjJz84VRGu2osNPD6CKYRw=
X-Received: by 2002:a05:6830:2a8e:b0:638:c41c:d5a1 with SMTP id
 s14-20020a0568302a8e00b00638c41cd5a1mr3877418otu.367.1660946091212; Fri, 19
 Aug 2022 14:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220819182258.588335-1-vipinsh@google.com>
In-Reply-To: <20220819182258.588335-1-vipinsh@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 19 Aug 2022 14:54:40 -0700
Message-ID: <CALMp9eR1HYE6vWcqz3q=fAJnghdehpkaTuxhU8YjeQ8C6JofoA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Fix mce_banks memory leak on mci_ctl2_banks
 allocation failure
To:     Vipin Sharma <vipinsh@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 11:23 AM Vipin Sharma <vipinsh@google.com> wrote:
>
> If mci_ctl2_banks allocation fails, kvm goes to fail_free_pio_data and
> forgets about freeing mce_banks memory causing memory leak.
>
> Individually check memory allocation status and free memory in the correct
> order.
>
> Fixes: 281b52780b57 ("KVM: x86: Add emulation for MSR_IA32_MCx_CTL2 MSRs.")
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
Reviewed-by: Jim Mattson <jmattson@google.com>
