Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E2BC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 02:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245518AbiDLCTI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Apr 2022 22:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244900AbiDLCS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:18:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890BB33E22;
        Mon, 11 Apr 2022 19:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A522B81A02;
        Tue, 12 Apr 2022 02:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844E1C385A3;
        Tue, 12 Apr 2022 02:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1649729797;
        bh=KaZSlo6LIAX65euqklpjff6NFiyuc2oTEahQLo/+iVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=io4M4pnrSSa7MOeQoMszm+txnYiQiXzl5iRHCTCpj22aUWsmS1+ZChXNLDl+5sgBX
         el+oq9nDoL3sl9M/6/P/vHa0GbdoBjKUCTMdwh6PMASetM8W6ZIYdskyD5Ux8AlFLI
         Z/P340QLfzEMZ1nPWkGN3T9kNEwvNTYXCicl3Nq0=
Date:   Mon, 11 Apr 2022 19:16:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?ISO-8859-1?Q? "Holger_Hoffst=E4tte" ?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 12/14] mm: multi-gen LRU: debugfs interface
Message-Id: <20220411191634.674554d3de2ba37b3db40ca2@linux-foundation.org>
In-Reply-To: <20220407031525.2368067-13-yuzhao@google.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
        <20220407031525.2368067-13-yuzhao@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Apr 2022 21:15:24 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Add /sys/kernel/debug/lru_gen for working set estimation and proactive
> reclaim. These features are required to optimize job scheduling (bin
> packing) in data centers [1][2].

debugfs is for ephemeral temp stuf which can and will change or
disappear at any time.  Anything which is "required" by userspace
should not be in debufgs.

Presumably sysfs is the place.  Fully documented and with usage
examples in the changelog so we can carefully review the proposed
extensions to Linux's ABI.  Extensions which must be maintained
unchanged for all time.



