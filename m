Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BA7C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Apr 2022 17:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244053AbiDYRup (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244041AbiDYRul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 13:50:41 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB901C13E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:47:36 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id s203-20020a4a3bd4000000b003191c2dcbe8so2921459oos.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 10:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m21FEJxNvF+ScKNVrQB2zjxzVrh9tftainj7QUwtfio=;
        b=bKSmgB4uNcLImMcLm04M81HS6AbvME1OHxdry0sHNt+CPp7FhCj+aZMsKORP3RqiM6
         ciGUKuuqTUU1NcZhKRglQt9V5L0fd2piqGMhfnAVnl7eG86JUNrbt6Hn/Rni3i9nWuc4
         oVBI9ignz5nDa4wqhYH2zQfXyBKsBqLLWlo4JvbL13pezeqGgufxksdnf6tAcR92EmLT
         eVMhItywFnc3Y3AR2qH44CvO0UsE8QYu25ybvd8ScZ+mhIaOWbl0qlzOtZDyITYJ2S6+
         CN9YPyvClh+zevOpK5SzqoW3pfDpzLf5heRc1BVndaDx2omKtZvjxrfNhcR4M0iZGN6v
         4qhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m21FEJxNvF+ScKNVrQB2zjxzVrh9tftainj7QUwtfio=;
        b=4sz1V8rX2KX4a5asO/R6heLX4okVRX4t5R6tvmfFTzHE0Pbjjsz5EjyChLRG4J4w2a
         h+1U/yhvCk3cHsxqrdYUlK9D74I/WFjkQzqT/kmeNTvxaal9vwS7Xz0fQVM4n48epKSn
         aYP4uB76yhgac5jjmiNI6t46LoW8aSpZULrGGGEtPpOrf0E6/bfwiP/VjXVxY5Yd6Yph
         l8w5TJNAPU/F/Zx55IJaWDjz0WkK2cUIWdo3O7xhdjH5+c5vQ8LDrxpmkmyB3BEKoJ/C
         GegS4yoUwqA6ALgjy4Qrln8nhgs9FmDT8jkwEpoRl+TaLiX8m6Tlog4tih/LXqd4lxax
         k+rw==
X-Gm-Message-State: AOAM530TCJuDNy3u7uXYJi5ma8D+ZOX3eBnof1seDEMpqSYcMlVhImLi
        g59bZKZECKIvcqq/xgsMZ0n1OOjhIWwbLiiOSJs=
X-Google-Smtp-Source: ABdhPJxX43gYEJBSlIIAHRVesXis2DaOfUdo3u4PZEMOqQKg4mXGDJALqDKFDYk6BPQ6mFrw9Zmagh3Fjh4pkMvq8M4=
X-Received: by 2002:a4a:a2cd:0:b0:33a:49a9:6d46 with SMTP id
 r13-20020a4aa2cd000000b0033a49a96d46mr6818911ool.46.1650908856172; Mon, 25
 Apr 2022 10:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220424163132.37007-1-makvihas@gmail.com> <20220424163132.37007-3-makvihas@gmail.com>
 <85f946c9-235e-cc69-4d19-1ebf972cd935@gmail.com>
In-Reply-To: <85f946c9-235e-cc69-4d19-1ebf972cd935@gmail.com>
From:   Vihas Makwana <makvihas@gmail.com>
Date:   Mon, 25 Apr 2022 23:17:25 +0530
Message-ID: <CAH1kMwQ+vAcqcbsimB2Rr8gyhLtjPEQYi11uVi48Rm5PQRmpoA@mail.gmail.com>
Subject: Re: [PATCH 2/3] staging: r8188eu: fix null check in _rtw_enqueue_recvframe
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 12:23 AM Pavel Skripkin <paskripkin@gmail.com> wrote:
>
> Hi Vihas,
>
> On 4/24/22 19:31, Vihas Makwana wrote:
> > There's a NULL check on padapter in rtw_recv.c:189 which makes no sense as
> > rtw_recv.c:184 dereferences it unconditionally and it would have already
> > crashed at this point.
> > Fix this by moving the dereference line inside the check.
> >
> > Signed-off-by: Vihas Makwana <makvihas@gmail.com>
> > ---
> >   drivers/staging/r8188eu/core/rtw_recv.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> > index 4cf9b4b8f..7d306a3c6 100644
> > --- a/drivers/staging/r8188eu/core/rtw_recv.c
> > +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> > @@ -181,12 +181,13 @@ int rtw_free_recvframe(struct recv_frame *precvframe, struct __queue *pfree_recv
> >   int _rtw_enqueue_recvframe(struct recv_frame *precvframe, struct __queue *queue)
> >   {
> >       struct adapter *padapter = precvframe->adapter;
> > -     struct recv_priv *precvpriv = &padapter->recvpriv;
> > +     struct recv_priv *precvpriv;
>
> Actually, `&padapter->recvpriv` is not a de-reference, it's just address
> calculation, so in case of padapder being NULL precvpriv will contain
> offsetof(struct adapter, recvpriv).
>
Oh, I see.
> >
> >       list_del_init(&precvframe->list);
> >       list_add_tail(&precvframe->list, get_list_head(queue));
> >
> >       if (padapter) {
> > +             precvpriv = &padapter->recvpriv;
> >               if (queue == &precvpriv->free_recv_queue)
> >                       precvpriv->free_recvframe_cnt++;
> >       }
>
>
>
>
> With regards,
> Pavel Skripkin



-- 
Thanks,
Vihas
