Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23BFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243811AbiESSVS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 May 2022 14:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243883AbiESSVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:21:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99BEE06;
        Thu, 19 May 2022 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=MnIo1di9qEy36biVogxYtTZzKVl7tqyCNsrCNfP71V0=; b=UhNHdnQ7Xhgs55sGjcHz1dwbYn
        Qev8kvOfC0qBvVHFDTAopRcw4y0BaEWtWFN9ZzvPL9AQaBqqBfyAW7OgKfQDKBSR6fMH6Zm16G2Kq
        4WRUC/dnIwmhnFjYB8SZiXGiSaHCFhSS2kBzna8s9szp9aYW2LjKM8YjSFRxCD+lyikIZUMCe6eu6
        TzJyFuY0LYuIWDxpz6KfGQenvUXKfcKrk3jrlsYiwTe8ZBIi+xqaDoa+6ISuGtZyiYyJNgTIiyTYA
        WfBfxmtqX0uyap83uut7WVlN61WYyQw+M8P7DATsTlk0mvAv4RGrwBYg98DuDAXXUq9a5Gf256/Jo
        L6r94rKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nrklg-00CzPD-35; Thu, 19 May 2022 18:21:00 +0000
Date:   Thu, 19 May 2022 19:21:00 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org,
        andriy.shevchenko@linux.intel.com
Subject: Re: [PATCH v2 01/28] lib/printbuf: New data structure for printing
 strings
Message-ID: <YoaKjCoVot4JV46s@casper.infradead.org>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
 <20220519172421.162394-2-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519172421.162394-2-kent.overstreet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:23:54PM -0400, Kent Overstreet wrote:
> This adds printbufs: a printbuf points to a char * buffer and knows the
> size of the output buffer as well as the current output position.
> 
> Future patches will be adding more features to printbuf, but initially
> printbufs are targeted at refactoring and improving our existing code in
> lib/vsprintf.c - so this initial printbuf patch has the features
> required for that.
> 
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

My only complaint ...

> +#define PRINTBUF ((struct printbuf) { .si_units = PRINTBUF_UNITS_10 })

si_units doesn't exist yet :-)
