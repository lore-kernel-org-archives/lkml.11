Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207B9ECAAD1
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Sep 2022 08:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbiIAIAl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Sep 2022 04:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbiIAIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:00:31 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA2449B5E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:00:29 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJCz65KDgzYcyj;
        Thu,  1 Sep 2022 15:56:02 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 16:00:27 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 1 Sep 2022 16:00:26 +0800
Message-ID: <584e63c2-2574-ea2b-55c4-da5e2cd08868@huawei.com>
Date:   Thu, 1 Sep 2022 16:00:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: remove BUG_ON() in __isolate_free_page()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>
References: <20220901015043.189276-1-wangkefeng.wang@huawei.com>
 <ff5ccb8b-adc7-8d74-6693-0e94785084a2@redhat.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ff5ccb8b-adc7-8d74-6693-0e94785084a2@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/9/1 15:37, David Hildenbrand wrote:
> On 01.09.22 03:50, Kefeng Wang wrote:
>> Drop unneed comment and blank, adjust the variable, and the most
>> important is to delete BUG_ON(). The page passed is always buddy
>> page into __isolate_free_page() from compaction, page_isolation
>> and page_reporting, and the caller also check the return, BUG_ON()
>> is a too drastic measure, remove it.
> Why not WARN_ON_ONCE then? But yeah, maybe this really isn't of any
> value anymore.

or VM_WARN_ON()， but I think this bug_on is useless after check all 
calllers,

so let's drop it if no objection.

