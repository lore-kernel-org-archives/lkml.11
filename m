Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7140C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jul 2022 21:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbiGVVdU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jul 2022 17:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236335AbiGVVdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:33:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A89B8799;
        Fri, 22 Jul 2022 14:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LHeOXeT2W/l26vCWMiypCMzsZd0II5Y/bjZZQqtBe9c=; b=enBUd5BzRu/a/DkjWRR9Ci9tHu
        ZqHlMUlzJ/iluyoxABxfiVcj30jIDRCSXnvSJu56AEtmYpiDu8BcRWWXlxJaLVnoaQYGiu1IhCLKK
        tFmId6PMo/8h74JPHy8l+SWfbxVxJZUxI1E91qpxn5TTYXKKPkEJL6Q3Fg3nf0/bx6kjoDDY+0jWt
        EOjfJVAaaKP/TcA8iO3VUDobKEDERtPJqrLLq8yUcA+fkgQv1nya/qoSJMIp/puCy5By9iZYuxYJD
        jXSWbhf/NOsE70xCqYx1w1Q5NxdIz78xXqsvVbNOYroJEX4lm5cQA8kKiZWH8Ibb6Es+AGvQnUCHC
        6P+M1e3A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oF0GW-00GdIv-1Y; Fri, 22 Jul 2022 21:32:56 +0000
Date:   Fri, 22 Jul 2022 22:32:56 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Xin Gao <gaoxin@cdjrlc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: Fix code typo
Message-ID: <YtsXiPPmQ5cqVsqp@casper.infradead.org>
References: <20220722195133.18730-1-gaoxin@cdjrlc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722195133.18730-1-gaoxin@cdjrlc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 03:51:33AM +0800, Xin Gao wrote:
> The double `free' is duplicated in line 498, remove one.

This is wrong.  The intended meaning here is "trying to free bnode
which is already free".  Please don't send patches for code you don't
understand.

> Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
> ---
>  fs/hfsplus/btree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 66774f4cb4fd..655cf60eabbf 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -495,7 +495,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
>  	m = 1 << (~nidx & 7);
>  	byte = data[off];
>  	if (!(byte & m)) {
> -		pr_crit("trying to free free bnode "
> +		pr_crit("trying to free bnode "
>  				"%u(%d)\n",
>  			node->this, node->type);
>  		kunmap(page);
> -- 
> 2.30.2
> 
