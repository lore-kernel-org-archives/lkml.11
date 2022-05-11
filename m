Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4374C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 17:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345592AbiEKRcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 13:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244493AbiEKRcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 13:32:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2775F27D;
        Wed, 11 May 2022 10:32:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AE53121ADB;
        Wed, 11 May 2022 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652290339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iRo/JDHV83EB1h5pdBZIrd5z5XjhjDpQVXb7V6F3I4c=;
        b=FLBQObsLAEcY1qpKL38af29Yq0wE5hD1t6hpXBKrsjw/zDf/yEb/cDp9ZNEOMN8w4SPm60
        AgtXFg88C6KZG4n9p82BaD1+UyjiAcfUKlsB311c6+IxZVDjcBajaOIy4ZipojjeWOK08I
        MY8p2vDpruhAjP8jbUES1EHuqm4bnw8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7205A139F9;
        Wed, 11 May 2022 17:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ck3nGiPze2IGZgAAMHmgww
        (envelope-from <mkoutny@suse.com>); Wed, 11 May 2022 17:32:19 +0000
Date:   Wed, 11 May 2022 19:32:18 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
Message-ID: <20220511173218.GB31592@blackbody.suse.cz>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-7-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510152847.230957-7-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Tue, May 10, 2022 at 11:28:47AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> +void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> +
> +	/* PF_MEMALLOC context, charging must succeed */
> +	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
> +		VM_WARN_ON_ONCE(1);

IIUC, the objcg is derived from the compressed page, i.e. same memcg
(reparenting neglected for now). This memcg's memory.current is then
charged with the compressed object size.

Do I get it right that memory.zswap.current is a subset of memory.current?

(And that zswap is limited both by memory.max and memory.zswap.max?)

Thanks,
Michal
