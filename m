Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 124F1C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 12:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358369AbiBUMzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 07:55:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiBUMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:55:17 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCAE1C10F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:54:54 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ED913210F0;
        Mon, 21 Feb 2022 12:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645448092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iS9TB+9bv2dpVoCm6dvoUUoXX7bo60stwGrwBo5dMNU=;
        b=aVw5Npw7aazaQTjASzY+jOYJ0yq5iu1fgcvlaMMEwj/i4COLTzocA6HNcYbnJTx2Oz5ZRV
        dr5ODB9pD43QAfjEnC5uKc5Z2bZnY1EdCjq/wz07bE38n+nSAT8dTKSx3URVeE4P/K8cGi
        z8OI5XrCMe6VJNTVAL+Xf+tsQCkSC8g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645448092;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iS9TB+9bv2dpVoCm6dvoUUoXX7bo60stwGrwBo5dMNU=;
        b=IpjMOS8urfYewEgNnbCyfHGZkNwQglOdbWRvL0JBNJQbM9LWEn2QC5g4BOuSOfIayj/X0y
        uYbymLkyRnG9QLDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EF2113AD5;
        Mon, 21 Feb 2022 12:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8aVLGJyLE2IgcgAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 21 Feb 2022 12:54:52 +0000
Date:   Mon, 21 Feb 2022 13:54:50 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Message-ID: <YhOLmvLKOCO0qDIe@localhost.localdomain>
References: <20220212213740.423efcea@imladris.surriel.com>
 <Yguh5JUGHln/iRJ8@localhost.localdomain>
 <e6eeb84f-cf1d-493e-ce8e-fea6f3679a9e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6eeb84f-cf1d-493e-ce8e-fea6f3679a9e@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 10:13:14AM +0800, Miaohe Lin wrote:
> IIUC, this could not happen when soft-offlining a pagecache page. They're either
> invalidated or migrated away and then we set PageHWPoison.
> I think this may happen on a clean pagecache page when it's isolated. So it's !PageLRU.
> And identify_page_state treats it as me_unknown because it's non reserved, slab, swapcache
> and so on ...(see error_states for details). Or am I miss anything?

But the path you are talking about is when we do have a non-recoverable
error, so memory_failure() path.
AFAIU, Rik talks about pages with corrected errors, and that is
soft_offline().

-- 
Oscar Salvador
SUSE Labs
