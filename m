Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9FBC38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 12:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235595AbiIBMSj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIBMSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:18:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4325CEB2F
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 05:18:34 -0700 (PDT)
Received: from fraeml706-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MJxkg4gLFz6J69C;
        Fri,  2 Sep 2022 20:17:47 +0800 (CST)
Received: from lhrpeml500003.china.huawei.com (7.191.162.67) by
 fraeml706-chm.china.huawei.com (10.206.15.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.31; Fri, 2 Sep 2022 14:18:32 +0200
Received: from [10.195.34.23] (10.195.34.23) by lhrpeml500003.china.huawei.com
 (7.191.162.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 2 Sep
 2022 13:18:31 +0100
Message-ID: <e8b232be-dfe9-0a67-c464-83fe5109070e@huawei.com>
Date:   Fri, 2 Sep 2022 13:18:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 0/3] iova: Some misc changes
From:   John Garry <john.garry@huawei.com>
To:     <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>
CC:     <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
 <11d9f054-fe7b-7646-a8f4-7d45a22e2a96@huawei.com>
In-Reply-To: <11d9f054-fe7b-7646-a8f4-7d45a22e2a96@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.34.23]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500003.china.huawei.com (7.191.162.67)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 11:24, John Garry wrote:
> On 17/08/2022 11:09, John Garry wrote:
>> This series includes:
>> - remove checks in the code which are not required
>> - the re-org, which I had originally posted separately
> 
> BTW, Can we drop the !IOMMU_IOVA stubs in iova.h? I could not find a 
> kernel config which actually exercises that code (so testing changes 
> there is difficult).

Any thoughts on this? Since I got no review of patch #3 I assume that it 
is not keenly welcome either.

Now I think that I'll just post a new version with patches #1 and #2 so 
that they don't get lost in limbo.

Thanks,
John
