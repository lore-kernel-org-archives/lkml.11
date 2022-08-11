Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23819C19F2D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 08:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiHKImZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbiHKImX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 04:42:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F748E0D1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 01:42:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4D90E5C43C;
        Thu, 11 Aug 2022 08:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660207341; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BXWAGelHI6Qf6b5shKf8Bk4XHQmDrurWKAtmRuaA1lk=;
        b=CFz7NxCY7AZFWjv40Es5ZAs6bhLkTtcLM1wVqjiLOYeAYKaPu/Kq0dNPbDmRfxNMFbMsX2
        kSSIu34EHghF+0je4TlVdzCABrL1AQp7BeFRq3MwYIjUFtYecaMbwYI9i/ibcSHhQOYsKu
        P8pkDizvAFUylntNXVQ2NJh1itONNi0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B57213A9B;
        Thu, 11 Aug 2022 08:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zPNWCO3A9GJYWQAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 11 Aug 2022 08:42:21 +0000
Date:   Thu, 11 Aug 2022 10:42:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <YvTA7M8XXu0GgB8v@dhcp22.suse.cz>
References: <Yj28gjonUa9+0yae@dhcp22.suse.cz>
 <20220325164856.GA16800@lst.de>
 <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
 <YupFSpXOrcfXJNya@dhcp22.suse.cz>
 <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
 <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
 <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
 <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
 <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
 <20220811074946.GB14956@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220811074946.GB14956@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-08-22 09:49:46, Christoph Hellwig wrote:
> On Thu, Aug 04, 2022 at 07:01:28PM +0800, Baoquan He wrote:
> > After attempts, I realize it's time to let one zone DMA or DMA32 cover
> > the whole low 4G memory on x86_64. That's the real fix. The tiny 16M DMA
> > on 64bit system is root cause.
> 
> We can't for two reasons:
> 
>  - people still use ISA cards on x86, including the industrial PC104
>    version, and we still have drivers that rely on it
>  - we still have PCI and PCIe devices with small than 26, 28, 30 and 31
>    bit addressing limitations
> 
> We could try to get the 24-bit DMA entirely out of the zone allocator
> and only fill a genpool at bootmem time.  But that requires fixing up
> all the direct users of page and slab allocations on it first (of
> which 90+% look bogus, with the s390 drivers being the obvious
> exception).

Completely agreed!

> Or we could make 'low' memory a special ZONE_MOVABLE and have an
> allocator that can search by physical address an replace ZONE_DMA
> and ZONE_DMA32 with that.  Which sounds like a nice idea to me, but
> is pretty invasive.

Yes.

-- 
Michal Hocko
SUSE Labs
