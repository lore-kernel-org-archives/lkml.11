Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E7C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Jul 2022 17:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiGARrm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Jul 2022 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbiGARrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 13:47:40 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B05C3A193
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 10:47:39 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id x21so1093634uat.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Owhb694VNyKXL9BTeHyWfPv7VjySMI0QfeQx3kqvgGY=;
        b=db+nhfvC/RPkYrPjhilWcAUW0Br1Vmg7cACLD2aJRlOdO7IOv19o+3yJM1/koHPZ3j
         ojMBdTf2KAEdhu//3OrMvcs9tu/MuO9qOUOX9XiQj8nwyaN49RGfiQ91svbr0yKXGebM
         Q06i5dMm+SH7WmylW8Wm2x2wo5Gx5jHQHoNOXQaiHlNcJr9/gtaUns5J0yqjhfgTclJd
         CIf9BGgux0xMjMyBTG/NPNjYmensBpCfMPExE9lpFV1hlgn+7CP4ny8ASHUAkQpUtgye
         orJKEHiFrzGoBcg/oELdDFU0+cobRUI4v7vsTzV8gWw+aHiyFn3TpDMYFBQ4mcTBe3gv
         EiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Owhb694VNyKXL9BTeHyWfPv7VjySMI0QfeQx3kqvgGY=;
        b=jse7KrbPij+RONpdYzS7CDDJY4MKXaaryXpyCLtfTqcc6dMQBK3y+VyXjTRg9GULOS
         Au9sDer9FopFcHzV2zJod789DC0fJeNkDLzBN2dPHFM4KaKpzEZc1AvcoX+TbU/WQoWp
         J3RJNLYvEuPOzB5AfrPDGEqQ5TIVdg4HI6rOEepRnWp3WITNyGs2zKGNJuR5R8YSJvvz
         6i0f/GUkO4p+hmresh6lLe9KCGvQdpeCpwiHhEoLPjvBLuurb3NVKGFBvojNMWeZrfZr
         aZNnpu4s8MDz5LP5Bhl2b+DxVpxKJH1VWkIpLu+O3X3hSeufhYYooP3zr3asxtdrrOrZ
         4t/w==
X-Gm-Message-State: AJIora+SBtLCDAlwQF3yKMN+aBdBT8cJOJ0cLyVzZC7ycNPjhC/RCkGR
        BTSUy+QkqKTNIMaspE+1AuwcIGiP7AlyoOXQUnUOtDVM1LY=
X-Google-Smtp-Source: AGRyM1tvJiLTYOBz10GyPOSW+SJJWdSYxXiWHlOwB3Nvk1vNG56ZttGuBQslfMO3zERMcHcYmuzdQ67PO3cjfgM8cZw=
X-Received: by 2002:ab0:244f:0:b0:37f:2985:e620 with SMTP id
 g15-20020ab0244f000000b0037f2985e620mr8967541uan.36.1656697658397; Fri, 01
 Jul 2022 10:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220701120755.2135100-1-javierm@redhat.com>
In-Reply-To: <20220701120755.2135100-1-javierm@redhat.com>
From:   Peter Robinson <pbrobinson@gmail.com>
Date:   Fri, 1 Jul 2022 18:47:27 +0100
Message-ID: <CALeDE9P4vcJ3UgZdH8-4iaAHiYziS29G7WgtzcJbv0SwVANOyw@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm: A couple of fixes for drm_copy_field() helper function
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 1, 2022 at 1:08 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello,
>
> Peter Robinson reported me a kernel bug in one of his aarch64 test boards
> and even though I was not able to reproduce it, I think that figured out
> what the problem was. It seems the cause is that a DRM driver doesn't set
> some of the struct drm fields copied to userspace via DRM_IOCTL_VERSION.
>
> Even though this is a driver bug, we can make drm_copy_field() more robust
> and warn about it instead of leading to an attempt to copy a NULL pointer.
>
> While looking at this, I also found that a variable in drm_copy_field() is
> not using the correct type. So I included that change in the patch-set too.
>
> Best regards,
> Javier

For the series
Tested-by: Peter Robinson <pbrobinson@gmail.com>

>
> Javier Martinez Canillas (2):
>   drm: Use size_t type for len variable in drm_copy_field()
>   drm: Prevent drm_copy_field() to attempt copying a NULL pointer
>
>  drivers/gpu/drm/drm_ioctl.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> --
> 2.36.1
>
