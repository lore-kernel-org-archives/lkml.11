Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C554C433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Feb 2022 15:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237676AbiB1PzU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 10:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiB1PzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:55:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A188526106
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:54:39 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 31566218BB;
        Mon, 28 Feb 2022 15:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646063678; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVRCJf7zWHZzY2nfFgkpXiT7Br9L3lNouIbRBf2LbLc=;
        b=iK8F0uqrxoBBMPClQF1HDAV9OghJKvD0Ri6MeQfjtQHkvcCujif7fyZYNZo54LEBH+SMew
        QXNrERmjodXTK8xTnZEDNE/fp/pP7utSKdKlFIVdzR8heNCfPBXBR3CpGl7k6UfHgm/O9K
        qhdETDFdgKeG8DWKfPKE+ll1a6Iirk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646063678;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zVRCJf7zWHZzY2nfFgkpXiT7Br9L3lNouIbRBf2LbLc=;
        b=VxyOKdNNag/xVoTtys+9IAojlmZhFBbJv/LAyDKEAGATEhKeEpRZjFbKClUCLYCNTliEPA
        0TIQ7fZ/Wf8g//Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2625113C68;
        Mon, 28 Feb 2022 15:54:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AJ1fBj3wHGInBAAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 28 Feb 2022 15:54:37 +0000
Date:   Mon, 28 Feb 2022 16:54:35 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH -V13 2/3] NUMA balancing: optimize page placement for
 memory tiering system
Message-ID: <YhzwO/lw1xx7EjNb@localhost.localdomain>
References: <20220221084529.1052339-1-ying.huang@intel.com>
 <20220221084529.1052339-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221084529.1052339-3-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:45:28PM +0800, Huang Ying wrote:
> b. Make kswapd of the fast memory node to reclaim pages until the free
>    pages are a little more than the high watermark (named as promo
>    watermark).  Then, if the free pages of the fast memory node reaches
>    high watermark, and some hot pages need to be promoted, kswapd of the
>    fast memory node will be waken up to demote more cold pages in the
>    fast memory node to the slow memory node.  This will free some extra
>    space in the fast memory node, so the hot pages in the slow memory
>    node can be promoted to the fast memory node.

The patch looks good to me, but I think I might be confused by the wording
here.

IIUC, we define a new wmark (wmark_promo) which is higher than
wmark_high.
When we cannot migrate a page to another numa node because it has less
than wmark_high free pages, we wake up kswapd, and we keep reclaiming
until we either have mark_promo pages free when
NUMA_BALANCING_MEMORY_TIERING, or mark_high pages free. Is that right?

Because above you say "Then, if the free pages of the fast memory node reaches
high watermark, and some hot pages need to be promoted..."

but that should read promo watermark instead? Am I missing something?

-- 
Oscar Salvador
SUSE Labs
