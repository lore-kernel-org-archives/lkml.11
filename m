Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2995BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 16:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348749AbiCKQ7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347005AbiCKQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:58:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F34EA1A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:57:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0EE921F37F;
        Fri, 11 Mar 2022 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1647017871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgYsa93xt0GY9NquD+Rifu92tu5q759OSHLEWka1V1c=;
        b=TAQ2zI2PEEPgL4weLoI8+rSAKd9ncxDYA80GxH7LiGLG3ppmFAxcisd/CDUFcyzAecXkDD
        tWyiBorYE8fJKwjvKvceGJ2ykToOgbJGYTOB66BqxqQwHclOcAIoouJAZAcyNRjwG/iXqn
        sc74fekLIRG3hVv83iND1rNbFIjXX20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1647017871;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgYsa93xt0GY9NquD+Rifu92tu5q759OSHLEWka1V1c=;
        b=7FyObfeCbchdfIZG8lS4jiAmsvDxu5WSuF1V/D7FuDpQNa4Ss8NuJPZV5+too1CH1nnP/Y
        mqh6P/EA1sV58MAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C554013A95;
        Fri, 11 Mar 2022 16:57:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id J5ulLo5/K2KuNQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 11 Mar 2022 16:57:50 +0000
Message-ID: <28aa571b-6dba-feb0-b888-4d18c9b0ffa1@suse.cz>
Date:   Fri, 11 Mar 2022 17:57:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/page_alloc: check high-order pages for corruption
 during PCP operations
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
References: <20220310092456.GJ15701@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220310092456.GJ15701@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 10:24, Mel Gorman wrote:
> Eric Dumazet pointed out that commit 44042b449872 ("mm/page_alloc: allow
> high-order pages to be stored on the per-cpu lists") only checks the head
> page during PCP refill and allocation operations. This was an oversight
> and all pages should be checked. This will incur a small performance
> penalty but it's necessary for correctness.
> 
> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Eric Dumazet <edumazet@google.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
