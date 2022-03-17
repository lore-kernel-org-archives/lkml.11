Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A50C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 01:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358295AbiCQBpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 21:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233661AbiCQBo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:44:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02BDDEF9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:43:41 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KJqdH1cJdzfYnp;
        Thu, 17 Mar 2022 09:42:11 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 09:43:39 +0800
Subject: Re: [PATCH] mm/swap: simplify the code of find_get_incore_page()
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220316075941.44816-1-linmiaohe@huawei.com>
 <YjHXHi6WGr9EA35D@casper.infradead.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7acda910-f29d-3cb1-456c-d63dbd80edd6@huawei.com>
Date:   Thu, 17 Mar 2022 09:43:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YjHXHi6WGr9EA35D@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/16 20:25, Matthew Wilcox wrote:
> On Wed, Mar 16, 2022 at 03:59:41PM +0800, Miaohe Lin wrote:
>> pagecache_get_page() can return subpage for us if we do not specify
>> FGP_HEAD. No functional change intended.
> 
> No, I'm converting this to folios soon.

This patch is based on linux-next-20220315 where pagecache_get_page is already
converted to folios. What you mean is find_get_incore_page will convert to folis
too soon? I'll continue to delay this patch anyway.

Thanks.

> 
> .
> 

