Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1609C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 May 2022 21:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbiEJVTO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 May 2022 17:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiEJVTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:19:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A8951301
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 14:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD4A3B81C64
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 21:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C5C385CD;
        Tue, 10 May 2022 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652217545;
        bh=kstaEIaCNejjJn85LyPhv0xKpAXHnb8XynIqeHWE1Rk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GOEQcV9d3cXsg28ZFFzj9Pc0hs2JjCvV7o2Ill5kLqKlBQzRbW/T4/nWQhJd6It+T
         oagTH7Rs3r8uAkzNnXhwS0kTC40z1YC2OaQQRiFPQKTbamVue5iTo2G16sIgN/yxTR
         DOptJ2F5DByrKaucOUgt+Ckiw+/YjryQZ0Xlk8I4=
Date:   Tue, 10 May 2022 14:19:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Zi Yan <ziy@nvidia.com>, Johannes Weiner <hannes@cmpxchg.org>,
        kernel test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Hildenbrand <david@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [mm]  23e12fc477:
 UBSAN:shift-out-of-bounds_in_mm/page_isolation.c
Message-Id: <20220510141904.242d9301d109d413ea10e978@linux-foundation.org>
In-Reply-To: <20220510095824.GB3969@xsang-OptiPlex-9020>
References: <20220510095824.GB3969@xsang-OptiPlex-9020>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2022 17:58:24 +0800 kernel test robot <oliver.sang@intel.com> wrote:

> commit: 23e12fc477f1c2729af51c427087e777d6e63803 ("mm: make alloc_contig_range work at pageblock granularity")
> https://github.com/hnaz/linux-mm master

That tree is no longer being updated.  Please switch to

	git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Either the mm-unstable branch (hotfixes and MM) or the mm-everything
branch (mm-unstable plus non-MM patches).

mm-unstable includes
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-make-alloc_contig_range-work-at-pageblock-granularity-fix.patch,
which quite possibly fixes the issue you have detected.

Thanks.
