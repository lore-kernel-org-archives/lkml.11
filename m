Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F239C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 12:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348292AbiCOMiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 08:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348211AbiCOMhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 08:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9408A53B4A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647347793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=meH+qCfj6lH9OjS/cwuXTPPvOKgAu1/eJ1NA4WtkLWw=;
        b=XhNkYtxDs/rmrIQunN/OjYQDceUHOKaqqboWz6KTZh0ESrW2l0qqXr4WC9siLa6QwH8cxt
        Rozx3CW0JdNmaFKaQjnvo7+VGs9ml/xeIwdyEN4vyPqU1oMXUnm2IRArf36z0X2Btv1Pqh
        l2Ofs1GxhMnKLVMjG7BwnIAyCAFBPX4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-168-KND9RVyQPuSbX0xDbIJzlg-1; Tue, 15 Mar 2022 08:36:32 -0400
X-MC-Unique: KND9RVyQPuSbX0xDbIJzlg-1
Received: by mail-wm1-f71.google.com with SMTP id c62-20020a1c3541000000b003815245c642so1175890wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 05:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=meH+qCfj6lH9OjS/cwuXTPPvOKgAu1/eJ1NA4WtkLWw=;
        b=sCl3CZuQYBu/8N6VzgTwGzhtEDQ4MpzCL2pPqjNbSiwth4ChrigW3oBKeVBaYYNcxN
         UKUQUCjh7PT83QdHOqDFFoajmqQ7AMAzDtYZAqFCx5STN6cWdl1GZUcdCDhry1PBopzy
         b052gTOu8rdopuPBMffSwGAntXftsWksCpc20YxUHC3kbCYC5nP8LDlve4UwJdWDoGUD
         06h0ye8D0Fk67q75M6t8vk/24O+cIFsV211rfyoC6BSJ9JckGJFzgjhZdDyB9SipFXgg
         LDS65noUofCiNBi+O5ti31K73MeVkX12n787KAJ7Jpo5Dn/pjPFD+WSygH5VRiPZKb0G
         2VLg==
X-Gm-Message-State: AOAM531IEE0W7EZbUEgVtVBKttKTBDL4sofKZAtdomFo+G3zE4QD8Xaz
        NYbsJTHVprhQJlmZq5XU2toIkO8eSeb5X52B4KjvgxHB7fAwfXSO77+PBBODtiqLUUbBblO9x3Q
        Exs4O3hEdJH66NhNtwSp1OHYi
X-Received: by 2002:a5d:5848:0:b0:203:a65d:1f49 with SMTP id i8-20020a5d5848000000b00203a65d1f49mr9962619wrf.397.1647347791478;
        Tue, 15 Mar 2022 05:36:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwxs66bOxh/TumvNSO4GmYvVoUpKAXWPE2kOcJ3ObbpEpN4Okx+fZPk6CJYHBO98nKh9ymjiA==
X-Received: by 2002:a5d:5848:0:b0:203:a65d:1f49 with SMTP id i8-20020a5d5848000000b00203a65d1f49mr9962610wrf.397.1647347791249;
        Tue, 15 Mar 2022 05:36:31 -0700 (PDT)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d5407000000b001f0be7a7578sm15371811wrv.5.2022.03.15.05.36.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 05:36:30 -0700 (PDT)
Message-ID: <fcdcd046-63f5-495d-b5ad-f407592f2160@redhat.com>
Date:   Tue, 15 Mar 2022 13:36:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 5/5] drm/repaper: Reduce temporary buffer size in
 repaper_fb_dirty()
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20220315110707.628166-1-geert@linux-m68k.org>
 <20220315110707.628166-6-geert@linux-m68k.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220315110707.628166-6-geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 12:07, Geert Uytterhoeven wrote:
> As the temporary buffer is no longer used to store 8-bit grayscale data,
> its size can be reduced to the size needed to store the monochrome
> bitmap data.
> 
> Fixes: 24c6bedefbe71de9 ("drm/repaper: Use format helper for xrgb8888 to monochrome conversion")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Untested due to lack of hardware.
> 

Patch looks good to me but I also don't have this hardware.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

