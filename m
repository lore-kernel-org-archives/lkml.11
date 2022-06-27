Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3B6C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiF0LGt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiF0LGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:06:46 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9D864CD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:06:44 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LWlJ51YrSzkWZx;
        Mon, 27 Jun 2022 19:05:25 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 19:06:43 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 27 Jun 2022 19:06:42 +0800
Message-ID: <3f99f9a1-5598-1c0a-b552-186ec6ff01ca@huawei.com>
Date:   Mon, 27 Jun 2022 19:06:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 0/6] arm64: Cleanup ioremap() and support
 ioremap_prot()
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
 <9a6e61da-0a5c-02bb-d769-98cf1f602de8@huawei.com>
In-Reply-To: <9a6e61da-0a5c-02bb-d769-98cf1f602de8@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/6/14 11:21, Kefeng Wang wrote:
> Hi Catalin, could you help to pick up it, thanks.
Kindly ping...
>
> On 2022/6/7 20:50, Kefeng Wang wrote:
>> 1. Enhance generic ioremap to make it more useful.
>> 2. Let's arm64 use GENERIC_IOREMAP to cleanup code.
>> 3. Support HAVE_IOREMAP_PROT on arm64, which enable 
>> generic_access_phys(),
>>     it is useful when debug(eg, gdb) via access_process_vm device memory
>>     infrastructure.
