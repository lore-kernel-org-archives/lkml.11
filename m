Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29C6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 11:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357645AbiBHL0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347904AbiBHKMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:12:19 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B9C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:12:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3A7A51F37C;
        Tue,  8 Feb 2022 10:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644315137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqwBMSaQFzyUIyxqXWmPp13Hp0jtduJNpkZuJ0rwnFQ=;
        b=L8UEVSKrQ+rwY8lgCeT7VNpSH9dnsBm2lWoqMAicLVEGJRxsw1nRjHrmqWEI79ExAcI1zf
        QL6FhrdpkLc3LXFECxdSTUNRD/oiaUQrOpJ5PtAqGqfCzgK0sYAxfwBJII5cJ6RFBo8wIl
        IHSGKLkF1/yHlgTSxE02U5fPUaV5RWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644315137;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iqwBMSaQFzyUIyxqXWmPp13Hp0jtduJNpkZuJ0rwnFQ=;
        b=rIsf6VLKCCJrrC+ErRWJ7PjbiCvTnYtgraF2EvIV0dQNmx66ENmqDFm/32/dw8BdqGqJeK
        H/ydq8F704YnjbBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B916313BF9;
        Tue,  8 Feb 2022 10:12:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PgObKABCAmJDcgAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 08 Feb 2022 10:12:16 +0000
Date:   Tue, 8 Feb 2022 11:12:14 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/memory_hotplug: fix misplaced comment in
 offline_pages
Message-ID: <YgJB/kxe0FU1x/tq@localhost.localdomain>
References: <20220207133643.23427-1-linmiaohe@huawei.com>
 <20220207133643.23427-5-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207133643.23427-5-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:36:43PM +0800, Miaohe Lin wrote:
> It's misplaced since commit 7960509329c2 ("mm, memory_hotplug: print reason
> for the offlining failure"). Move it to the right place.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4b9eef861ee4..7dc7e12302db 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1966,6 +1966,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	return 0;
>  
>  failed_removal_isolated:
> +	/* pushback to free area */
>  	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
>  	memory_notify(MEM_CANCEL_OFFLINE, &arg);
>  failed_removal_pcplists_disabled:
> @@ -1976,7 +1977,6 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  		 (unsigned long long) start_pfn << PAGE_SHIFT,
>  		 ((unsigned long long) end_pfn << PAGE_SHIFT) - 1,
>  		 reason);
> -	/* pushback to free area */
>  	mem_hotplug_done();
>  	return ret;
>  }
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
