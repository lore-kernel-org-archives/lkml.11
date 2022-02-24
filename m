Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E8AC4332F
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 12:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbiBXMtU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 07:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234490AbiBXMtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 07:49:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294151E2FC0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 04:48:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD3E22114E;
        Thu, 24 Feb 2022 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645706927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqhrZTZ5oMSeZ6sL+jtWqsF+SeNGe07XiBRm/i340v8=;
        b=W/IEkVheYTm1TpUgBC3MP/XwrDGk25FJQrE39BZIn2qVaeypGIDGwJOOF+4N0bKc6tDW6Q
        0Rt3E8X8i56XNJOz1r6/2BFEkzefvrueZSj7F2xRl+/AvHTOEs+JGd6Xj0NUGEn8XkklGn
        Yv7J1zImB3Gh3RmLKemjer0Q/vdyRNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645706927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqhrZTZ5oMSeZ6sL+jtWqsF+SeNGe07XiBRm/i340v8=;
        b=koxjp3gascCNcj2yb8tgzez0/tw/7v9pM64qKSJvRpsN7hwmqICr44i/ZmEz6CRS5gvxnV
        ExQIzfjOTt/c/NBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2DCA13AD9;
        Thu, 24 Feb 2022 12:48:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NgDoKq9+F2IkDgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 24 Feb 2022 12:48:47 +0000
Message-ID: <8915b858-b46d-0acd-bebd-80a0c9882a7e@suse.cz>
Date:   Thu, 24 Feb 2022 13:48:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
References: <20220221105336.522086-1-42.hyeyoo@gmail.com>
 <20220221105336.522086-4-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 3/5] mm/slab: Do not call kmalloc_large() for unsupported
 size
In-Reply-To: <20220221105336.522086-4-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 11:53, Hyeonggon Yoo wrote:
> SLAB's kfree() does not support freeing an object that is allocated from
> kmalloc_large(). Fix this as SLAB do not pass requests larger than
> KMALLOC_MAX_CACHE_SIZE directly to page allocator.

AFAICS this issue is limited to build-time constant sizes. Might be better
to make this a build error rather than build-time NULL?

> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
