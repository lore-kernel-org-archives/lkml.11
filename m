Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374B2C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 08:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbiCBISN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 03:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbiCBISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:18:09 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B264DB9F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:17:24 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id b35so1701911ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8ybIWPIDdU71F39jjIJuRp774Q9dzDoXBqOCvd7O4U=;
        b=ZzhQoE+bWReOuJtPViXNbioMXBS4tOpAPRe2I4nwgVgedngWp6nnezdT07Nytd8noK
         3csGIm+2HAspPrBxJAysB0JWXe/8xY+nj5GnA90eH6IkovzBOmEg0mlMmbGUzwBIxQJJ
         D9C3fDEDvqNTmby4MaQT0uzk33QVxqe7Ovjew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8ybIWPIDdU71F39jjIJuRp774Q9dzDoXBqOCvd7O4U=;
        b=GIzc6hsUCV2DUj7dECG2hD9GkT6I0urY6sLBnXIHtK5TDo58U7eUA7N5NiHgM8QFA9
         VRzakBJfEwhl7PxvQBMwcthp3b0u9fvNrflONYZWwj5Ofd0W8/VMgk8Pben6qgie5KR0
         o+o74lJ4ynStz7kJtSDP86FjdBDrivf9YzCIhOJUfS8c5gvdS7riTcXPlfXTkAI0P+dS
         XUCo++t3CI53a01UTgyZHHlSiFSXnkcYkNDoonHhL/P881iL6LIhYQNUKpB6tLoyuDAg
         oqTCcv2bfh9kIydzZHIQ5zXwrzgJnJiesbMtAH18SoRXM9OtG/e5CtEcigP1X5VELsGI
         A9fA==
X-Gm-Message-State: AOAM531JLiyoev9tUhcVPK32OFtbd8q4CLWxCvIwjahWrwQ9ebugPNNF
        g1Jv2EsiwQ5ofFcxD+JuJOLttKF26K0ISdkn7OPeHQ==
X-Google-Smtp-Source: ABdhPJySFL84Glj1KBjaq8+mv4vgDRdz49QiUGC21kriLSCqk3K+tO9UtP7yGBNj5Ucpdl55B/6mmh+z0tPYcgdGMt0=
X-Received: by 2002:a25:1181:0:b0:624:6c32:e341 with SMTP id
 123-20020a251181000000b006246c32e341mr27601367ybr.437.1646209043908; Wed, 02
 Mar 2022 00:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20220219092533.12596-1-linmiaohe@huawei.com> <20220219092533.12596-2-linmiaohe@huawei.com>
In-Reply-To: <20220219092533.12596-2-linmiaohe@huawei.com>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Wed, 2 Mar 2022 09:17:13 +0100
Message-ID: <CAM4kBB+PxUVWAJmr1448yKrzJtGpW6Zqh-vWevnqHweDCi+qtw@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm/z3fold: declare z3fold_mount with __init
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 10:26 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> z3fold_mount is only called during init. So we should declare it
> with __init.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Vitaly Wool <vitaly.wool@konsulko.com>
> ---
>  mm/z3fold.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index b3c0577b8095..e86aafea6599 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -345,7 +345,7 @@ static struct file_system_type z3fold_fs = {
>  };
>
>  static struct vfsmount *z3fold_mnt;
> -static int z3fold_mount(void)
> +static int __init z3fold_mount(void)
>  {
>         int ret = 0;
>
> --
> 2.23.0
>
