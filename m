Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E95BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 23:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiBXXXg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 18:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiBXXXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:23:33 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA32275790
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:23:02 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2d79394434dso15599617b3.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7PcHeGTv1nepIZccoOt2KvIGv6o7ZMesEHiNR2b+Ae4=;
        b=IP46SqaFG3Cp9I/RlUmTy2NwIuXAD+TIu4+nLuhN3cPPcmtXjuhdH01Z7ACwrjUMSt
         +wtYp5sdxZOO554Itx7519khz8U5Jmu9oHjtpoqzTsPYYBl6A3XdGyZOxZO/AKNeCTTn
         kwhUGYIhUxJsDbhwnuN99mUTY+TNCUhxolMzT+ZG5zS26PPXTVI7w8NkhfykOj4j7/3x
         rBlxWRSoh7ayE2EsjKW5ER6vLOQfvHymvYHnQ9nO/DLYrPllboC1H0nWsJbYxdae3WLR
         Tv8wiPuQkus5yqJCqF7wP6je0NrJC66k5KoqL3rOScpAcQWFlNzlDGerqw2ZHxm2LW8u
         1AUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7PcHeGTv1nepIZccoOt2KvIGv6o7ZMesEHiNR2b+Ae4=;
        b=PTFWCefqAgIn5Sm/TP6NaikWtHqngCm1LXwckPqh+Qt3q03RjmoGTsugelA8LgSau0
         FUCS2E8YtqFk9Eoin6nejEsEg0wHU85EZtM4QcGRuqxaCJoqJwzKLKEm16GjN8XuDTwY
         HzWXxoUuqJ28m/6wNI9cNWXuLaVQEmUlkuy6/FbFzzZEY+ZYuGJE/Jb5yeUJtV0scZLs
         kki1iWXKi01TDxs922PYzKuEoAbppNPUKp1UJ8P6IWHDBxsNmjhA4u8RrpiUs82FvgCV
         lgWEP6rzxUJz5uIaV1+0wMm3IFr0qNpPTmSlV8o8f8otnUgwhPP1vguH9pHCjyX/Ni/7
         spKg==
X-Gm-Message-State: AOAM5327i7c3eSwLt7AJmBxmnKn4Prg9Kk22dlvyL4yIXBRsnD+mincW
        KgxiVGGV28VdiC1oy48vtmiY+uh05lCBjcSKR9UQXg==
X-Google-Smtp-Source: ABdhPJySf8IPuVlilt1gPELukIw7azFXE1n/f504LYGPRJS3bICswx2L2GLT5H0iEOkcI/XpiLE3qfsFdpPXZeA/yCU=
X-Received: by 2002:a81:1748:0:b0:2d6:41ae:1384 with SMTP id
 69-20020a811748000000b002d641ae1384mr4902300ywx.293.1645744981753; Thu, 24
 Feb 2022 15:23:01 -0800 (PST)
MIME-Version: 1.0
References: <20220223153613.835563-1-surenb@google.com> <YhdDg1oPpI7bkshf@dhcp22.suse.cz>
In-Reply-To: <YhdDg1oPpI7bkshf@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 24 Feb 2022 15:22:50 -0800
Message-ID: <CAJuCfpG039-8q_nK2D20VfZSY6c4Ya-AA9Keh9mE7EoebDJ68Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm: refactor vm_area_struct::anon_vma_name usage code
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, dave.hansen@intel.com,
        keescook@chromium.org, willy@infradead.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        hannes@cmpxchg.org, ebiederm@xmission.com, brauner@kernel.org,
        legion@kernel.org, ran.xiaokai@zte.com.cn, sashal@kernel.org,
        chris.hyser@oracle.com, dave@stgolabs.net, pcc@google.com,
        caoxiaofeng@yulong.com, david@redhat.com, gorcunov@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:36 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 23-02-22 07:36:11, Suren Baghdasaryan wrote:
> > Avoid mixing strings and their anon_vma_name referenced pointers
> > by using struct anon_vma_name whenever possible. This simplifies
> > the code and allows easier sharing of anon_vma_name structures when
> > they represent the same name.
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
>
> LGTM
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> Thanks and one minor nit below

Addressed all the nits in the next version:
https://lore.kernel.org/all/20220224231834.1481408-1-surenb@google.com/
Thanks!

>
> [...]
> > +static inline void free_anon_vma_name(struct vm_area_struct *vma)
> >  {
> > -     const char *vma_name = vma_anon_name(vma);
> > +     /*
> > +      * Not using anon_vma_name because it generates a warning if vma->vm_mm
> > +      * is not held, which might be the case here.
>
> s@vma->vm_mm@mmap_lock@
>
> > +      */
> > +     if (!vma->vm_file)
> > +             anon_vma_name_put(vma->anon_name);
> > +}
> >
> > -     /* either both NULL, or pointers to same string */
> > -     if (vma_name == name)
>
> --
> Michal Hocko
> SUSE Labs
