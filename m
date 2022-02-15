Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84B4C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 12:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237945AbiBOMwE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 07:52:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiBOMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 07:52:02 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655E61AF2A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 04:51:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B21DB210F3;
        Tue, 15 Feb 2022 12:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644929510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S+8iMfkRRARGsD0orx9twPu99T6CLgm/4CL4ZhfS0rw=;
        b=fuLzBF4iSfHcrO3zcdBZEWw0azxcjUdoUt9/4J7kSwK1gI24ykuvkR6JOT92xmTG/fFrrx
        hC6IDAZzNR9/tORNVdSzueyco1r27Dk8/Dqpcj12DqADUlNhMCyPShG7Z4krv4jLGIPd6x
        K5PqWOeWa83OHa7+qRtCsa/F9Ki0a1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644929510;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S+8iMfkRRARGsD0orx9twPu99T6CLgm/4CL4ZhfS0rw=;
        b=WQkgFac5adSqfl8qFiozrYraCigy7JEgbNDLsXdtZK3k4DS2+O3UolPQ1fyNtbBldO2BrK
        qfnHyR6BNvWryNCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 16D6C13C75;
        Tue, 15 Feb 2022 12:51:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DnguAuahC2I+bAAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 15 Feb 2022 12:51:50 +0000
Date:   Tue, 15 Feb 2022 13:51:48 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm: clean up hwpoison page cache page in fault path
Message-ID: <Yguh5JUGHln/iRJ8@localhost.localdomain>
References: <20220212213740.423efcea@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212213740.423efcea@imladris.surriel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2022 at 09:37:40PM -0500, Rik van Riel wrote:
> Sometimes the page offlining code can leave behind a hwpoisoned clean
> page cache page. This can lead to programs being killed over and over
> and over again as they fault in the hwpoisoned page, get killed, and
> then get re-spawned by whatever wanted to run them.

Hi Rik,

Do you know how that exactly happens? We should not be really leaving
anything behind, and soft-offline (not hard) code works with the premise
of only poisoning a page in case it was contained, so I am wondering
what is going on here.

In-use pagecache pages are migrated away, and the actual page is
contained, and for clean ones, we already do the invalidate_inode_page()
and then contain it in case we succeed.

One scenario I can imagine this can happen is if by the time we call
page_handle_poison(), someone has taken another refcount on the page,
and the put_page() does not really free it, but I am not sure that
can happen.

-- 
Oscar Salvador
SUSE Labs
