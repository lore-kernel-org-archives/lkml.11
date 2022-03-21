Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD045C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 01:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344091AbiCUBvk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242733AbiCUBvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:51:39 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A7C10E042
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 18:50:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V7h.VvQ_1647827408;
Received: from 30.225.24.50(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V7h.VvQ_1647827408)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 21 Mar 2022 09:50:10 +0800
Message-ID: <abcbf5d2-c348-7dc0-cfd3-9bcc6431bc64@linux.alibaba.com>
Date:   Mon, 21 Mar 2022 09:50:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH] ocfs2: fix check if list iterator did find an element
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Mark Fasheh <mark@fasheh.com>
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220319203106.2541700-1-jakobkoschel@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220319203106.2541700-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/20/22 4:31 AM, Jakob Koschel wrote:
> Instead of setting 'res' to NULL, it should only be set if
> the suitable element was found.
> 
> In the original code 'res' would have been set to an incorrect pointer
> if the list is empty.
> 
The logic before iteration can make sure track_list won't be empty.
Please refer the discussion via:
https://lore.kernel.org/ocfs2-devel/bd0ec87e-b490-83dc-2363-5e5342c59fa4@linux.alibaba.com/T/#m96d4397930201d83d68677c33a9721ae8dbd8f15

Thanks,
Joseph

> In preparation to limit the scope of the list iterator to the list
> traversal loop, use a dedicated pointer pointing to the found element [1].
> 
> Link: https://lore.kernel.org/all/YhdfEIwI4EdtHdym@kroah.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  fs/ocfs2/dlm/dlmdebug.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
> index d442cf5dda8a..be5e9ed7da8d 100644
> --- a/fs/ocfs2/dlm/dlmdebug.c
> +++ b/fs/ocfs2/dlm/dlmdebug.c
> @@ -541,7 +541,7 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
>  	struct debug_lockres *dl = m->private;
>  	struct dlm_ctxt *dlm = dl->dl_ctxt;
>  	struct dlm_lock_resource *oldres = dl->dl_res;
> -	struct dlm_lock_resource *res = NULL;
> +	struct dlm_lock_resource *res = NULL, *iter;
>  	struct list_head *track_list;
> 
>  	spin_lock(&dlm->track_lock);
> @@ -556,11 +556,11 @@ static void *lockres_seq_start(struct seq_file *m, loff_t *pos)
>  		}
>  	}
> 
> -	list_for_each_entry(res, track_list, tracking) {
> -		if (&res->tracking == &dlm->tracking_list)
> -			res = NULL;
> -		else
> -			dlm_lockres_get(res);
> +	list_for_each_entry(iter, track_list, tracking) {
> +		if (&iter->tracking != &dlm->tracking_list) {
> +			dlm_lockres_get(iter);
> +			res = iter;
> +		}
>  		break;
>  	}
>  	spin_unlock(&dlm->track_lock);
> 
> base-commit: 34e047aa16c0123bbae8e2f6df33e5ecc1f56601
> --
> 2.25.1
