Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2DDCCA473
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 03:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358151AbiFPDWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 23:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349947AbiFPDV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:21:59 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A85AA5C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:21:58 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LNnV54cM1z1K9QT;
        Thu, 16 Jun 2022 11:19:57 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 16 Jun 2022 11:21:56 +0800
Subject: Re: [PATCH] mm/page_alloc: make calling prep_compound_head more
 reliable
To:     Matthew Wilcox <willy@infradead.org>
CC:     Joao Martins <joao.m.martins@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20220607144157.36411-1-linmiaohe@huawei.com>
 <20220607113257.84b1bdd993f19be26b8c4944@linux-foundation.org>
 <65e5da9c-32d1-17d7-d8c6-96cbfac23fec@oracle.com>
 <4a30f026-789a-9235-2fbd-f553e4d7b45d@huawei.com>
 <YqiJaOiGnUzzB1+W@casper.infradead.org>
 <40a07ce5-414a-a3b8-53ee-6c348635f03a@huawei.com>
 <YqnTtGDt+NdQ3Jxf@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1483de08-321c-41da-e098-8defd6ae4f11@huawei.com>
Date:   Thu, 16 Jun 2022 11:21:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YqnTtGDt+NdQ3Jxf@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/15 20:42, Matthew Wilcox wrote:
> On Wed, Jun 15, 2022 at 03:44:06PM +0800, Miaohe Lin wrote:
>>> We definitely don't need the unlikely here.
>>
>> Could you please give me a more detailed explanation? IIUC, the above if condition
>> will only meet at a probability of 1/512. So unlikely tells the compiler to do some
>> optimization around it. Or am I miss something?
> 
> Only add unlikely() when the compiler can't figure out for itself that
> it's unlikely.  You should also check the generated code and/or
> benchmark the results to be sure that it's actually an improvement.
> Using unlikely() needs to be backed up with more than just a feeling.

I see. Many thanks for clarifying. Will keep it in mind. :)

> 
> .
> 

