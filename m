Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D46FC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 10:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiCVKzm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiCVKzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:55:40 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAACDFD2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:54:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0V7vuOEs_1647946447;
Received: from 30.225.24.67(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V7vuOEs_1647946447)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 22 Mar 2022 18:54:08 +0800
Message-ID: <47807b41-566c-f0b6-831c-658abd60861c@linux.alibaba.com>
Date:   Tue, 22 Mar 2022 18:54:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v2] ocfs2: remove usage of list iterator variable after
 the loop body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Mark Fasheh <mark@fasheh.com>
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        Joel Becker <jlbec@evilplan.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220322105014.3626194-1-jakobkoschel@gmail.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20220322105014.3626194-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/22/22 6:50 PM, Jakob Koschel wrote:
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
> 
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Looks good to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

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
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
