Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4C6C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 19:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353668AbiDZTSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 15:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350998AbiDZTSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 15:18:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7064219C8CB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+rijnMzV1mnbw2T3L6iBdqyAVx2tQONoMYJwvaCPRt4=; b=BJW1QGbJBdtuQ2DD2N2D5LtBHW
        tNtlVjT+HUsI2U09Vx2M8G3r9E7MaNHVMAJh9a9QwRVqHN6yLNGWUVdvyjKHHUYasTP99r0upmWFc
        anWu53hjJz1F7AekAZgUlgwdYyKDF2VR3MwJ24ZTOwjEIy7oLSd4IpuRgHYgxaqitxginr7WDiZpU
        ginnp936bH2Yy2zLiRrk5PCYr1DE1xgo3xztNaS2WFuzmh7Y8t96OHW38zfvECx8oFmJdS3/ZBlXV
        pm3S1wabFKAIh9ScTpO8ZDMAe3vr5I+NRvj/2+aIKJSdKpJPMVGChOOvyosZwMCc5oO52R5yr0TrG
        NT8QE6OA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1njQe8-009vx4-3r; Tue, 26 Apr 2022 19:14:48 +0000
Date:   Tue, 26 Apr 2022 20:14:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jagdish Gediya <jvgediya@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ying.huang@intel.com, dave.hansen@intel.com,
        Jonathan.Cameron@huawei.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        rf@opensource.cirrus.com, pmladek@suse.com
Subject: Re: [PATCH v3 1/2] lib/kstrtox.c: Add "false"/"true" support to
 kstrtobool()
Message-ID: <YmhEqCCfUvYYPmci@casper.infradead.org>
References: <20220426180203.70782-1-jvgediya@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426180203.70782-1-jvgediya@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 11:32:02PM +0530, Jagdish Gediya wrote:
> Signed-off-by: Jagdish Gediya <jvgediya@linux.ibm.com>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

HEY!  You still have the buggy IFF -> IF change.  FIX IT.
My R-b was very clearly conditional on you fixing it.

> - * This routine returns 0 iff the first character is one of 'Yy1Nn0', or
> + * This routine returns 0 if the first character is one of 'YyTt1NnFf0', or
