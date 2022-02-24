Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B705CC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Feb 2022 22:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiBXWDD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 17:03:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiBXWDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:03:01 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C14186227
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 14:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=W/M4h+Wc7afgAQolO9V8hencFRzUNhasCzwSblw7Pxo=; b=IH0Zoluc/B7clTwJrdxD86Jlpl
        Thdkbi8MQrXEkA6LA0vTZEQflLec3i9qdGhyMVIIVKOCkOCjYQH6pmBc6n8R5BEpgY2HWOFddUQPU
        EVsNCvRp/xJ6n7OYRHtB9UGMSxZwhPFkOhLMXACgEfT0CrPmDyNKQ44RdfhwmfzVicXGxUA9siCEK
        O4l7RQOb3XIsSqQnSOALuoR+xvo9DkAZogTwxWABFiSnSGieFOQl0OCCOBqNY7nbhzrUBlE2MwkiF
        UgFsgoBOhw49wUd5Ac/VUR9r4S0ZJ9r2BnUC1WCj7OHlcQrVdp+VRkkbODh+CbiXCtlBfPoXPr4YA
        jfm9urZQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNMBu-005BBf-6W; Thu, 24 Feb 2022 22:02:26 +0000
Date:   Thu, 24 Feb 2022 22:02:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] mm/rmap: Fix argument list that the kdoc format
 and script verified.
Message-ID: <YhgAchHs8c1N1AQn@casper.infradead.org>
References: <20220224014344.99537-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224014344.99537-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 09:43:44AM +0800, Yang Li wrote:
> The warnings were found by running scripts/kernel-doc, which is
> caused by using 'make W=1'.
> 
> mm/rmap.c:1684: warning: Function parameter or member 'folio' not
> described in 'try_to_unmap'
> mm/rmap.c:1684: warning: Excess function parameter 'page' description in
> 'try_to_unmap'

Fixed these like this instead:

 /**
- * try_to_unmap - try to remove all page table mappings to a page
- * @page: the page to get unmapped
+ * try_to_unmap - Try to remove all page table mappings to a folio.
+ * @folio: The folio to unmap.
  * @flags: action and flags
  *
  * Tries to remove all the page table entries which are mapping this
- * page, used in the pageout path.  Caller must hold the page lock.
+ * folio.  It is the caller's responsibility to check if the folio is
+ * still mapped if needed (use TTU_SYNC to prevent accounting races).
  *
- * It is the caller's responsibility to check if the page is still
- * mapped when needed (use TTU_SYNC to prevent accounting races).
+ * Context: Caller must hold the folio lock.
  */

