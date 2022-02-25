Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB15FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 00:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiBYAyi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiBYAyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:54:37 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887CB150415
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:54:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id d15so104188pjg.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=arleATP5kW7wyYGHooV473HnyxLZGbKklPsBufv8eRI=;
        b=bR3EbXpzYvJ6cwg3PLr2AUkX1uESfQTkRVu9vmdx1aQtJDsldu+Ap5dY07ATI/jVER
         sYElMIQIXlyfEuN8+fR6wxCgui7KN47EQF9ugdjgNSX40RqGJ6Pym/coO69vn7mMswWK
         m6Q1x75EGHqdSrDqWOfVb0bZKuXekoUdvgFP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=arleATP5kW7wyYGHooV473HnyxLZGbKklPsBufv8eRI=;
        b=WHoHfQ09UcC0OKgVRyrzuNdy5oajdP9/lKHh0AhRC6Jc4FJ/zR56rvet+dvg284ein
         xbH9SStJY9l8RuYzI9lrJ6e78hc/SNDaJbG7Y3wnWAM9dZEWZtyN/90rzIPeUNdhIvYL
         xTyYDPrwe91+yEd2d/7kQezaOBim3LihJ5+e512bxND/qZN1gDj4fBt5owoI8q5RF4S9
         s6EO21YQY5OEu2EteeKAP1wXLTyPMznf6BKCuzgnq0hdb7lgmBW4NUpIcYZ0lZ1RaXK3
         qCEO+nr9pnuOk2mBhEGOtxsgSSf3AadEyXvm0ltausMpz7T1UBJ9w7rbMQ7cx1xmXfjM
         quOg==
X-Gm-Message-State: AOAM532c8Od1evsNtmiCfIl1n7/499fpYAi6a+U9LWcAR4nFE2VtgUJ8
        OX/lM/3VYJC91xMXYVqidahEvw==
X-Google-Smtp-Source: ABdhPJxjDUQU4W1vH85mj/uxM4etnm6FLc/dttTyz80ozroHUMPQ3vkX6egkTBJzanvPc+qufEBOuw==
X-Received: by 2002:a17:90a:2d6:b0:1b8:cd70:697d with SMTP id d22-20020a17090a02d600b001b8cd70697dmr720816pjd.78.1645750445691;
        Thu, 24 Feb 2022 16:54:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o17-20020a056a0015d100b004e1c11d833fsm728217pfu.90.2022.02.24.16.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 16:54:05 -0800 (PST)
Date:   Thu, 24 Feb 2022 16:54:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 11/39] x86/ibt,kvm: Add ENDBR to fastops
Message-ID: <202202241651.B5FB7DBE@keescook>
References: <20220224145138.952963315@infradead.org>
 <20220224151322.656194153@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224151322.656194153@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 03:51:49PM +0100, Peter Zijlstra wrote:
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kvm/emulate.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -189,7 +189,7 @@
>  #define X16(x...) X8(x), X8(x)
>  
>  #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
> -#define FASTOP_SIZE 8
> +#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))

Err, is this right? FASTOP_SIZE is used both as a size and an alignment.
But the ENDBR instruction is 4 bytes? Commit log maybe needed to
describe this.

-- 
Kees Cook
