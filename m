Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ECAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 08:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiBVIAh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 03:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiBVIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:00:36 -0500
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C64A148910
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:00:11 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id p14so40163344ejf.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 00:00:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WVascUIens96/MVKuj9saTVjdfhsn9/8jgQmp41ig3k=;
        b=d2gaokrDH3x1w4wUa5kkMg5hd0BFIBQCCuPFNTQOa/kfjKF3Z9gd9BUTLaNr4xd6hE
         w//nJ+JTeUft3mPJKx7jGfLeENuSYngymtRb2/DxaMsT9uMdYtpYA33X1jLA0YoENc/A
         GYCae23+37VcaLKORgWKlGJGVTHObf/CZVKj7mzqhXPkETFyGO+WR3zUvzZJLFLlgFpc
         kav6wjvJR3RyWbtRZI1RN+8In+MF2vMWm8pJQ2JAhHfbUML9kVJioQ3ZQIq+gCMNt9WJ
         I2tOeuykYJIkQrW9yIbxy2OLG2Hp0yy2hGGKzp4qgalUy/FEqHgpbjHjESExUiqOsNxy
         twpA==
X-Gm-Message-State: AOAM533zQ4LcMjvSJkiVgH6sIzTktQajzKZsOpaKmd+rXdmZrrZ526OF
        lqrQzKL8FxrZr8QneaM4jkqXR3x2E0w=
X-Google-Smtp-Source: ABdhPJzPve49HQ8hUQwZmUkb2OrOaX8S0eBecO5YlcOJ+bbS+44eKsQY6tQVQ6sWAYn8r/GK/eOq8Q==
X-Received: by 2002:a17:906:d968:b0:6d0:fc05:bdc3 with SMTP id rp8-20020a170906d96800b006d0fc05bdc3mr10334065ejb.719.1645516809946;
        Tue, 22 Feb 2022 00:00:09 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id f1sm2612685ejq.74.2022.02.22.00.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 00:00:09 -0800 (PST)
Message-ID: <d83ae2d5-ac46-a3b8-ee9a-12615a48e9d9@kernel.org>
Date:   Tue, 22 Feb 2022 09:00:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v1] vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE
Content-Language: en-US
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220222073954.20212-1-xiam0nd.tong@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220222073954.20212-1-xiam0nd.tong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 22, 8:39, Xiaomeng Tong wrote:
> In VT_ACTIVATE an almost identical code path has been patched
> with array_index_nospec. In the VT_DISALLOCATE path, the arg is
> the user input from a system call argument and lately used as a index
> for vc_cons[index].d access, which can be reached through path like
> vt_disallocate->vc_busy or vt_disallocate->vc_deallocate.
> For consistency both code paths should have the same mitigations
> applied. Also, the code style is adjusted as suggested by Jiri.
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vt/vt_ioctl.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 580136986..8c685b501 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -898,11 +898,13 @@ int vt_ioctl(struct tty_struct *tty,
>   		if (arg > MAX_NR_CONSOLES)
>   			return -ENXIO;
>   
> -		if (arg == 0)
> +		if (arg == 0) {
>   			vt_disallocate_all();
> -		else
> -			return vt_disallocate(--arg);
> -		break;
> +			break;
> +		}
> +
> +		arg = array_index_nospec(arg - 1, MAX_NR_CONSOLES);
> +		return vt_disallocate(arg);
>   
>   	case VT_RESIZE:
>   	{


-- 
js
suse labs
