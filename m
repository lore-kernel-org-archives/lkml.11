Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69265C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Feb 2022 22:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242124AbiBGWZs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Feb 2022 17:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiBGWZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 17:25:46 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D882C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 14:25:45 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id on2so5965109pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 14:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B5g+xuI8jcCep2WA/OfIWMR0EykCSB5BuBVfldu0iYA=;
        b=lt/FJuIFUUaYu1L/V/DMP/1iflPZ6kE53j+ZXZV9MkAp+26KonWOjOxUmaLVPNDNyj
         txrPpbHmjMPc8ks3LkD3LZmhJW7Y84n1Ehpek9BYTnLCUyndW0U/odLosP4jfLMQaspW
         CSJsAA46VfRGH/8x8huC+LVLRrNKLlY34lZcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B5g+xuI8jcCep2WA/OfIWMR0EykCSB5BuBVfldu0iYA=;
        b=SzxsbFTEvz1BjrehFMhIGl4yCP17u9C1GjWtWTlWlG7EOs2AUCYZqkvFp8qRT5mIMB
         ObV0fylCEtUNOiWk6oswNNlkCAyxQ9/lW9aJNqT7ywdukSs01pxmGXorpDaoVVwZPSWa
         MQ1u39XJlKYXK3/8tjU4tBgYWyzakqDBcFswsDK/cHbobT83y5VU23WIRvl++mMj4Qb+
         LFfCzBKJ4katqjeAXxjdJ/mv76TvyZwrJ3DU6Es9i4BSikpzufldl5Sk+G6m3dSzECl0
         ZsiBac/gLk/mJCwhwYG2+d3lrVYYL9DYzXYtWhlxiute8EVURTCoyoFGR5+1ghHjQ+dD
         X1tg==
X-Gm-Message-State: AOAM531MEaH4F8iQ5Ama7v0aVgR2cn4WN4lBBmJG5CEBYgJXJ2xISkZO
        tOF+zOUTCsOxcPaaaI/qjrJAqw==
X-Google-Smtp-Source: ABdhPJzr9bBEsUjHeMwrte7+9HYltTY+QTFQ0YIOiEN8nrDUjjyVOAsv6bQ++6nL6zXYXpwPIA9DIg==
X-Received: by 2002:a17:90a:ab90:: with SMTP id n16mr1111003pjq.229.1644272744959;
        Mon, 07 Feb 2022 14:25:44 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p17sm13266091pfh.59.2022.02.07.14.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 14:25:44 -0800 (PST)
Date:   Mon, 7 Feb 2022 14:25:44 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH v2 5/6] x86/cpu: Remove "noexec"
Message-ID: <202202071419.E21C67553@keescook>
References: <20220127115626.14179-1-bp@alien8.de>
 <20220127115626.14179-6-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127115626.14179-6-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 12:56:25PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> It doesn't make any sense to disable non-executable mappings -
> security-wise or else.
> 
> So rip out that switch and move the remaining code into setup.c and
> delete setup_nx.c
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>

I've dug through the nx fun again. The verify_cpu() calls are untouched
(which were the most fiddly part of all that a decade ago), so that's
good. The early handling of __supported_pte_mask in x86_configure_nx()
is untouched and the call is retained before the param processing for
the set_fixmap() dance, so everything I can remember as being "difficult"
with NX ordering here looks good.

Thanks for cleaning all this up!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
