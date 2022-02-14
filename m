Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 14:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355396AbiBNOuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:50:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiBNOuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:50:50 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420B04C7AB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:50:43 -0800 (PST)
Date:   Mon, 14 Feb 2022 23:50:36 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644850241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xyq+j31FZqDn7F6SUp8vugX9CPKq/x3n/C18Y0gEPjY=;
        b=xiJuXJiMucP8TCEsaZA1tG45wSMxQOu8L0NL6jDvRTmrF2/czGzUYuPBt+t5G5P4rw+o2s
        Oyy03jHhspG4dd7dpnCWyN3WdWcV1h+Nfk8yl4TgwjPyoJ6VPT6bcZUP870kBj+LS1JfQp
        NA7CTwR/aMcoLTDA5oZ6UtNRrf78aZA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/8] mm/memory-failure.c: remove PageSlab check in
 hwpoison_filter_dev
Message-ID: <20220214145036.GE2624914@u2004>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210141733.1908-6-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:17:30PM +0800, Miaohe Lin wrote:
> Since commit 03e5ac2fc3bf ("mm: fix crash when using XFS on loopback"),
> page_mapping() can handle the Slab pages. So remove this unnecessary
> PageSlab check and obsolete comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
