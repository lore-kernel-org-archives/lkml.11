Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380CDC43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 12:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231459AbiFWMHl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 08:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFWMHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:07:40 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75A04B436
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 05:07:39 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LTJs34MfZzDsLg;
        Thu, 23 Jun 2022 20:07:03 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 23 Jun 2022 20:07:37 +0800
Subject: Re: [PATCH 07/16] mm/huge_memory: minor cleanup for
 split_huge_pages_pid
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     <akpm@linux-foundation.org>, <shy828301@gmail.com>,
        <willy@infradead.org>, <zokeefe@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
 <20220622170627.19786-8-linmiaohe@huawei.com>
 <20220623032211.rvrtlas25u7nddpt@box.shutemov.name>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <cb3d564e-40f8-0ab9-683a-b6992081b91d@huawei.com>
Date:   Thu, 23 Jun 2022 20:07:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220623032211.rvrtlas25u7nddpt@box.shutemov.name>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/23 11:22, Kirill A. Shutemov wrote:
> On Thu, Jun 23, 2022 at 01:06:18AM +0800, Miaohe Lin wrote:
>> Use helper function vma_lookup to lookup the needed vma and use help macro
>> IS_ERR_OR_NULL to check the validity of page to simplify the code. Minor
>> readability improvement.
> 
> Grouping of changing seems random, but okay.

I group them because they belong to the same function. Should I split these two changes?

Many thanks for reviewing and comment!

> 

