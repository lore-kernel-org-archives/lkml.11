Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5E1C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 16:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242934AbiCNQS0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiCNQSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:18:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D16A4161E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5XpAIw2yg1CSg6scwFjP4xm5do4IfouW2lVMpcbtSFY=; b=FzvGRTu7naBCARpYFA2lLhYLPY
        Yrh39A07HVuxla3xbUbmIMG4jywP+TSIQHm1a2CdyLrK300BB9nHBIkyrgHCXZyHesPpkuahWCrqZ
        daQDDsI71ELlN1dl2Ys7uqxdrH/D/2NQLrduSYIN728FvJcGuUw/yxjqtBlFKes2OADNzd1/HZNAe
        31xPLxs57l781DGfFg/yWG2Tc9aARYqSBhW8i1B73uOd5pvsKUnCYPPT8kPIAgY06PwKJXp5SG3Ya
        yZR9wxc9PA6w4b7z2gtcttfeSJmgyAcnPJ68QOgkJCiF4zwv9w8qCd+jBf7AodyXhWay9Qv1HKOSz
        4gk+6zNQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nTnNO-004CYa-I6; Mon, 14 Mar 2022 16:16:54 +0000
Date:   Mon, 14 Mar 2022 16:16:54 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mlock: Use vma_lookup() instead of find_vma()
Message-ID: <Yi9qdrJ9AXOJszmu@casper.infradead.org>
References: <20220314151728.20800-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314151728.20800-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 11:17:28PM +0800, Miaohe Lin wrote:
> Using vma_lookup() verifies the start is contained in the found vma. This
> results in easier to read the code.

This conflicts with the maple tree.
