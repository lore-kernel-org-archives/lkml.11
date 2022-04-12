Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFD9C43217
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347008AbiDLJb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386357AbiDLI5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:57:34 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139456578F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:13:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 945F81F856;
        Tue, 12 Apr 2022 08:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649751231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jcar0IU6PwGTrQSGDaDquWKKjYlZDyRkkpySjBoGCVQ=;
        b=hoKDZwsrvHWuqvedPT0DnBr4y+jyJBtwP+gpluiusRgPyYzdOnZ662DgSfRE36GOL3p0i2
        IgSEFKM71YIymkOkxnf0YvOsWcIxsFAxWePEQRtceCQgP7EO2MaHMa+3z/Py8g103atCRo
        u2FWoxdsDl4+D+Y2IfeLtqOyjs3oyMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649751231;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jcar0IU6PwGTrQSGDaDquWKKjYlZDyRkkpySjBoGCVQ=;
        b=/7xdxhDJHryQs7sEVoQ9Y7suIbX/9N+NThL6YemWrOI7WTegprVElyfNItktqa9lElIdDN
        gCMt4VsBR3CFyBCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 321A513780;
        Tue, 12 Apr 2022 08:13:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id dkOhC780VWI8DgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 12 Apr 2022 08:13:51 +0000
Message-ID: <2cbc3b75-e29e-bbd8-0522-a3757f81b5c6@suse.cz>
Date:   Tue, 12 Apr 2022 10:13:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 06/16] mm/rmap: remove do_page_add_anon_rmap()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-7-david@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220329160440.193848-7-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/22 18:04, David Hildenbrand wrote:
> ... and instead convert page_add_anon_rmap() to accept flags.
> 
> Passing flags instead of bools is usually nicer either way, and we want
> to more often also pass RMAP_EXCLUSIVE in follow up patches when
> detecting that an anonymous page is exclusive: for example, when
> restoring an anonymous page from a writable migration entry.
> 
> This is a preparation for marking an anonymous page inside
> page_add_anon_rmap() as exclusive when RMAP_EXCLUSIVE is passed.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
