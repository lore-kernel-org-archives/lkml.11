Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF10C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 15:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiF0PoG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 11:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiF0PoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:44:01 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D6215A23
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:44:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id q9so11498088ljp.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQZ4OyFd/Vh+t4lCY502GH4XuB876uWmHVT671qrNIo=;
        b=Prs2CDEQ0ATYTt8Bf/Res1wbJ8XNtiJlz9ghKusQvGlGW2YjNA6YtG3979h20gZjT1
         0tBtt5TQnwj8N7uhS3//6IwlTqqTUKREfX2gn0dcwFSwfNOecf0+RSPr3VbKAXYQxYhB
         h3ETqF0gQHcZxsq42wNbVfNVlui5Zk6mqLkFQ4fq2SdgGdBqmUc1t6GUkqIwZddUNlNW
         v2+zcIbVFtBYW18QvxoDR2rL4uOdNAaB6EfKYXpwXYrt8prz9j5iRHGZD14zn+q76jGW
         BEtfrcuUseFd3PNpenYga7wlKia765vKoFY05nyr17YyIZmUpx1aIi4HCy6y6YryqnXh
         Q26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQZ4OyFd/Vh+t4lCY502GH4XuB876uWmHVT671qrNIo=;
        b=f9ovDMlTdCiqGMvdxuuFqXfFK4CucjkqEYTpFTEsrlmYi6KZznHdK7l/lVnKeQauo2
         QfjtFBng90hCmc7Tavq3knlQ39B02gmfDxsHNyLYUI4FQdIzNQCh0nSLBkeGNmPyauv9
         kvGSaWjUthg89hO2/oQnTnM4rVhhcmryfbIX//PeJLNFSGlWQwMvkN9Akqy7Jy99PgIM
         91OSJsYjFYkXvZWmFEp9VlQ3Vw4RFe4eZGEUb4/fdb4XN4duQM4gtDYnlbz7yfDpJd9O
         sOpVjeJIZ6uCfSqsYKz7AmMaAJO6nwb7tVx/KwJnSm4uaKvs1hnt2jwKOumuw2oV+g7E
         jzKg==
X-Gm-Message-State: AJIora+PyrlD+fx+Uz8er83oImK+Bn4YEji4FnIAAr28PEpXgqvg5HBy
        PiOxYqJZ86q3WJpjazsV2zmJeGFP+FfcESzdiUES2w==
X-Google-Smtp-Source: AGRyM1uQevSUj47TI5euRZetRDXOkQlrZFGIt7fm9JyI/Ew7PzZ0uKRRAPp3uqfT/i9j+YY8oNbiAVCjXKyoZeuhAkI=
X-Received: by 2002:a05:651c:504:b0:25b:cb73:52af with SMTP id
 o4-20020a05651c050400b0025bcb7352afmr1075138ljp.391.1656344638736; Mon, 27
 Jun 2022 08:43:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220627151857.2316964-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220627151857.2316964-1-Liam.Howlett@oracle.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Mon, 27 Jun 2022 08:43:47 -0700
Message-ID: <CAHRSSExGqb5qgPGX34dJnntevNzn2osL+_TBQEkScUEFj5t58w@mail.gmail.com>
Subject: Re: [PATCH] android: binder: Fix lockdep check on clearing vma
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arve@android.com" <arve@android.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hridya@google.com" <hridya@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maco@android.com" <maco@android.com>,
        "surenb@google.com" <surenb@google.com>,
        "tkjos@android.com" <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 8:19 AM Liam Howlett <liam.howlett@oracle.com> wrote:
>
> When munmapping a vma, the mmap_lock can be degraded to a write before
> calling close() on the file handle.  The binder close() function calls
> binder_alloc_set_vma() to clear the vma address, which now has a lock
> dep check for writing on the mmap_lock.  Change the lockdep check to
> ensure the reading lock is held while clearing and keep the write check
> while writing.
>
> Reported-by: syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com
> Fixes: 472a68df605b ("android: binder: stop saving a pointer to the VMA")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>

Acked-by: Todd Kjos <tkjos@google.com>
> ---
>  drivers/android/binder_alloc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index f555eebceef6..1014beb12802 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -315,12 +315,19 @@ static inline void binder_alloc_set_vma(struct binder_alloc *alloc,
>  {
>         unsigned long vm_start = 0;
>
> +       /*
> +        * Allow clearing the vma with holding just the read lock to allow
> +        * munmapping downgrade of the write lock before freeing and closing the
> +        * file using binder_alloc_vma_close().
> +        */
>         if (vma) {
>                 vm_start = vma->vm_start;
>                 alloc->vma_vm_mm = vma->vm_mm;
> +               mmap_assert_write_locked(alloc->vma_vm_mm);
> +       } else {
> +               mmap_assert_locked(alloc->vma_vm_mm);
>         }
>
> -       mmap_assert_write_locked(alloc->vma_vm_mm);
>         alloc->vma_addr = vm_start;
>  }
>
> --
> 2.35.1
