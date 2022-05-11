Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16E7C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 10:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiEKKEJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 06:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbiEKKDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 06:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E8E75DA68
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652263412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/vtPNJw1+YnhXgRCJ8NELfFcD+FTH1I0JZLJZh7rb18=;
        b=JN+VbiMoZCOzR+ZMg7f4axfLqwA4zSa/U2pMPwTjQc8/rUMWKDl4AqlIE3xBXTJfzg4HUs
        VuYonyDBDnStWNQmO+qfc2VtLPYGpToNZZETqVkey/KDltTCRAuYJscfcbDCPeeornxW1i
        F6ltjOIiL0w1o5qzKROZUwM3nyedRL4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-8wDIHd8PNtyl3o_qIobQbg-1; Wed, 11 May 2022 06:03:31 -0400
X-MC-Unique: 8wDIHd8PNtyl3o_qIobQbg-1
Received: by mail-wm1-f71.google.com with SMTP id 26-20020a05600c021a00b003940660c053so514691wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 03:03:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/vtPNJw1+YnhXgRCJ8NELfFcD+FTH1I0JZLJZh7rb18=;
        b=j1EKHYsuxwDH7drbqoOLLSd8jlVQxx3TILODEpwXzTVRvLWL8VRhJ7I2hGLDL6ZgC8
         VEhrSJ3xb8k+py6g7yxCVxEtCT43W4C4+2aG6GIxiEczXwHdEqzrl8pEq9m3PQbzJoEK
         VCDFRC3WbmNmjVMRHux4BSbgSyIxlz6eJZrHOlNp5BnmwmQRwCMpWbo+q5LF7NbJyZh7
         Lvzqsz9/G6vE0LiJnyeyO9D0M4vcF30CW9u2N1s22+CG3N9Syiw4QbVkgKJ09yqaMrFS
         xLReyRZDs6z6SyOX2FtQUtBA+WCsTef8PC7UZ870a3gKwxi9yDEcP6yhXk6jIYGAxxfQ
         3egA==
X-Gm-Message-State: AOAM532Rd7moRRSc5SohoE18b2MwaBhAGy8n8XR+INLz3yyFvbxZmi8F
        d+SeBmbxTPFkbRy/uGUa5Orc9xkKqp33bhlqqFw/OErSeCbKsGhhUO5/UaNxwP4IcRk6MgNeD5w
        /rAJSHAJqDwhXKKQmNzSdAVFxiVMwy6YYderXuuOjubrhPgInNLA1W5ZZvmEVhSmmd/RB9n9wHs
        s=
X-Received: by 2002:a05:6000:1707:b0:20c:660c:7c78 with SMTP id n7-20020a056000170700b0020c660c7c78mr22100344wrc.150.1652263410416;
        Wed, 11 May 2022 03:03:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/mtciUUA/2mXBlfux7nSrDs5vehkcW7+aoBUwQ+SGHeAN3Wa6iGwpRl/7vAo47q2NqMsjgA==
X-Received: by 2002:a05:6000:1707:b0:20c:660c:7c78 with SMTP id n7-20020a056000170700b0020c660c7c78mr22100313wrc.150.1652263410167;
        Wed, 11 May 2022 03:03:30 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n42-20020a05600c3baa00b00394699f803dsm5480419wms.46.2022.05.11.03.03.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 May 2022 03:03:29 -0700 (PDT)
Message-ID: <e5408379-ce8f-46dc-0673-71b10743b563@redhat.com>
Date:   Wed, 11 May 2022 12:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/todo: Add entry for converting kselftests to kunit
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
References: <20220509130846.694397-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220509130846.694397-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/9/22 15:08, Javier Martinez Canillas wrote:
> Many of the kselftests in DRM can be converted to kunit tests instead,
> since that framework is more suitable for unit testing.
> 
> Suggested-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---

Pushed this to drm-misc (drm-misc-next).

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

