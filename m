Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17FDC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jun 2022 05:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237636AbiFNFPy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jun 2022 01:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiFNFPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:15:53 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699F818383;
        Mon, 13 Jun 2022 22:15:52 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id n185so4001272wmn.4;
        Mon, 13 Jun 2022 22:15:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BKPCEej7XNpKZCmWUzCvozlUOdtWySqWwvAYCO0M4ug=;
        b=GfCawZYyLSZcNEaa6FkhKokBg4n6tSFGhDXfVAuFYecVaM4Q1fYLt9Rkp6pJQBBSt6
         T+rzaX1zKeupHqjmLA2DVR4pCmvYlvSWT3d/5tAyDaXVDnbyUBVTjmEk7l5ZdrIzTtV5
         XUIaRn43WP46OtZxDygBJ9t8uRktz9cN7ehYFTf07B3BTPSKUL7ra7zld3hkWCIYd4A8
         XbUodL+FVKKvwhOZ2iZiWZvFabOyeAqIseGLtZt6LPFpGwu2gSoiXssxHIkJIlskmRQX
         kM64KiKzMJytz5fD28WuXXC1RXB+x2MEN0zcZ3kbmFUSfBFZzJHpKtsWqdoGoZk3q0ej
         NUjQ==
X-Gm-Message-State: AOAM533H/bvL59A/fzhevNt4JaZvXR059Mq+nbZDXnKllhTzYD9kvB/H
        oQGSke3mKu3jlfUjnRcx8e1BDdADKEhCdA==
X-Google-Smtp-Source: ABdhPJwUBl/sB3fsDVIR+RwP9lapXhzMNi9BnuL0kim5pq2+MZneitk7qs+SsvWOlrYy9e99M78qvQ==
X-Received: by 2002:a05:600c:3510:b0:39c:7fe7:cbd3 with SMTP id h16-20020a05600c351000b0039c7fe7cbd3mr2143641wmq.191.1655183750835;
        Mon, 13 Jun 2022 22:15:50 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id ay4-20020a5d6f04000000b00219b391c2d2sm12741996wrb.36.2022.06.13.22.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jun 2022 22:15:49 -0700 (PDT)
Message-ID: <297b268a-85de-bc8c-88eb-b8d050ac1ec3@kernel.org>
Date:   Tue, 14 Jun 2022 07:15:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [BUG] rockpro64 board hangs in console_init() after commit
 10e14073107d
Content-Language: en-US
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        sunjunchao2870@gmail.com, jack@suse.cz, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, senozhatsky@chromium.org, rostedt@goodmis.org,
        john.ogness@linutronix.de, keescook@chromium.org, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, maco@android.com, hch@lst.de,
        gregkh@linuxfoundation.org
References: <Yqdry+IghSWnJ6pe@monolith.localdoman>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <Yqdry+IghSWnJ6pe@monolith.localdoman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 06. 22, 18:54, Alexandru Elisei wrote:
> I've booted a kernel compiled with CONFIG_PROVE_LOCKING=y, as the offending
> commit fiddles with locks, but no splat was produced that would explain the
> hang.

It's too early for lockdep. Could you try to move lockdep_init() before 
console_init() in start_kernel()?

You'd need to use early console (which you already do).

thanks,
-- 
js
suse labs
