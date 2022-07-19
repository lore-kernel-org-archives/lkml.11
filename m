Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B90C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jul 2022 23:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiGSXSm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jul 2022 19:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGSXSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 19:18:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6E461DB0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 16:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F2C611D4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 23:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA5FC341C6;
        Tue, 19 Jul 2022 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658272717;
        bh=S/Ko8haKDUWIwe8GQ22WOUmDVnhESOeTjPOKRncyQn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZtOYXNG1wlt556bN7zEmTA2lJDf6kkFdAeHr6U2Qsa7taNbYqqLBefO9y556hWX3X
         JxFLPfxhD4/Y1zvDfO10/olmtg9e6isE7Hj24IPpwMLQzMA+3gFi2VmMKXYyA+6M+q
         dPhnM8Yg55a36K/PCYBUZD91i4vE5KEhjgoXs5z4=
Date:   Tue, 19 Jul 2022 16:18:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm/cma_debug.c: align the name buffer length as struct
 cma
Message-Id: <20220719161836.b0ad5cdfb0aec0c04a862122@linux-foundation.org>
In-Reply-To: <20220719091554.27864-1-quic_yingangl@quicinc.com>
References: <20220719091554.27864-1-quic_yingangl@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jul 2022 17:15:54 +0800 Kassey Li <quic_yingangl@quicinc.com> wrote:

> Signed-off-by: Kassey Li <quic_yingangl@quicinc.com>
> ---
>  mm/cma_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/cma_debug.c b/mm/cma_debug.c
> index 2e7704955f4f..c3ffe253e055 100644
> --- a/mm/cma_debug.c
> +++ b/mm/cma_debug.c
> @@ -163,7 +163,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(cma_alloc_fops, NULL, cma_alloc_write, "%llu\n");
>  static void cma_debugfs_add_one(struct cma *cma, struct dentry *root_dentry)
>  {
>  	struct dentry *tmp;
> -	char name[16];
> +	char name[CMA_MAX_NAME];
>  
>  	scnprintf(name, sizeof(name), "cma-%s", cma->name);

Seems logical.  But as CMA_MAX_NAME=64, this could result in alteration
of the output: less truncation of the original name.

Is it the case that the output is never >16 chars anyway?  If so, we'll
be OK.

