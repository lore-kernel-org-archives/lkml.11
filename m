Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B68C43334
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Jul 2022 11:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237577AbiGHLNf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Jul 2022 07:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237755AbiGHLNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:13:31 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE981EB5
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 04:13:28 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LfVxJ50MKzpWDD;
        Fri,  8 Jul 2022 19:12:36 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 19:13:10 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 8 Jul 2022 19:13:10 +0800
Subject: Re: [PATCH -next v2] ubifs: Fix some kernel-doc comments
To:     Yang Li <yang.lee@linux.alibaba.com>, <richard@nod.at>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Abaci Robot" <abaci@linux.alibaba.com>
References: <20220602065556.104006-1-yang.lee@linux.alibaba.com>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <d2dd33fb-8a7c-a883-0175-4d2d531c397d@huawei.com>
Date:   Fri, 8 Jul 2022 19:13:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220602065556.104006-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2022/6/2 14:55, Yang Li Ð´µÀ:
> Remove warnings found by running scripts/kernel-doc,
> which is caused by using 'make W=1'.
> fs/ubifs/journal.c:1221: warning: Function parameter or member
> 'old_inode' not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Function parameter or member 'old_nm'
> not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Function parameter or member
> 'new_inode' not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Function parameter or member 'new_nm'
> not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Function parameter or member
> 'whiteout' not described in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Excess function parameter 'old_dentry'
> description in 'ubifs_jnl_rename'
> fs/ubifs/journal.c:1221: warning: Excess function parameter 'new_dentry'
> description in 'ubifs_jnl_rename'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
>   fs/ubifs/journal.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> index 75dab0ae3939..61f72a557655 100644
> --- a/fs/ubifs/journal.c
> +++ b/fs/ubifs/journal.c
> @@ -1201,9 +1201,13 @@ int ubifs_jnl_xrename(struct ubifs_info *c, const struct inode *fst_dir,
>    * ubifs_jnl_rename - rename a directory entry.
>    * @c: UBIFS file-system description object
>    * @old_dir: parent inode of directory entry to rename
> - * @old_dentry: directory entry to rename
> + * @old_inode: directory entry's inode to rename
> + * @old_nm: name of the old directory entry to rename
>    * @new_dir: parent inode of directory entry to rename
> - * @new_dentry: new directory entry (or directory entry to replace)
> + * @new_inode: new directory entry's inode (or directory entry's inode to
> + *		replace)
> + * @new_nm: new name of the new directory entry
> + * @whiteout: whiteout inode
>    * @sync: non-zero if the write-buffer has to be synchronized
>    *
>    * This function implements the re-name operation which may involve writing up
> 

