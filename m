Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D353EC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 11:31:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiGKLbg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 07:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbiGKLbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:31:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F076BC91
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:13:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LhLnd3g4XzlVtQ;
        Mon, 11 Jul 2022 19:12:21 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 11 Jul 2022 19:13:53 +0800
Subject: Re: [mm-unstable PATCH v5 4/8] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220708053653.964464-1-naoya.horiguchi@linux.dev>
 <20220708053653.964464-5-naoya.horiguchi@linux.dev>
 <3c66e7f6-e499-9802-409a-a32404fc87cc@huawei.com>
 <20220711092400.GA2741993@hori.linux.bs1.fc.nec.co.jp>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9e800b26-db85-f8a7-f268-3fb99a748cf1@huawei.com>
Date:   Mon, 11 Jul 2022 19:13:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220711092400.GA2741993@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/11 17:24, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Mon, Jul 11, 2022 at 03:09:01PM +0800, Miaohe Lin wrote:
...
> 
> Basically raw_hwp_info is not available to userspace (it might be recorded
> in dmesg but not available via /proc/kpageflags), so unpoisoning error
> subpages one-by-one is sometimes bothering.  If someone would like to
> unpoison one-by-one (I expect nobody would), I can do this.

I see. Many thanks for explanation.

> 
>> Thanks.
> 
> Thank you!
> 
> - Naoya Horiguchi
> 

