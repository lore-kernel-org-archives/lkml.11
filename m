Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ABEEC43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 18:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231791AbiFXSoF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXSoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:44:03 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6D55D116
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:44:02 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id 63so3085435vsv.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8hYCeRpaEZU7KjgpT/XAUYtlAbNZbR1jTTlanQG1Mz8=;
        b=CVSF24k6Vdbn0T5OOFWkOhmBimI4cMqOpZejir1SjU/vmy5lbIk68w2OG7LzGP3/gY
         m2TbNg53miajxfizMYXwIr4j2n6L77jyUjDEzKYFiYYtyRFEpbvLWb8e675Hs9oe27sC
         on2UIRUk2xDMua24ZWnL/6DC4QZq3PVn3w+WaZ0Q43a1PJ79lsHOEaykqUMFM88UbsYt
         Lm9YZGd9IZoWaA1kkmlJyBCAouzieRnARiIYyBeqomuFoo/QL+e2HfNiw4apXzYKRU6+
         s5t1m14o5uRU3JUwKaVJU+vn8mz72aPUL2QcgbeXDe8dS4cfwn60lLX74TjII79wC3nu
         zovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8hYCeRpaEZU7KjgpT/XAUYtlAbNZbR1jTTlanQG1Mz8=;
        b=44rA17w6GA/FV/D00ESPYTB2YaLOO87lbYG7V8lIgvsxygi4TARls+B00enIeDnQBF
         IyYdI6Brksf1AA5KJp0ZArPynqbgIZsk0ttxB2wk6YWNePHUhidTtGySoPOLpzqDcJmX
         sUUKsxJIH0KrXZy8lWgtYGgrAVtaEHyoAP6kjQrUlJ4d4MMbbUr4oZiQ+Z5LjokYJi1Y
         YSpfatbWXRwID2dtEVfkS8kzojc6qvJFddNMyp/8QYGeVabOH5Nv1oacP0Q2O5UYeoC/
         rRW8ROJpb5ETPx2NsIzsgAXxbTaNWxAi0DBXTEloKz4dCWywVrVZnKQyZprrdms2qgmU
         wDRQ==
X-Gm-Message-State: AJIora9WJta18ZEMLOnZlK7lueeZ1rhGhMNQNNb0XtelsgMua5lKU6M5
        c7LI7muLNDgEd6c5z+ON2HVE35kQk2xFaaN4b1vyxQ==
X-Google-Smtp-Source: AGRyM1usFfqzp3/s3xxFYzC5Q7anIB/04PGBIkNtfl++nLUVrXSam0ArMwILrhQ5XVVn6XUIT+sTeqhTbzRuRjLOMno=
X-Received: by 2002:a67:f958:0:b0:354:3f56:8a2d with SMTP id
 u24-20020a67f958000000b003543f568a2dmr216587vsq.59.1656096241466; Fri, 24 Jun
 2022 11:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <20220624173656.2033256-2-jthoughton@google.com>
In-Reply-To: <20220624173656.2033256-2-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 24 Jun 2022 11:43:50 -0700
Message-ID: <CAHS8izPrhw04QTEaPV-jje3Mm=Qktg96mJmpacoR62GzY9VZ7g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/26] hugetlb: make hstate accessor functions const
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
>
> This is just a const-correctness change so that the new hugetlb_pte
> changes can be const-correct too.
>
> Acked-by: David Rientjes <rientjes@google.com>
>

Reviewed-By: Mina Almasry <almasrymina@google.com>

> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  include/linux/hugetlb.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index e4cff27d1198..498a4ae3d462 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -715,7 +715,7 @@ static inline struct hstate *hstate_vma(struct vm_area_struct *vma)
>         return hstate_file(vma->vm_file);
>  }
>
> -static inline unsigned long huge_page_size(struct hstate *h)
> +static inline unsigned long huge_page_size(const struct hstate *h)
>  {
>         return (unsigned long)PAGE_SIZE << h->order;
>  }
> @@ -729,27 +729,27 @@ static inline unsigned long huge_page_mask(struct hstate *h)
>         return h->mask;
>  }
>
> -static inline unsigned int huge_page_order(struct hstate *h)
> +static inline unsigned int huge_page_order(const struct hstate *h)
>  {
>         return h->order;
>  }
>
> -static inline unsigned huge_page_shift(struct hstate *h)
> +static inline unsigned huge_page_shift(const struct hstate *h)
>  {
>         return h->order + PAGE_SHIFT;
>  }
>
> -static inline bool hstate_is_gigantic(struct hstate *h)
> +static inline bool hstate_is_gigantic(const struct hstate *h)
>  {
>         return huge_page_order(h) >= MAX_ORDER;
>  }
>
> -static inline unsigned int pages_per_huge_page(struct hstate *h)
> +static inline unsigned int pages_per_huge_page(const struct hstate *h)
>  {
>         return 1 << h->order;
>  }
>
> -static inline unsigned int blocks_per_huge_page(struct hstate *h)
> +static inline unsigned int blocks_per_huge_page(const struct hstate *h)
>  {
>         return huge_page_size(h) / 512;
>  }
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
