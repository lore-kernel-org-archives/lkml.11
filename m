Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DC8C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 May 2022 11:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiEWLTK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 May 2022 07:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiEWLTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:19:07 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9CA4339D
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 04:19:06 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L6FDJ6SpVz1JC8d;
        Mon, 23 May 2022 19:17:36 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 19:19:04 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 19:19:04 +0800
Message-ID: <36746fdd-4021-e491-f8cb-40e372439c67@huawei.com>
Date:   Mon, 23 May 2022 19:19:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4 0/2] arm64: Fix kcsan test_barrier fail and panic
Content-Language: en-US
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>
References: <20220523112641.170060-1-wangkefeng.wang@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220523112641.170060-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for using wrong script with uncorrected maintainers, please ignore.

On 2022/5/23 19:26, Kefeng Wang wrote:
> Fix selftest and kcsan_test() module fail when KCSAN_STRICT
> and KCSAN_WEAK_MEMORY enabled on ARM64.
>
> v4:
> - Use 2 spaces after a sentence-ending '.', suggested by Marco
> - Collect Ack/Review
>
> v3:
> - update dma_mb()'s description and add the generic definition,
>    also asm-generic change is moved into patch1, suggested by Marco.
> v2:
> - Add documents about dma_mb(), suggested by Mike and Will.
> - drop Fixes tag and update changlog, suggested by Mike.
>
>
> Kefeng Wang (2):
>    asm-generic: Add memory barrier dma_mb()
>    arm64: kcsan: Support detecting more missing memory barriers
>
>   Documentation/memory-barriers.txt | 11 ++++++-----
>   arch/arm64/include/asm/barrier.h  | 12 ++++++------
>   include/asm-generic/barrier.h     |  8 ++++++++
>   3 files changed, 20 insertions(+), 11 deletions(-)
>
