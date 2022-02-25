Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A999C4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 22:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiBYWKI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbiBYWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 17:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A2DDC527FC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645826971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PA9hg/jjTKbd4y1qX7Ux68wjGwVszX5ra4xkbOOiek=;
        b=SAXQnjTffBrkkXf84yXpQyobBf4trw+3AsaNsGw25gSPMtlAUJPCqhp5OxbNrxqJbjRxV9
        PAlouiSbsFde+PKZ0QF7zbVUA+wrcGdrTLxQTrfkzIE3ZeBrGTblDsI0aIbnul2mN5o4GR
        lvLvgVcH5f2Szi6qGFyTstJD7QCnAwc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-iuDZjiEqMji-2MWTP5Ikgg-1; Fri, 25 Feb 2022 17:09:30 -0500
X-MC-Unique: iuDZjiEqMji-2MWTP5Ikgg-1
Received: by mail-wm1-f70.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so1190943wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 14:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5PA9hg/jjTKbd4y1qX7Ux68wjGwVszX5ra4xkbOOiek=;
        b=lYUUdjtPBUo3R351Vmj3D5KmahAWqKiuJC86ZXU9g2GjNhHMiba+y0R5b9WM6DoFfR
         cKguaP1Kyjb2NYNFIUBT/m2jsjx9sUIQNguqmcEkuF2ZAZgI77x9M1fP8yyQgTSgItOD
         SdVjl/o5erVoSzHLMgl+LCMXQUzmeaijZQnLRHUPByxmztrHYlKlIdmmS9LaWpbB7kry
         ehO0Qbw4cOwdzKxCvXUBw0+plkhmXU5VwcDm9/sMkzVERUosTPwegg/CXh9dXSsVuifb
         td8cHOMqyXQIZBXI7p0Pix2W2tdXQN8cOMfDAkY/uHCLt5t3evXOouN2HsGRkjgfYghO
         zusw==
X-Gm-Message-State: AOAM531Ar8jnLTNt5It+xFlzZiwYrmFAltuNK21Ffiag162asbfaZR/6
        lOz+sOs1tYTsSQ9a3vHwiE5bPtJj9Ue/O3Vkrl8U1vqEZRDFtOX1kBOKI+8CuziMsc6+dMSwA3/
        /TSJ06w7oofr9Clbd/61FKYuc
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr4329871wmq.20.1645826969212;
        Fri, 25 Feb 2022 14:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRz8kqXC26lmDuZDgPn8lbcKVBuJ71tDPuJGSpWOnTZ7pH1GMfhj1Tg6aY60ZvqiZQtVKhzw==
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr4329851wmq.20.1645826969002;
        Fri, 25 Feb 2022 14:09:29 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b0037df2e5d8c9sm4311870wmg.27.2022.02.25.14.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 14:09:28 -0800 (PST)
Message-ID: <b87cf8eb-a27f-5060-7941-3b374c2792dd@redhat.com>
Date:   Fri, 25 Feb 2022 23:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/3] sysfb: Make config option dependencies explicit
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
        linux-efi@vger.kernel.org
References: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
 <a0fa41e9186653e4c41ad0a28259e5cdc71b1f66.1645822213.git.msuchanek@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a0fa41e9186653e4c41ad0a28259e5cdc71b1f66.1645822213.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Michal,

On 2/25/22 21:51, Michal Suchanek wrote:
> efifb and vesafb requires sysfb implicitly but this is not stated in
> Kconfig. Add the dependency.
> 
> With that all drivers that require sysfb depend on it so it can default
> to disabled.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---

Thanks for the patch. This makes much more sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

