Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DFAC00140
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Aug 2022 07:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiHJHXi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Aug 2022 03:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiHJHXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 03:23:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC365A8A0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 00:23:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A56B85C5F4;
        Wed, 10 Aug 2022 07:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660116211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XAF+Y7ib/KCBJKhHgL+UmuGO+OSVwbzTJiPOyXkFvyI=;
        b=YonhsmUCdhCcf0jEe6L1hAkGeyUHL3vBNrF3HeMGpp6gYkotJ7PaKD5lNibpb8hVQcz80t
        XMiwmgMqaL6WC0iShE0ITVe5v9oFXZ1sLVTxffXk/onJXHBvvce54dfEis8AKdoeUN0C8Y
        ohUD0xDjO+i7Dp/D9bni+wetxFw0gbs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8607F13AB3;
        Wed, 10 Aug 2022 07:23:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pkw8HvNc82IDYAAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 10 Aug 2022 07:23:31 +0000
Date:   Wed, 10 Aug 2022 09:23:30 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Charan Teja Kalla <quic_charante@quicinc.com>, david@redhat.com,
        pasha.tatashin@soleen.com, sieberf@amazon.com, shakeelb@google.com,
        sjpark@amazon.de, dhowells@redhat.com, willy@infradead.org,
        quic_pkondeti@quicinc.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH V3] mm: fix use-after free of page_ext after race with
 memory-offline
Message-ID: <YvNc8vuinnddc78j@dhcp22.suse.cz>
References: <1660056403-20894-1-git-send-email-quic_charante@quicinc.com>
 <20220809185714.5af7057c1270b11079cb196a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809185714.5af7057c1270b11079cb196a@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 09-08-22 18:57:14, Andrew Morton wrote:
> On Tue, 9 Aug 2022 20:16:43 +0530 Charan Teja Kalla <quic_charante@quicinc.com> wrote:
> 
> > The below is one path where race between page_ext and  offline of the
> > respective memory blocks will cause use-after-free on the access of
> > page_ext structure.
> 
> Has this race ever been observed at runtime?
> 
> Given the size of the fix, I'm looking for excuses to not backport it
> into -stable kernels!

I believe this is quite theoretical for two reasons
1) the memory hotplug (offlining) is quite rare operation
2) with all the retries the race window is quite hard to trigger

So this is good to have address long term but nothing really for stable
until somebody actually hits that with a real world workload.

Btw. I plan to have a look and review this but times are busy. Hopefully
soon.

Thanks!

-- 
Michal Hocko
SUSE Labs
