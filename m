Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AEBC43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 06:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbiGSGDe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 02:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiGSGDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:03:32 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115FA39BBB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:03:30 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id ss3so25163483ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 23:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w3KnyRzoVlmR1JYgtXnkig7qjIN2/mRzvIU/x6QrvF8=;
        b=QAuYcboAkd6cLBrAnN568ZNc9Yyb48DbIodEflHQPa5V02qpveLNLkB9s+b+B2mFtf
         tdGbndPRORRXc41pdI2U6oN27qA+EW1XH1Re/PB0wK6caucChVFXq9iLykmN78CFcLBz
         pPQdgl4Ar+HG1XuhycMFieLDqCUeZwHyDvXpNuSjq8Mz/WerKaun29Y4u8PwfBDV9OnB
         vE6Jnt8ckoCTjK/hXo7qg+ooQwluXw7sQHR0qCXwoOQG7+4BYaw2IdUhQoRcGuvk/ziM
         zWdxHKo2OOPI66ilvNJUvfIeq+VhzH9acE2q2hyqF0jW1C8rvLE8V3/MSnRBRrK/SNxT
         Xc7g==
X-Gm-Message-State: AJIora8KGtk4NfZARMgKssbpMRDdc7Nd+84oL4kod7ElrNt3hK7bFfuB
        O3h72x0yFaYPJu3gCYR4f4k=
X-Google-Smtp-Source: AGRyM1t0Geho1jRj6KPZ9jqaL04kQ3k1ocK8uTfDGHuVogn4GW9W1Z25iw+y+d3VecxZMKsejKvzxA==
X-Received: by 2002:a17:906:9bef:b0:72b:40d1:4276 with SMTP id de47-20020a1709069bef00b0072b40d14276mr28058657ejc.360.1658210608537;
        Mon, 18 Jul 2022 23:03:28 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id b6-20020aa7cd06000000b004355998ec1asm9848211edw.14.2022.07.18.23.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 23:03:27 -0700 (PDT)
Message-ID: <7026ec81-fa6e-a470-cd10-9894050e7f0d@kernel.org>
Date:   Tue, 19 Jul 2022 08:03:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] tty: vt: initialize unicode screen buffer
Content-Language: en-US
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <000000000000eca3eb0598e26a3d@google.com>
 <0000000000000bd4d405ae9d32a4@google.com>
 <4ef053cf-e796-fb5e-58b7-3ae58242a4ad@I-love.SAKURA.ne.jp>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <4ef053cf-e796-fb5e-58b7-3ae58242a4ad@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 07. 22, 7:49, Tetsuo Handa wrote:
> syzbot reports kernel infoleak at vcs_read() [1], for buffer can be read
> immediately after resize operation. Initialize buffer using kzalloc().
> 
>    ----------
>    #include <fcntl.h>
>    #include <unistd.h>
>    #include <sys/ioctl.h>
>    #include <linux/fb.h>
> 
>    int main(int argc, char *argv[])
>    {
>      struct fb_var_screeninfo var = { };
>      const int fb_fd = open("/dev/fb0", 3);
>      ioctl(fb_fd, FBIOGET_VSCREENINFO, &var);
>      var.yres = 0x21;
>      ioctl(fb_fd, FBIOPUT_VSCREENINFO, &var);
>      return read(open("/dev/vcsu", O_RDONLY), &var, sizeof(var)) == -1;
>    }
>    ----------
> 
> Link: https://syzkaller.appspot.com/bug?extid=31a641689d43387f05d3 [1]
> Reported-by: syzbot <syzbot+31a641689d43387f05d3@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Yes, it makes sense.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vt/vt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index f8c87c4d7399..6968517d6f8b 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -344,7 +344,7 @@ static struct uni_screen *vc_uniscr_alloc(unsigned int cols, unsigned int rows)
>   	/* allocate everything in one go */
>   	memsize = cols * rows * sizeof(char32_t);
>   	memsize += rows * sizeof(char32_t *);
> -	p = vmalloc(memsize);
> +	p = vzalloc(memsize);
>   	if (!p)
>   		return NULL;
>   

thanks,
-- 
js
suse labs
