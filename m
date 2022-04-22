Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEBCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 18:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiDVS0w (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiDVS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:26:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8AADC987
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:23:51 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 12so9902676oix.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+e4BntlSJ6eS9gMNEO204GgU4j5QlVGYPmkYEN/7+0w=;
        b=llOz/bS4d527zVJ2EY0qyOmA8Y9sNZvjq/7iSiflH1OnFoDCyOwW0Ntzov/K7jKksE
         zceyjAASFQp0RnQZH63euLXwXXSc8x4oNJeZzMu5dkiPUnjSeLrp4SNYy8AVcK3kTIN1
         t2LNSgtclZTLSplOIB589ETnhaVXhGhuVDPE501hYU3q9CDQuWg8j/fvk9nja5+Qy9aU
         ZXlClbtz5odBRkMvQCSuFovlJ1rwnaZiEix8MRHt0RaIQW4mhUJ43OosY2Lf3xm3tYgL
         CgXWi8Y4r19/FApxvVAS3s7P0IYeyJIkpo86c5QX7VL9dmP234cxag9bZ2VxB1VmLuIW
         WlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+e4BntlSJ6eS9gMNEO204GgU4j5QlVGYPmkYEN/7+0w=;
        b=094utraoR4pHE59KolZ/qAX11nUfZSDLAC3di1RVykmXwkCQ0sGd0gOaSUSPTpmOba
         V8XUacffNYbpafKvyPYmT1XcNn9i1U2BLMPXFtGz+z1adbFodI92LjF9VabhL9gcHzS/
         tCjOdWuJUMjw7jUudsWl0GNN8NFVz2upuscGG7rAT5Cmw6CpdUd0ws6SZYodEVnQhMfC
         Fl3YsZn3Hxsi1Ab9FaFTBk81cnSEJ1saWTGMH+vK+9nstLtcR2uVIV43F9LtCke29T9W
         DPzHFr2X8o9fuwrbKsZ61+ASPs6jlcId8PbrL1Zncv0KbJ/aICpQfI9/NnOZjTVHBnNf
         Wykg==
X-Gm-Message-State: AOAM532bMrYb8MjQqaPcEo5LC1rUirpZRWal6FJfTiAzrUfJNIaJGXnK
        24NhQtLz69smwP5CnvXLWtpOXBUF+6zFcD7E7Lw=
X-Google-Smtp-Source: ABdhPJwhBuu62atsZ8fpp36cRof1utYWz0MCJ6T1bpq42QHi6pekge2EQre7emrZnKuU7y/iW6MivXk6TJH6fOP+osw=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr3027385oiw.253.1650651799992; Fri, 22
 Apr 2022 11:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <1650607437-22275-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1650607437-22275-1-git-send-email-baihaowen@meizu.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 22 Apr 2022 14:23:08 -0400
Message-ID: <CADnq5_NKJ2nC_2akBEX+7EOhgF-XsPjVw_QTHqKDkoA3G6qx1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove useless kfree
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Fri, Apr 22, 2022 at 2:04 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> After alloc fail, we do not need to kfree.
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ec709997c9c7..5fb3e69c04c4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1849,7 +1849,6 @@ static int amdgpu_ras_realloc_eh_data_space(struct amdgpu_device *adev,
>         void *bps = kmalloc(align_space * sizeof(*data->bps), GFP_KERNEL);
>
>         if (!bps) {
> -               kfree(bps);
>                 return -ENOMEM;
>         }
>
> --
> 2.7.4
>
