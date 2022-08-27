Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6491ECAAD5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 01:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbiH0BgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 21:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344847AbiH0BgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:36:01 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49641DEB56
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:35:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661564156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+NLU0Agr0DzkFmH5v2uMtwuDu7hJTIQm8wF8qUZfKw=;
        b=TTwfwd156JTzz7U1PxkE+sPW9VMDBvBep0XiY1kqEPo1gEqdCx7Lx/AHs6280v4LG37oeQ
        hikGa0VMLX3WuXUWIUjZgiGK3JYjEP3Vfk6lW6uRQrc1UBXl+BeUNobyjulyXhFEb91YcR
        R8SmayHoOqHpM7Ry9pSA4HdiKrsxOHY=
MIME-Version: 1.0
Subject: Re: [PATCH 08/10] hugetlb: remove unneeded SetHPageVmemmapOptimized()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220826092422.39591-9-linmiaohe@huawei.com>
Date:   Sat, 27 Aug 2022 09:35:52 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <A1ED2200-136D-477E-B1EC-E61E6B75931B@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-9-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
>=20
> If code reaches here, it's guaranteed that HPageVmemmapOptimized is =
set
> for the hugetlb page (or VM_BUG_ON_PAGE() will complain about it). =
It's

Hi Miaohe,

Right.

> unnecessary to set it again.

No, I suppose you didn=E2=80=99t test this patch since it does not work. =
The
HPageVmemmapOptimized is cleared in the above code of line
(set_page_private(page, 0)). So NAck.

Thanks,
Muchun

>=20
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> mm/hugetlb.c | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7934188bbed0..b432a00061e3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1520,7 +1520,6 @@ static void add_hugetlb_page(struct hstate *h, =
struct page *page,
>=20
> 	set_compound_page_dtor(page, HUGETLB_PAGE_DTOR);
> 	set_page_private(page, 0);
> -	SetHPageVmemmapOptimized(page);
>=20
> 	/*
> 	 * This page is about to be managed by the hugetlb allocator and
> --=20
> 2.23.0
>=20
>=20

