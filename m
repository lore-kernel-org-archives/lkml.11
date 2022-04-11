Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95E10C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Apr 2022 10:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345650AbiDKKk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234711AbiDKKkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:40:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89D643EDB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:38:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6E03A1F38D;
        Mon, 11 Apr 2022 10:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649673518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOTb1DQ5T3tvzJWECRWfvUKR8Hc1CyPGEyTngR4bZGU=;
        b=Ru34jhYMJZ28HD9uShZ0rqtS66eZ5sAIcsHD+SzBFmIyk/qX2R1sU4hgL+AWBg2lWQM1n4
        EbrQBkjtYYl/SVUfFsgN7vIIwbgCNvz/HaDtMf6KHgvHBY24eK2N1kU6f2SEBCMZpxJ5UX
        VmfmX3DeX5wVZNVoRHg4T+2sJyZ6gC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649673518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EOTb1DQ5T3tvzJWECRWfvUKR8Hc1CyPGEyTngR4bZGU=;
        b=FebQQU7IOomtxeosFQW+9vaGx4X3kzFydI9IxxDIK/VgR/nK2Xf1opaeEvLHjzRqOjtzgm
        R2c3Mq8u67FdiDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 368B413AB5;
        Mon, 11 Apr 2022 10:38:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5mO6DC4FVGJYZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 11 Apr 2022 10:38:38 +0000
Message-ID: <888c1d6f-bdc7-2811-26cd-d8d46fdeb427@suse.cz>
Date:   Mon, 11 Apr 2022 12:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm/slub: remove meaningless node check in ___slab_alloc()
Content-Language: en-US
To:     JaeSang Yoo <js.yoo.5b@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Ohhoon Kwon <ohkwon1043@gmail.com>,
        Wonhyuk Yang <vvghjk1234@gmail.com>,
        Jiyoup Kim <lakroforce@gmail.com>,
        Donghyeok Kim <dthex5d@gmail.com>,
        JaeSang Yoo <jsyoo5b@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220409144239.2649257-1-jsyoo5b@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220409144239.2649257-1-jsyoo5b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/22 16:42, JaeSang Yoo wrote:
> node_match() with node=NUMA_NO_NODE always returns 1.
> Duplicate check by goto statement is meaningless. Remove it.
> 
> Signed-off-by: JaeSang Yoo <jsyoo5b@gmail.com>

Thanks, added.

> ---
>  mm/slub.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 9fe000fd19ca..a65e282b8238 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2913,7 +2913,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		 */
>  		if (!node_isset(node, slab_nodes)) {
>  			node = NUMA_NO_NODE;
> -			goto redo;
>  		} else {
>  			stat(s, ALLOC_NODE_MISMATCH);
>  			goto deactivate_slab;

