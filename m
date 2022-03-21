Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 13:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347987AbiCUNmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 09:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239990AbiCUNmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 09:42:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA8870071;
        Mon, 21 Mar 2022 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=A5pIWGpAlCpmoXO/m/tQzGXHU5kEsQj3f9sYGkjo+tw=; b=gDa4hOdWqKAvf/Z2G+BXMo9fDJ
        awDh71+oGBKuK2GtiNS0Bm6vNc3vODkCarJJOJNd0U+6kPxpFSLz/TNPERV3p6KDWys1hUBuyP111
        jaOqD+rF8Oh8tEErWlBCoqf8nu8kjqkedeovDbL25fIpUO0nzHM8D3uR3rBTfK/WzSNl4K8JZ1XDO
        Sdoqfbe3jUnOjltxe81qwd9VhUmcXzXcLHdkmtygg+uZo4IIYk/xFP0o6hhT0oOry28KA0oy97UFy
        HjQKcsVb/XGN7TP6uN1yi5rZMEjSpN2RlO99fUy4cIjmnfuUk2vVtaSsPAg9BQm1bDlpPhchFiacF
        UCa7zrKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nWIGz-00Aba8-IG; Mon, 21 Mar 2022 13:40:37 +0000
Date:   Mon, 21 Mar 2022 13:40:37 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        bo.liu@linux.alibaba.com, tao.peng@linux.alibaba.com,
        gerry@linux.alibaba.com, eguan@linux.alibaba.com,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com
Subject: Re: [PATCH v5 03/22] cachefiles: introduce on-demand read mode
Message-ID: <YjiAVezd5B9auhcP@casper.infradead.org>
References: <20220316131723.111553-1-jefflexu@linux.alibaba.com>
 <20220316131723.111553-4-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316131723.111553-4-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:17:04PM +0800, Jeffle Xu wrote:
> +#ifdef CONFIG_CACHEFILES_ONDEMAND
> +	struct xarray			reqs;		/* xarray of pending on-demand requests */
> +	rwlock_t			reqs_lock;	/* Lock for reqs xarray */

Why do you have a separate rwlock when the xarray already has its own
spinlock?  This is usually a really bad idea.
