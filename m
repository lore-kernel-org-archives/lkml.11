Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC36C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Mar 2022 05:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiCQFkv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 01:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCQFku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 01:40:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BA0D3732
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:10:52 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KJtPz3ydZz1GCM8;
        Thu, 17 Mar 2022 11:47:35 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 11:52:34 +0800
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 11:52:34 +0800
Message-ID: <ef12136f-fc4d-05c5-a7bd-66ade28957e4@huawei.com>
Date:   Thu, 17 Mar 2022 11:52:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH -next] bus: mhi: ep: remove useless judgement in
 mhi_ep_ring_add_element
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
CC:     <manivannan.sadhasivam@linaro.org>, <liwei391@huawei.com>
References: <20220317033117.367027-1-liaoyu15@huawei.com>
From:   Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20220317033117.367027-1-liaoyu15@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Manivannan, I found that 'ret = ' has been removed. If this is intentional,
the check of 'ret' is redundant.

Thanks,

Yu
On 2022/3/17 11:31, Yu Liao wrote:
> Remove the check of 'ret' that is impossible to be non-zero.
> 
> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
> ---
>  drivers/bus/mhi/ep/ring.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
> index ac2043e71943..161505cd628f 100644
> --- a/drivers/bus/mhi/ep/ring.c
> +++ b/drivers/bus/mhi/ep/ring.c
> @@ -131,8 +131,6 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
>  
>  	mhi_cntrl->write_to_host(mhi_cntrl, (void __iomem *)el, ring->rbase + (old_offset *
>  				 sizeof(*el)), sizeof(*el));
> -	if (ret < 0)
> -		return ret;
>  
>  	return 0;
>  }
