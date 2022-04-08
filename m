Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75891C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 07:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiDHHq3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiDHHqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:46:25 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62469133643;
        Fri,  8 Apr 2022 00:44:23 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id f23so13688539ybj.7;
        Fri, 08 Apr 2022 00:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aYBkptFuu1L6fJBG8uYww/w9jLfAXvEZhU9BF3IYbwI=;
        b=HKeDspxMULemfn4t1aitwEvaiWMdbhpXh/45Y8asfvK3UjwqUW59sBrUXIHcMhjIgz
         WmgtAOXjlUsRjZ81/bWmD7dQuBDGb7c7V+C5iXGtIkO6I+uYTvno2gkFhW5xcgyjj8Kb
         GhD68ShqNFGkDlBvPwooQYegP4m6Cgxstps4HQTIMqSetEkbHkhofNsZldtuwC17w9pR
         qkbqn6qcBqbSKqnsqGg//IS58YIQPtfzBJ8leshVpCPJ1h+iFR19Y1c7/Qj1K8m1Mch1
         X/1eT/JGCoYZzBU9vRjQGJBWjk3Y5Xg3JN2ZrJ/SAMQqcE/8BTYuULtIJPDyTivyGgLB
         jtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aYBkptFuu1L6fJBG8uYww/w9jLfAXvEZhU9BF3IYbwI=;
        b=1QJSBY0QHPxH5Tj4CSmSfSMOc8+rnWdEpa+T+Fvwz2QmK2JqT3Ef1hsZz9rJPlPqBj
         sgTlSP6fga5g/c8pJOb28T30phZ4jVZe+o/7kccKL2rEBGyKtXIy6QwfuPNO1xgLYJVx
         YEuCtVHIdOgdqYg0zj4znPktf1ZnW5p9Nn+Qp9zxNvIlbHIN/1b+s/IdjT3WaHBiyt8P
         1m0qAOBX5qIVo6qFj7MXcSjCS0QTtGDul57Kq44a3jtf9Kl4pcoWRqhamnTFS+ZW8P7D
         +Du4eTXagbbMx02lAh+uHX/gzwpSs2PJrfE7iYQ2Rl7Qhg4Rv8UTPR9KumKzrTFlqhRW
         i8uA==
X-Gm-Message-State: AOAM530e3I1zAdnrHC2XXKvisJg/2uUyDnvpYc/PXjNqydZ955js8Otg
        aTF458HXCaE0MwXPvtPI7bURFF5UI4a+jLE/4zov+lQr
X-Google-Smtp-Source: ABdhPJx+RtkKNEaXE2TP5P6sQYsNmhufvjTOchmLl/QqIeKsHK8iv2GzLbYQsuwnTv95dG7FPIZFfP7yIyYQa5tnomk=
X-Received: by 2002:a5b:dcc:0:b0:628:d6d9:d4bc with SMTP id
 t12-20020a5b0dcc000000b00628d6d9d4bcmr12508904ybr.178.1649403862664; Fri, 08
 Apr 2022 00:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <1646727529-11774-1-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1646727529-11774-1-git-send-email-wanpengli@tencent.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Fri, 8 Apr 2022 15:44:11 +0800
Message-ID: <CANRm+Czsj0WiQ5GoQ4gZgBZFPpnOC6or_kULhcz7GQ2vhzpNSQ@mail.gmail.com>
Subject: Re: [PATCH] x86/kvm: Don't waste kvmclock memory if there is nopv parameter
To:     LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping,
On Tue, 8 Mar 2022 at 16:19, Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> When the "nopv" command line parameter is used, it should not waste
> memory for kvmclock.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kernel/kvmclock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index c5caa73..16333ba 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -239,7 +239,7 @@ static void __init kvmclock_init_mem(void)
>
>  static int __init kvm_setup_vsyscall_timeinfo(void)
>  {
> -       if (!kvm_para_available() || !kvmclock)
> +       if (!kvm_para_available() || !kvmclock || nopv)
>                 return 0;
>
>         kvmclock_init_mem();
> --
> 2.7.4
>
