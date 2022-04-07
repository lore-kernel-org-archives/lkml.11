Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B91C7C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 12:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245488AbiDGMy4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245481AbiDGMys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 08:54:48 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C826259B58;
        Thu,  7 Apr 2022 05:52:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::e2d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5390B30D;
        Thu,  7 Apr 2022 12:52:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5390B30D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1649335966; bh=J6fsWhcIYdB09wzvgZi6AxYIXSAJzCGBEqivzfR46Ss=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jFKLQQekMDOtJN8dSbnDT5H9DpIjIII0a4/YX7BVTC3rl1zbWzFfWP5DoYkuu+aah
         89Aw6rqW2QCQ/lMvN07sgjpylKtwLogEsnD9MmwftsfJCN3zwbE7tGfrAmuqRjDAxx
         bsby11D9TfvO/ca6L7q/ixVgU8WODgk/5FSv97GwkQSRspBu3GQEz/4JfgSDn0qoOn
         R6qeOk4Wn3MMOtAZO0pbE2EDX3lnXZ4fpMNByp66gx4nHmFf5h0wC4C/5Ntczpb5hJ
         ZwaLdmte38V7t+sv+XIPJAX+eRpQj+cbdaStVYOyeDdlCRhmuISUmgPFGAe1+6hbu6
         MAYN2RjDBgysw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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
        Holger =?utf-8?Q?Hoffst=C3=A4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 14/14] mm: multi-gen LRU: design doc
In-Reply-To: <5ea69d84-be0c-2e9b-02b5-92d9442c8aff@gmail.com>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-15-yuzhao@google.com>
 <5ea69d84-be0c-2e9b-02b5-92d9442c8aff@gmail.com>
Date:   Thu, 07 Apr 2022 06:52:45 -0600
Message-ID: <87wng1838i.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 07/04/22 10.15, Yu Zhao wrote:
>> Add a design doc.
>> 
>
> Why is this design documentation added?

...because perhaps other developers might want to understand the design
of this complex mechanism?

Bagas, it is hard enough to get people to write useful documentation as
it is.  Could I ask you to please stop adding useless friction to the
process?

Thanks,

jon
