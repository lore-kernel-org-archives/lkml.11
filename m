Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EA5C4332F
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 15:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiCNPXr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242114AbiCNPWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:22:51 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428783D482
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:21:38 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:46148)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nTmVs-001pwi-O2; Mon, 14 Mar 2022 09:21:36 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37680 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nTmVr-003ci5-Gz; Mon, 14 Mar 2022 09:21:36 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <hughd@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>
References: <20220314064039.62972-1-linmiaohe@huawei.com>
Date:   Mon, 14 Mar 2022 10:21:10 -0500
In-Reply-To: <20220314064039.62972-1-linmiaohe@huawei.com> (Miaohe Lin's
        message of "Mon, 14 Mar 2022 14:40:39 +0800")
Message-ID: <87h78036hl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nTmVr-003ci5-Gz;;;mid=<87h78036hl.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+M0LAEcOvb6LWyXxgtrZneXmnp61b93Kw=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v2] mm/mlock: fix potential imbalanced rlimit ucounts
 adjustment
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> user_shm_lock forgets to set allowed to 0 when get_ucounts fails. So
> the later user_shm_unlock might do the extra dec_rlimit_ucounts. Fix
> this by resetting allowed to 0.

This fix looks correct.  But the ability for people to follow and read
the code seems questionable.  I saw in v1 of this patch Hugh originally
misread the logic.

Could we instead change the code to leave lock_limit at ULONG_MAX aka
RLIM_INFINITY, leave initialized to 0, and not even need a special case
of RLIM_INFINITY as nothing can be greater that ULONG_MAX?

Something like this?

diff --git a/mm/mlock.c b/mm/mlock.c
index 8f584eddd305..e7eabf5193ab 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -827,13 +827,12 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
 
 	locked = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	lock_limit = rlimit(RLIMIT_MEMLOCK);
-	if (lock_limit == RLIM_INFINITY)
-		allowed = 1;
-	lock_limit >>= PAGE_SHIFT;
+	if (lock_limit != RLIM_INFINITY)
+		lock_limit >>= PAGE_SHIFT;
 	spin_lock(&shmlock_user_lock);
 	memlock = inc_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 
-	if (!allowed && (memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
+	if ((memlock == LONG_MAX || memlock > lock_limit) && !capable(CAP_IPC_LOCK)) {
 		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
 		goto out;
 	}

>
> Fixes: d7c9e99aee48 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Acked-by: Hugh Dickins <hughd@google.com>
> ---
> v1->v2:
>   correct Fixes tag and collect Acked-by tag
>   Thanks Hugh for review!
> ---
>  mm/mlock.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/mlock.c b/mm/mlock.c
> index 29372c0eebe5..efd2dd2943de 100644
> --- a/mm/mlock.c
> +++ b/mm/mlock.c
> @@ -733,6 +733,7 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
>  	}
>  	if (!get_ucounts(ucounts)) {
>  		dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, locked);
> +		allowed = 0;
>  		goto out;
>  	}
>  	allowed = 1;

Eric
