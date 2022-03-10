Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45941C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 17:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbiCJRVO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 12:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiCJRVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:21:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5341918DABD
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:20:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EB4AD1F381;
        Thu, 10 Mar 2022 17:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646932810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2qHs0Wjl9zJzGdGxDrgMP6oGxVwLROgKQ2hwHB4Zl0=;
        b=cJWyOjQ/cay6MLEYucd1t8/5qgEOabdfrwDOkZM9KeHEfZn+gPWqf5IETP5D4hgIQSKgQP
        SOSHdPu3j4DosiKwQ+PY5jHuAzB6vhawjN6yvWs6EpSloZXin+pjF3w1/nQXl/QWnaVuS+
        xQOx2AwY2i1AtdoFo+6kpAvVILSnM/Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646932810;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2qHs0Wjl9zJzGdGxDrgMP6oGxVwLROgKQ2hwHB4Zl0=;
        b=IB7kr07EZbKhyhiioW1RbT1MKzjN0sJDozOhy8mg9LKuqmOPxqbWH+iqa6BUXOJB/qKUHG
        KNZQOTJJzYudviAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5DB313A66;
        Thu, 10 Mar 2022 17:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id vQSfK0ozKmKgLgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 10 Mar 2022 17:20:10 +0000
Message-ID: <e36be28d-b4a3-966e-e067-0942784485ac@suse.cz>
Date:   Thu, 10 Mar 2022 18:20:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 0/2] Cleanups for slab
Content-Language: en-US
To:     sxwjean@me.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, longman@redhat.com, guro@fb.com,
        willy@infradead.org, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
References: <20220310140701.87908-1-sxwjean@me.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220310140701.87908-1-sxwjean@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 15:06, sxwjean@me.com wrote:
> From: Xiongwei Song <sxwjean@gmail.com>
> 
> 2 cleanups, no functionality changed.

Thanks, added to slab for-next

> ---
> Since v2:
>  - Add the detailed history of parameter @s of alloc_slab_page(),
>    message from Matthew Wilcox.
>  - Collect Reviewed-by and Acked-by. Thanks Matthew Wilcox, David Rientjes
>    and Roman Gushchin.
> 
> Since v1:
>  - https://lore.kernel.org/all/20220309145052.219138-1-sxwjean@me.com/
> ---
> 
> Xiongwei Song (2):
>   mm: slab: Delete unused SLAB_DEACTIVATED flag
>   mm: slub: Delete useless parameter of alloc_slab_page()
> 
>  include/linux/slab.h | 3 ---
>  mm/slub.c            | 8 ++++----
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 

