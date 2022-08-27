Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9450CECAAD4
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 01:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbiH0B3A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 21:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiH0B25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:28:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C580CE68C8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:28:55 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MDzYz4THMznTj7;
        Sat, 27 Aug 2022 09:26:31 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 09:28:53 +0800
Received: from [10.174.176.52] (10.174.176.52) by
 kwepemm600015.china.huawei.com (7.193.23.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 09:28:52 +0800
Message-ID: <1636796c-c85e-7f47-e96f-e074fee3c7d3@huawei.com>
Date:   Sat, 27 Aug 2022 09:28:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] ntfs: change check order in ntfs_attr_find
To:     Hawkins Jiawei <yin31149@gmail.com>,
        <syzbot+5f8dcabe4a3b2c51c607@syzkaller.appspotmail.com>,
        Anton Altaparmakov <anton@tuxera.com>
CC:     <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-ntfs-dev@lists.sourceforge.net>,
        <syzkaller-bugs@googlegroups.com>
References: <0000000000006886bd05e714ec18@google.com>
 <20220826122735.2690-1-yin31149@gmail.com>
From:   "chenxiaosong (A)" <chenxiaosong2@huawei.com>
In-Reply-To: <20220826122735.2690-1-yin31149@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.52]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/26 20:27, Hawkins Jiawei 写道:
> syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> 
> Looks like it is improper check order that causes this bug.
> 
> Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
> ---
>   fs/ntfs/attrib.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index 52615e6090e1..6480cd2d371d 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -594,10 +594,11 @@ static int ntfs_attr_find(const ATTR_TYPE type, const ntfschar *name,
>   	for (;;	a = (ATTR_RECORD*)((u8*)a + le32_to_cpu(a->length))) {
>   		u8 *mrec_end = (u8 *)ctx->mrec +
>   		               le32_to_cpu(ctx->mrec->bytes_allocated);
> +		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)
> +			break;
>   		u8 *name_end = (u8 *)a + le16_to_cpu(a->name_offset) +
>   			       a->name_length * sizeof(ntfschar);
> -		if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end ||
> -		    name_end > mrec_end)
> +		if (name_end > mrec_end)
>   			break;
>   		ctx->attr = a;
>   		if (unlikely(le32_to_cpu(a->type) > le32_to_cpu(type) ||
> 

The reason is that a->length is 0, it will occur uaf when deref any 
field of ATTR_RECORD.

It seems that changing check order will not fix root cause, if the 
condition "if ((u8*)a < (u8*)ctx->mrec || (u8*)a > mrec_end)" is false, 
uaf will still occur.

Do you have any thoughts on this ?
