Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FCDC43334
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jun 2022 10:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiFRKet (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jun 2022 06:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFRKes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 06:34:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5B8DFE4;
        Sat, 18 Jun 2022 03:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XDQYopvY+n0JyKPmW0NgGxfaIg7ptxNKbg5tiL90yf4=; b=f52cnHOzcNZsJ0dPtfJpa6RtMC
        6cP9oGvpz505NKdQXmMUHHLJ5qHC+ZAmqtqiD5S65X3Kzi3/mNGc/vFA25eufTyu5/lbr8/mnhuAG
        8h3kNgjkFHZLHFKCfYqXcuErKGMyyWJHdusPX6hD2v+ByRt0wAjOK+wnTIseQ1AniycFdoVOt5KmH
        +0PcfgAQH5upv5nR+RmIKc9fTZR5QdFEjagK/l15tLu4Oo5mzHyt8253KvcK0M+c7Cun96AnmW/4S
        HKOQWIlNWJpyr05ItQjfOxN7CAeEAM6ekhpvt8qa977OjiJ+ab+1NsKEehjbHHfnfsGRT6Zw21LWx
        rFAKvIog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o2Vmr-003d2E-4c; Sat, 18 Jun 2022 10:34:41 +0000
Date:   Sat, 18 Jun 2022 11:34:41 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap: obey mapping->invalidate_lock lock/unlock order
Message-ID: <Yq2qQcHUZ2UjPk/M@casper.infradead.org>
References: <20220618083820.35626-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220618083820.35626-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 18, 2022 at 04:38:20PM +0800, Miaohe Lin wrote:
> The invalidate_locks of two mappings should be unlocked in reverse order
> relative to the locking order in filemap_invalidate_lock_two(). Modifying

Why?  It's perfectly valid to lock(A) lock(B) unlock(A) unlock(B).
If it weren't we'd have lockdep check it and complain.
