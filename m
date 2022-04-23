Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B4C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Apr 2022 15:43:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbiDWPqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Apr 2022 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiDWPqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:46:11 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B192B1A3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:43:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p12so13601894lfs.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=taL2DWtNeerePSMdB6oQDnrfS++oLVjgA+shqdTkE2A=;
        b=gZAR8gbOFHKyqjsR7s6HlhyMOrGVGBlz9AdgdGD+75xV9pgLLQjEhZnnNkzb5I5/OZ
         Iu6bW/vkxpIRbnMQuWyhgREiGOb1X/nsJJ8d55RgUWnQu2ERfDaI1NbeLfu/4pODOIjW
         54EelfNNrtBUt6SVts+F5kTIs7CeL4v3dc0BikXhMeykepSrRUt0EmRjGMG4ph70j9cP
         tMQHbD0mVnagh4mb/SgydgcFiN7G0QyXU5syOhKoNTrgRrrR2HGdt9rlW9i9VOW7De0O
         RJWW5O/lJvSfitvRCmiE7MplaB9Ibh6Kn3ZXsjaIGrHFZ1KUVpifhcr1i0hCG0YOllD3
         zAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=taL2DWtNeerePSMdB6oQDnrfS++oLVjgA+shqdTkE2A=;
        b=an3SpFCAE5xyVl+8hdU6ZBLiZS/oQ8oNNUAqZOJl65aWceKXMI4mSPl+mBgKuyW6dj
         Lq6eUEE38vvKZa+Qfm65JQ65ivOrrLNN+vcpYSWCTjiBeYGEoZfY7mVTFV1uTPeAt37z
         AU368xhNYy3MHgKSuOQNH6UQSsT2oK7U339slw7xDlWgTExCU7+mVmBkXu8HHByGzGX/
         UJaqDweSGwVPSZjmUNM6OU+beklt0T5Po9FJAoBTI+5oGhkyenCRQQDcD3bbRR+ybYaZ
         G8vekU73lhEiOb3xwoIryzcc3Dcj3weE724di/bLDJsWGJJ3d6005JFQDyCkG1Z3hQyp
         Zi0Q==
X-Gm-Message-State: AOAM53222ZLPjtjZ0xiIZk12f6nzD/8ksOEbQ4pEGJNAXK7CnougDQoJ
        FzyRonvh8PTfsvxAUol95zQ8CABbUP+AP9K9er96fg==
X-Google-Smtp-Source: ABdhPJx8JpUyqNWyPii76onWlhk5/f9NNoIifQz9RH0ZiEOrbKYYnZ20pVUITSQeYxnqYWlbgR+lyIs9QtwBcUTYfL4=
X-Received: by 2002:a05:6512:3a95:b0:471:886a:8117 with SMTP id
 q21-20020a0565123a9500b00471886a8117mr7248193lfu.682.1650728592235; Sat, 23
 Apr 2022 08:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220423102421.16869-1-fmdefrancesco@gmail.com> <20220423102421.16869-2-fmdefrancesco@gmail.com>
In-Reply-To: <20220423102421.16869-2-fmdefrancesco@gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Sat, 23 Apr 2022 08:43:00 -0700
Message-ID: <CAHRSSEwQSB=9rcCG+LmFUgrRHdsLDkstOW0qy-5Uw2xEm0SniA@mail.gmail.com>
Subject: Re: [PATCH 1/3] binder: Use memset_page() in binder_alloc_clear_buf()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 3:24 AM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> The use of kmap() is being deprecated in favor of kmap_local_page()
> where it is feasible. With kmap_local_page(), the mapping is per
> thread, CPU local and not globally visible.
>
> binder_alloc_clear_buf() is a function where the use of kmap_local_page()
> in place of kmap() is correctly suited because the mapping is local to the
> thread.
>
> Therefore, use kmap_local_page() / kunmap_local() but, instead of open
> coding these two functions and adding a memset() of the virtual address
> of the mapping, prefer memset_page().
>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Acked-by: Todd Kjos <tkjos@google.com>

> ---
>  drivers/android/binder_alloc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 2ac1008a5f39..0b3f2f569053 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -1175,14 +1175,11 @@ static void binder_alloc_clear_buf(struct binder_alloc *alloc,
>                 unsigned long size;
>                 struct page *page;
>                 pgoff_t pgoff;
> -               void *kptr;
>
>                 page = binder_alloc_get_page(alloc, buffer,
>                                              buffer_offset, &pgoff);
>                 size = min_t(size_t, bytes, PAGE_SIZE - pgoff);
> -               kptr = kmap(page) + pgoff;
> -               memset(kptr, 0, size);
> -               kunmap(page);
> +               memset_page(page, pgoff, 0, size);
>                 bytes -= size;
>                 buffer_offset += size;
>         }
> --
> 2.34.1
>
