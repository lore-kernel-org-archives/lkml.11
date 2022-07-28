Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A3FC19F2B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jul 2022 17:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbiG1Rsz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jul 2022 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiG1Rsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:48:54 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63455747A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:48:53 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id z132so1961432iof.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=i7ldDxdnUfldQtfp/5n2EGYevnoqq4v0lSwUh5bbbjc=;
        b=PF+Ni6CU56dDQlOtp54AWAx9RDfVqoF+E+boOAiFj3dFnctctp1dknHKdpjNYCPQfD
         RUNJEYA9i23Uo7FReETM/vSHNdkRehwFlBTqPhDJK6+EMb2PKMlh39EAV3hWzgpOZ2tb
         m56597XHyBSzXe92188/aWt1y7RThhItU60eyhn3ZDC8bwSwUJB0bTFlEPSdpm61fK5T
         C1lPtN1pLpZ1dIebat9TDVCTBe72i1ER5VaWWAT/T3LzllCf35S26ufE2ArAhT6k7oNp
         tFXOdE9f10ANw86w/Mm0g5p6Xw1jAMW9C/0RRDd9Lxpa/Xp/NQWZM7e++I/tlyAJP3lX
         vbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=i7ldDxdnUfldQtfp/5n2EGYevnoqq4v0lSwUh5bbbjc=;
        b=JX9wwDedY7vpoRBPqd2ZrqIw6j1rLVKFNRCnaABHJPOvyKrR7pli4Wi5fJG9IRLaSf
         ehXxn+A2nulDroiHLlWK/qcmdt54W92LTIQV9K/qPTtr4owQqYQaWNy3DB9I7nugH9gD
         CEE0UgbKpXAi/wFGkdQNescWu2B7v6uMnhI9PTy+NyoK3z1XxIk9LSTLlf3CjVWR+eqS
         uisJyF3hs+Vj8vRyR0TeD9cwLh+FYYZ8LGDbxUxMPq7ZYqWYInJdRE9fOYWqYb4Sz0bw
         u2M/ISOkE8+wQm1QIOgcj5vUWoiEwNhtlIvY0t0W9BnQLNWXNoL905mKTLlGJwM4tIvz
         HO2A==
X-Gm-Message-State: AJIora/r2a9ijJkclMMhSkt03YLKoKfRp8e6DMq/RufkMKjV2csHRDxh
        sm6/mJooTXP4D1vAwsvkvjXtCWpgEfG243ddoC7xTLJoSL0=
X-Google-Smtp-Source: AGRyM1srcMliEgUreIhv0EqJt3cggMO4YvDZvHruQ80pn7vJrgFRKlIG6ZBAvhYrhfZy3gerPAhiHz4eGmuI4T+CRLE=
X-Received: by 2002:a6b:fd15:0:b0:67c:7877:3e4d with SMTP id
 c21-20020a6bfd15000000b0067c78773e4dmr9308681ioi.65.1659030532741; Thu, 28
 Jul 2022 10:48:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220728121949.20985-1-linmiaohe@huawei.com> <20220728121949.20985-4-linmiaohe@huawei.com>
In-Reply-To: <20220728121949.20985-4-linmiaohe@huawei.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 28 Jul 2022 10:48:41 -0700
Message-ID: <CAHS8izMiKaZb+D_ZW2UasUThnCTUarE3kObz8BESBGD8XgfNoA@mail.gmail.com>
Subject: Re: [PATCH 3/6] hugetlb_cgroup: hugetlbfs: use helper macro SZ_1{K,M,G}
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 5:20 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Use helper macro SZ_1K, SZ_1M and SZ_1G to do the size conversion. Minor
> readability improvement.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks Miaohe,

Reviewed-by: Mina Almasry <almasrymina@google.com>

> ---
>  mm/hugetlb_cgroup.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 99e9a367e1e5..7e0bca52c40f 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -674,12 +674,12 @@ static ssize_t hugetlb_cgroup_reset(struct kernfs_open_file *of,
>
>  static char *mem_fmt(char *buf, int size, unsigned long hsize)
>  {
> -       if (hsize >= (1UL << 30))
> -               snprintf(buf, size, "%luGB", hsize >> 30);
> -       else if (hsize >= (1UL << 20))
> -               snprintf(buf, size, "%luMB", hsize >> 20);
> +       if (hsize >= SZ_1G)
> +               snprintf(buf, size, "%luGB", hsize / SZ_1G);
> +       else if (hsize >= SZ_1M)
> +               snprintf(buf, size, "%luMB", hsize / SZ_1M);
>         else
> -               snprintf(buf, size, "%luKB", hsize >> 10);
> +               snprintf(buf, size, "%luKB", hsize / SZ_1K);
>         return buf;
>  }
>
> --
> 2.23.0
>
