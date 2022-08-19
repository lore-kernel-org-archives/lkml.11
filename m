Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDF9C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Aug 2022 09:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347766AbiHSJtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Aug 2022 05:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346902AbiHSJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:49:31 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E78C5720E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 02:49:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660902566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHuCigZsfkztHdHSAYo+Zt0I9v0bqgCkRJsF8FKNQeQ=;
        b=OdY2Q8zRcDEaSNIqqjQz2zryOYf+5hfNEydhyN3BQFFH/5F17XTv9oz1Gul/HYBfpDM/+c
        5Tb9Mu48inie189VI8LAwWjwW9ng5LIA6yGdQ8+WrUDjweDGb9b/iUrse22olrPyRzlA4O
        8JUtDnaIMbRthn6S0E2nawPnIapnTVM=
MIME-Version: 1.0
Subject: Re: [PATCH -next v2] bootmem: remove the vmemmap pages from kmemleak
 in put_page_bootmem
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220819094005.2928241-1-liushixin2@huawei.com>
Date:   Fri, 19 Aug 2022 17:49:20 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9B9B1BE4-3D6F-4D68-8741-8888AA2FEFB1@linux.dev>
References: <20220819094005.2928241-1-liushixin2@huawei.com>
To:     Liu Shixin <liushixin2@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 19, 2022, at 17:40, Liu Shixin <liushixin2@huawei.com> wrote:
>=20
> The vmemmap pages is marked by kmemleak when allocated from memblock.
> Remove it from kmemleak when free the page. Otherwise, when we reuse =
the
> page, kmemleak may report such an error and then stop working.
>=20
> kmemleak: Cannot insert 0xffff98fb6eab3d40 into the object search tree =
(overlaps existing)
> kmemleak: Kernel memory leak detector disabled
> kmemleak: Object 0xffff98fb6be00000 (size 335544320):
> kmemleak:   comm "swapper", pid 0, jiffies 4294892296
> kmemleak:   min_count =3D 0
> kmemleak:   count =3D 0
> kmemleak:   flags =3D 0x1
> kmemleak:   checksum =3D 0
> kmemleak:   backtrace:
>=20
> Fixes: f41f2ed43ca5 (mm: hugetlb: free the vmemmap pages associated =
with each HugeTLB page)
> Signed-off-by: Liu Shixin <liushixin2@huawei.com>

Thanks for fixing this.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

