Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30260C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 10:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiBQKkw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:40:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiBQKkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:40:49 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4F8284D16
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:40:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 39C7C1F383;
        Thu, 17 Feb 2022 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645094434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhmews3hiohUWVZ2fQnwuQzL2BmbTvELU6RjyghQi08=;
        b=jSj5Xuanh1Toei1k1Q94lP4CSI0WNhdInvMyC4HPu6A6CGm4EMQdOz9bHC57KuodIS0MwH
        UuB75aQ3gj3+Q026n8Y/iOmf5Itlhdnyi8ZkKCNZJb6EgOThcrH1N+1y8GEu9rZng9ws2l
        q9XS1+dbRRfkZIsK7WqMbeum/gneUxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645094434;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xhmews3hiohUWVZ2fQnwuQzL2BmbTvELU6RjyghQi08=;
        b=+8TkWSof3pEdblEHBwaLdQU3g/jum9Hcr88Ej619ZPdU7vLezllD2tiYjulZstHXKlsaUM
        m8kPvFrAe2XHXkBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6217913DD8;
        Thu, 17 Feb 2022 10:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NX+bFCEmDmKuRQAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 17 Feb 2022 10:40:33 +0000
Date:   Thu, 17 Feb 2022 11:40:31 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>
Subject: Re: [PATCH 4/6] mm, memory_hotplug: reorganize new pgdat
 initialization
Message-ID: <Yg4mHzoMzJSF/Y4z@localhost.localdomain>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-5-mhocko@kernel.org>
 <6db33bb0-c72a-5539-5873-14039702e2a3@redhat.com>
 <YfKvxVkkJ415DH4t@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfKvxVkkJ415DH4t@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 03:44:21PM +0100, Michal Hocko wrote:
> > I feel like we should be initializing all of this only once, just after
> > allocating the node. There should be no difference between a node we're
> > reusing and a "fresh" node. IOW, memory offlining should be resetting
> > all state accordingly when the last memory goes away.
> > 
> > But I might be wrong and this patch looks like an improvement, as you
> > say,  without functional change
> 
> Yeah, I really wanted to have this simple and straightforward. To be
> completely honest I am not even sure this is necessary. Something really
> woth looking at.

Seizing the opportunity that I had to look at this code and at x86's
numa init code again I am preparing something to further sort this out and
simplify it a bit.

So I will have something soon unless someone beats me to it first. 

-- 
Oscar Salvador
SUSE Labs
