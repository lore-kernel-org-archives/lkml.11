Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09776C00140
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 15:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiHBPpM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHBPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:45:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947DB281
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 08:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=c8A0QKURN28UpiUL/e1DYdUv6Gv6n1LaHMwV8hNKfF4=; b=EsqYrBsKLIEEbToIGUCVejRLiH
        OaKvP0ebyxP/nXFgZbiAEqgAIlMEVdNONVVLJFd8QOGXDO5hXOwCfE2+omviU+iSB1NkBuZPSFd77
        jAnnl53gpjdN+lI2ltxwnBxal6pUsueFAeJcgoAdhet+2Tke8JlcVlY1ljLuIUH0ELkml4CrCIT9k
        qOFWxUNm9HC3vJUrSATGZS0Q2Td5kEjacVr0tSoCjsRJ2T7uESktytAy7LK6v0mzPk3tIhG/KWgOQ
        n5V+jVqr6hgZMr1kUNfy70JubUyVtBHDiqxSdMzYK7cBUy8b+9SBrGx54GuQ1Qp/dGnZ1odwYhovy
        hwSBF/Nw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oIu4c-008TE9-51; Tue, 02 Aug 2022 15:44:46 +0000
Date:   Tue, 2 Aug 2022 16:44:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Abhishek Shah <abhishek.shah@columbia.edu>,
        Gabriel Ryan <gabe@cs.columbia.edu>
Subject: Re: [PATCH] mm: ksm: fix data-race in __ksm_enter / run_store
Message-ID: <YulGbmJt2faelV6c@casper.infradead.org>
References: <20220802151550.159076-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802151550.159076-1-wangkefeng.wang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 11:15:50PM +0800, Kefeng Wang wrote:
> The ksm_run is alread protected by ksm_thread_mutex in run_store, we
> could add this lock in __ksm_enter() to avoid the above issue.

I don't think this is a great fix.  Why not protect the store with
ksm_mmlist_lock?  ie:

        mutex_lock(&ksm_thread_mutex);
        wait_while_offlining();
        if (ksm_run != flags) {
+		spin_lock(&ksm_mmlist_lock);
                ksm_run = flags;
+		spin_unlock(&ksm_mmlist_lock);
                if (flags & KSM_RUN_UNMERGE) {
                        set_current_oom_origin();
                        err = unmerge_and_remove_all_rmap_items();
                        clear_current_oom_origin();
                        if (err) {
+				spin_lock(&ksm_mmlist_lock);
				ksm_run = KSM_RUN_STOP;
+				spin_unlock(&ksm_mmlist_lock);
...

(I also don't think this is a real bug, because the call to
unmerge_and_remove_all_rmap_items() will "cure" the misplacement of
items in the list, but there's value in shutting up the tools, I suppose)
