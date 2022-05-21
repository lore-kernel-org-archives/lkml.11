Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B03C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 21 May 2022 04:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239752AbiEUEDx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 May 2022 00:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbiEUEDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 00:03:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF2B1900ED
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 21:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jZF0dK7dSzSmSYBxZ9RlugA1Atoa9lfE0izdD/WJbmw=; b=jFnNqC//Nj0KkvYHS1hFgW7Qmg
        U22wqusCEoMjpN/3ap9tbz3thYYPqfEED8koY2yVDZCEFZWZoWAliJ+jD8TWjXf45LkEya0YbCMNS
        AWyG0ww9K1M5fpypTG3FhqJaLWbSfgZAuXRNkGtopPgyNNae2nCzvC83HFpfEk5Am2APEPYfU8MQ4
        h7yiSbfFS4NDCbgwRMg6h7LavcvqOaFnqi39aoHbhzStzqEeT8v9S5YeaGvBSJQyIlYIhdV25m3ZY
        aYQ2ktd03i85FZ82ilHnQr5FeS59aDT/oDmixHJIZZHAbZHHtfN5RUKCi+iQohJ9Y2fMt4zM9fHTa
        viRouxHw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsGKB-00EMHv-3R; Sat, 21 May 2022 04:02:43 +0000
Date:   Sat, 21 May 2022 05:02:43 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chih-En Lin <shiyn.lin@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Suren Baghdasaryan <surenb@google.com>,
        Colin Cross <ccross@google.com>,
        Feng Tang <feng.tang@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Mike Rapoport <rppt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, Kaiyang Zhao <zhao776@purdue.edu>,
        Huichun Feng <foxhoundsk.tw@gmail.com>,
        Jim Huang <jserv.tw@gmail.com>
Subject: Re: [RFC PATCH 3/6] mm, pgtable: Add ownership for the PTE table
Message-ID: <YohkY75ekI6vhMYC@casper.infradead.org>
References: <20220519183127.3909598-1-shiyn.lin@gmail.com>
 <20220519183127.3909598-4-shiyn.lin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519183127.3909598-4-shiyn.lin@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 02:31:24AM +0800, Chih-En Lin wrote:
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 8834e38c06a4..5dcbd7f6c361 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -221,6 +221,7 @@ struct page {
>  #ifdef LAST_CPUPID_NOT_IN_PAGE_FLAGS
>  	int _last_cpupid;
>  #endif
> +	pmd_t *cow_pte_owner; /* cow pte: pmd */

This is definitely the wrong place.  I think it could replace _pt_pad_1,
since it's a pointer to a PMD and so the bottom bit will definitely
be clear.

