Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1689C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Mar 2022 12:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355697AbiCPM0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Mar 2022 08:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355696AbiCPM00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 08:26:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DE766213
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 05:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bDzUiAE2yXW6bfjMYLO917qo5tShPrjiMEB/4GVBdHo=; b=IxGoF+ecYdmGtxiNwNM0V7D+ee
        a5TOdJTTU/zm4JxdO8FyyLwKsA+F82YJh61KaLgAulsSFUbdQIzuFfB1yYktkXEqVJPQ4zQrfujp2
        kD4l7k+i1PG+0exmDwYW2V2JbuhKfk6mOjiySTN8bAsG5jsUI7nw4tHTOwrwmvf795aJWEln6t/6e
        11lWnM51z5xvKAPJjHfzfum4R315EA8ZmfrZhxNYBLyYkJcg1A55gSV5TAg9HKtEf5qxafsRdsbKi
        80OgeJ4A1UH4G46P/qqFjjoF0IFFw/q5KNO36+9YAX/LmqKHB5I9Qff6LOxTBJsBBlCuZCKGOkEGt
        W0dqyYFA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUSi6-005xWo-Jy; Wed, 16 Mar 2022 12:25:02 +0000
Date:   Wed, 16 Mar 2022 12:25:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap: simplify the code of find_get_incore_page()
Message-ID: <YjHXHi6WGr9EA35D@casper.infradead.org>
References: <20220316075941.44816-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316075941.44816-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 03:59:41PM +0800, Miaohe Lin wrote:
> pagecache_get_page() can return subpage for us if we do not specify
> FGP_HEAD. No functional change intended.

No, I'm converting this to folios soon.
