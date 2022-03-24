Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160ADC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Mar 2022 09:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349355AbiCXJxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Mar 2022 05:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241065AbiCXJxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:53:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F75549E;
        Thu, 24 Mar 2022 02:52:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DD1E1F38D;
        Thu, 24 Mar 2022 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648115519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7gpGpR3wa2+cKOuymKs7lOAFj3Lr0LMnbgKaKE1lmS0=;
        b=BGawxnk4ZkQIE7RH/c/DMxnbfBkVfcFqPuS610Wd3K1lipapLcY5WY8j8HJStzYE0qHan9
        vrS4rkjy97O26ObUlec4H4FLbLds3Pdx2zDW0dSGgyhnAZScTDYtdQ/kEqDrcs3RcUTORB
        ad8lq6Av0xdWgp0oZGGgHRSkCsgq2j8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC35813A78;
        Thu, 24 Mar 2022 09:51:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8GeWND4/PGLKQQAAMHmgww
        (envelope-from <mkoutny@suse.com>); Thu, 24 Mar 2022 09:51:58 +0000
Date:   Thu, 24 Mar 2022 10:51:57 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yang Shi <shy828301@gmail.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Chris Down <chris@chrisdown.name>
Subject: Re: [RFC PATCH] mm: memcg: Do not count memory.low reclaim if it
 does not happen
Message-ID: <20220324095157.GA16685@blackbody.suse.cz>
References: <20220322182248.29121-1-mkoutny@suse.com>
 <YjuUuLW+8iRtYOmP@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjuUuLW+8iRtYOmP@carbon.dhcp.thefacebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:44:24PM -0700, Roman Gushchin <roman.gushchin@linux.dev> wrote:
> Does it mean that in the following configuration:
> 	`parent .low=50M
> 	  ` s1	.low=0M   .current=50M
> 	  ` s2  .low=0M   .current=50M
> there will be no memory.events::low at all? (assuming the recursive thing is on)

True, no memory.events:low among siblings.
Number of memory.events:low in the parent depends on how much has to be
reclaimed (>50M means carving into parent's protection, hence it'll be
counted).

This is a quantitative change in the events reporting (point 1 of
RFCness), my understanding is that the potential events due to recursive
surplus protection carry no new information regarding configured
memory.low.


Michal
