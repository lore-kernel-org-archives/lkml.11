Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61582C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jul 2022 17:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiGYRy5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jul 2022 13:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGYRyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:54:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB141EC6B;
        Mon, 25 Jul 2022 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WRtLvh8vQFAwl+j71sq0GoqmKbASLPmLw5WqWrh7n4s=; b=ZedRTo8FyXHWawcf/8qciUEdY8
        ObSfgb0/XebD2pDuI56TMDNQ9a4zoeLS/SPGVLOqRJkKyqDTfTTSfe0JSOA261a31mGZyI3OD0Khi
        N6AjkEUKqzX4o+kSGo4qLsb7qarKHzyW38ka+nF8s5H7uDlYM70a+e3aZilFtbjOEgchIcvAx5DrK
        eDeyOlPfYFVmY87Db+EZpfurtOgblrq8ARcURl9dkXczGzDG6Wc1sT3SatEc6asn5Kt5TBFgGwTHI
        2rbaQSa7ff+kAto/FvI6tlgrIzw76u434WguPxH6BE4HMxQuSUmhU1ceTP2FKCZQigeB7+g1QaGPe
        rOO4jqDA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oG2I6-001JNH-A5; Mon, 25 Jul 2022 17:54:50 +0000
Date:   Mon, 25 Jul 2022 18:54:50 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Viacheslav Dubeyko <slava@dubeyko.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] hfsplus: Convert kmap() to kmap_local_page() in bitmap.c
Message-ID: <Yt7Y6so92vXTOI+Q@casper.infradead.org>
References: <20220724205007.11765-1-fmdefrancesco@gmail.com>
 <A2FB0201-8342-481B-A60C-32A2B0494D33@dubeyko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2FB0201-8342-481B-A60C-32A2B0494D33@dubeyko.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:17:13AM -0700, Viacheslav Dubeyko wrote:
> Looks good. Maybe, it makes sense to combine all kmap() related modifications in HFS+ into
> one patchset?

For bisection, I'd think it best to leave them separate?
