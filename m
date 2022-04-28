Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C7C433FE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Apr 2022 12:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346616AbiD1MuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Apr 2022 08:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245277AbiD1MuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:50:14 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3472B37A94;
        Thu, 28 Apr 2022 05:46:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=mqaio@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VBazM0Q_1651150011;
Received: from 30.225.28.125(mailfrom:mqaio@linux.alibaba.com fp:SMTPD_---0VBazM0Q_1651150011)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 28 Apr 2022 20:46:52 +0800
Message-ID: <5c641c77-f96d-4e75-ebc5-eef66cf0dbdc@linux.alibaba.com>
Date:   Thu, 28 Apr 2022 20:46:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH net-next] hinic: fix bug of wq out of bound access
From:   maqiao <mqaio@linux.alibaba.com>
To:     luobin9@huawei.com, davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        pabeni@redhat.com, huangguangbin2@huawei.com,
        keescook@chromium.org, gustavoars@kernel.org
References: <282817b0e1ae2e28fdf3ed8271a04e77f57bf42e.1651148587.git.mqaio@linux.alibaba.com>
In-Reply-To: <282817b0e1ae2e28fdf3ed8271a04e77f57bf42e.1651148587.git.mqaio@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc Paolo Abeni, Guangbin Huang, Kees Cook, Gustavo A. R. Silva

在 2022/4/28 PM8:30, Qiao Ma 写道:
> If wq has only one page, we need to check wqe rolling over page by
> compare end_idx and curr_idx, and then copy wqe to shadow wqe to
> avoid out of bound access.
> This work has been done in hinic_get_wqe, but missed for hinic_read_wqe.
> This patch fixes it, and removes unnecessary MASKED_WQE_IDX().
> 
> Fixes: 7dd29ee12865 ("hinic: add sriov feature support")
> Signed-off-by: Qiao Ma <mqaio@linux.alibaba.com>
> ---
>   drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
> index 5dc3743f8091..f04ac00e3e70 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_wq.c
> @@ -771,7 +771,7 @@ struct hinic_hw_wqe *hinic_get_wqe(struct hinic_wq *wq, unsigned int wqe_size,
>   	/* If we only have one page, still need to get shadown wqe when
>   	 * wqe rolling-over page
>   	 */
> -	if (curr_pg != end_pg || MASKED_WQE_IDX(wq, end_prod_idx) < *prod_idx) {
> +	if (curr_pg != end_pg || end_prod_idx < *prod_idx) {
>   		void *shadow_addr = &wq->shadow_wqe[curr_pg * wq->max_wqe_size];
>   
>   		copy_wqe_to_shadow(wq, shadow_addr, num_wqebbs, *prod_idx);
> @@ -841,7 +841,10 @@ struct hinic_hw_wqe *hinic_read_wqe(struct hinic_wq *wq, unsigned int wqe_size,
>   
>   	*cons_idx = curr_cons_idx;
>   
> -	if (curr_pg != end_pg) {
> +	/* If we only have one page, still need to get shadown wqe when
> +	 * wqe rolling-over page
> +	 */
> +	if (curr_pg != end_pg || end_cons_idx < curr_cons_idx) {
>   		void *shadow_addr = &wq->shadow_wqe[curr_pg * wq->max_wqe_size];
>   
>   		copy_wqe_to_shadow(wq, shadow_addr, num_wqebbs, *cons_idx);
