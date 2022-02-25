Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBFCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 22:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiBYWLb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:11:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiBYWL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A93052E0A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645827056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAHJITj5STzbbuF37W0DjncfQl4DVrBRuJjULvPB2II=;
        b=KakMYWeBJKAPIieALCo6RK6sFeEvcMCQaxPP7QjBZbaI0yCYvE0Z0m19SLOWMBIWotiP6b
        CuKxh9ghaQhVsdisCARimP8Vt3C1EjYUuVe4SQ38XANZWXusacJSr39DkPfr0zGxwvQ2Hv
        UKgCVFVBy6kzGXqmtu9IzsIC+VnuERA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-605-5ppZIqezMWOFy4h-DMrPGQ-1; Fri, 25 Feb 2022 17:10:55 -0500
X-MC-Unique: 5ppZIqezMWOFy4h-DMrPGQ-1
Received: by mail-wm1-f69.google.com with SMTP id r206-20020a1c44d7000000b00380e36c6d34so2241244wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:10:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WAHJITj5STzbbuF37W0DjncfQl4DVrBRuJjULvPB2II=;
        b=l+Y785QS032tE31D9nsbA1g7U7iBj0JklzyZGj7axLBeMYu8ach/1MGwVT4/RA7ULe
         i47WoIdgNamAMZUhdNiQMcStCdWySn5jn8mO3p6gDwDXHVAmLhpptKTgoaiOkmLi96Bm
         mjU8Rdq/Cfq1y6hjReLaXHxsYLL8AOAIoHZKmMAu5KThwJiPZi3uV+1lUfvRwAioJtOl
         GOw7nx4G/vPbJ62HDhhkYn7EA6Eb31H+BoPmKk3cRrJW3O4Iaq9wQmptBKEJfMTkuXDd
         DxZnSJTYy8nUCFCARuZdni0cIuu2GXwq5kJoOy3t9oXo4k2p4RihZgOAg9CVSJCKgSuA
         S7VA==
X-Gm-Message-State: AOAM530BLYKy2JGjatbqExgm1pnb/yS04AeO7halNZUokyym0ljqEV+r
        4f4tz7PXVywmXuqV3peKjKs7trw+DP7sVqzN5ykyHhzdG592v16kRiaduxDteHMhEVBdxvsGw8Y
        wvBFCN0q9oIX2fVZDQodZdBd1
X-Received: by 2002:a05:600c:1592:b0:381:21b4:d1d8 with SMTP id r18-20020a05600c159200b0038121b4d1d8mr4424288wmf.119.1645827053955;
        Fri, 25 Feb 2022 14:10:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAHm39sLaSq2pOYdrWxQg66pEwR/Bg1+VCOw5sY82fSKXIkbndkrbvrCZ8Q8iJZV1EJ/AdAQ==
X-Received: by 2002:a05:600c:1592:b0:381:21b4:d1d8 with SMTP id r18-20020a05600c159200b0038121b4d1d8mr4424269wmf.119.1645827053705;
        Fri, 25 Feb 2022 14:10:53 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x3-20020adfdd83000000b001e58c8de11bsm3544558wrl.39.2022.02.25.14.10.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 14:10:53 -0800 (PST)
Message-ID: <ae441f09-3d63-a731-fe59-06b8aafa0983@redhat.com>
Date:   Fri, 25 Feb 2022 23:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/3] sysfb: Enable boot time VESA graphic mode
 selection
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz,
        linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>
References: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
 <948c39940a4e99f5b43bdbcbe537faae71a43e1d.1645822213.git.msuchanek@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <948c39940a4e99f5b43bdbcbe537faae71a43e1d.1645822213.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/22 21:51, Michal Suchanek wrote:
> Since switch to simplefb/simpledrm VESA graphic mode selection with vga=
> kernel parameter is no longer available with legacy BIOS.
> 
> The x86 realmode boot code enables the VESA graphic modes when option
> FB_BOOT_VESA_SUPPORT is enabled.
> 
> This option is selected by vesafb but not simplefb/simpledrm.
> 
> To enable use of VESA modes with simplefb in legacy BIOS boot mode drop
> dependency of BOOT_VESA_SUPPORT on FB, also drop the FB_ prefix. Select
> the option from sysfb rather than the drivers that depend on it.
> 
> The BOOT_VESA_SUPPORT is not specific to framebuffer but rather to x86
> platform, move it from fbdev to x86 Kconfig.
> 
> Fixes: e3263ab389a7 ("x86: provide platform-devices for boot-framebuffers")
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> Acked-by: Borislav Petkov <bp@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

