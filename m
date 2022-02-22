Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E11FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 06:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiBVG4q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 01:56:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiBVG4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 01:56:41 -0500
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DB8111DDE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:56:16 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id w3so34524179edu.8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 22:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=jQN5YzYRBcWg2FYiwHk5tUXo/roFvACWKbFSOX5eYcc=;
        b=iQj+0CxSiSC3e4CZTsrswjXbWs9TgMN1/Vu6SGjHBMdxsDmdeKIYpSrfsdLlaLXAqV
         4gDdVof5f1ML4M91fBbjXfGIEV85PLbFvlEZySVOFjAQp21Hl27HeQ5AFEhPEPeixcXi
         WpQIyUdEagWwQwb3TrODOb6oDpUrELg+Rw9yo/VANBxPjql6wtTkpQvaKVi4S+fHdIoU
         s92I1CqJ2/Np6ME/oegbi9gINDEbetrWwRjx/u3x8qTZFsU1kQui9Ck+jBwO+3hXowW5
         xcRExot0tMmdxEriWM1XFbsScvxn3BYqpu9309QccGQJGzfiS54cndJ0lDWg/kdH4znc
         jtyg==
X-Gm-Message-State: AOAM5313hGpyCahXZ6+7vehiG6GWAhxO4aOXEOk7MP1ZPEm3/y8P703O
        DNblVg4DzCX8X+nDgIiftwpXkYO16GQ=
X-Google-Smtp-Source: ABdhPJxK8It0M/9Z+Gv64THfgyw4MMF6GfCOFrIXuaJJN/2Cty5dwWnr/scd9Ighb0BBZ0q6hKBx7g==
X-Received: by 2002:a50:f69c:0:b0:410:8241:580c with SMTP id d28-20020a50f69c000000b004108241580cmr24478799edn.100.1645512975162;
        Mon, 21 Feb 2022 22:56:15 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id m28sm5941827ejn.50.2022.02.21.22.56.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Feb 2022 22:56:14 -0800 (PST)
Message-ID: <e0071c1e-cc20-e000-0673-f98e6f8fc316@kernel.org>
Date:   Tue, 22 Feb 2022 07:56:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] vt_ioctl: fix potential spectre v1 in VT_DISALLOCATE
Content-Language: en-US
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220222035648.17984-1-xiam0nd.tong@gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220222035648.17984-1-xiam0nd.tong@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 02. 22, 4:56, Xiaomeng Tong wrote:
> In VT_ACTIVATE an almost identical code path has been patched
> with array_index_nospec. In the VT_DISALLOCATE path, the arg is
> the user input from a system call argument and lately used as a index
> for vc_cons[index].d access, which can be reached through path like
> vt_disallocate->vc_busy or vt_disallocate->vc_deallocate.
> For consistency both code paths should have the same mitigations
> applied.
> 
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> ---
>   drivers/tty/vt/vt_ioctl.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
> index 580136986..acd53c1c9 100644
> --- a/drivers/tty/vt/vt_ioctl.c
> +++ b/drivers/tty/vt/vt_ioctl.c
> @@ -898,10 +898,13 @@ int vt_ioctl(struct tty_struct *tty,
>   		if (arg > MAX_NR_CONSOLES)
>   			return -ENXIO;
>   
> -		if (arg == 0)
> +		if (arg == 0) {
>   			vt_disallocate_all();

Could you add a break; here and remove the else branching completely?

> -		else
> -			return vt_disallocate(--arg);
> +		} else {
> +			--arg;
> +			arg = array_index_nospec(arg, MAX_NR_CONSOLES);
You could simply do:
   arg = array_index_nospec(arg - 1, MAX_NR_CONSOLES);
and remove
   --arg;
completely.

> +			return vt_disallocate(arg);
> +		}
>   		break;

When you do the above, this break is superfluous.

thanks,
-- 
js
suse labs
