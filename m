Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721DFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 01:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiCGBoH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Mar 2022 20:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiCGBoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:44:05 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A282CCA0
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:43:11 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0V6OHnEM_1646617385;
Received: from 30.97.48.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V6OHnEM_1646617385)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 09:43:06 +0800
Message-ID: <44c79595-52d7-7ece-55a0-6efd022c8648@linux.alibaba.com>
Date:   Mon, 7 Mar 2022 09:44:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 09/16] mm/migration: remove some duplicated codes in
 migrate_pages
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ying.huang@intel.com, ziy@nvidia.com, minchan@kernel.org,
        apopple@nvidia.com, ave.hansen@linux.intel.com,
        o451686892@gmail.com, almasrymina@google.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-10-linmiaohe@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220304093409.25829-10-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/2022 5:34 PM, Miaohe Lin wrote:
> Remove the duplicated codes in migrate_pages to simplify the code. Minor
> readability improvement. No functional change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
