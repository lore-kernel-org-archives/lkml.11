Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EEEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 14:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355303AbiBNOro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:47:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241737AbiBNOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:47:43 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B366BC18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 06:47:34 -0800 (PST)
Date:   Mon, 14 Feb 2022 23:47:23 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644850050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U9z5U7lVDiaFa0P+mbUxl2di6RfgTsQ3JhLRJsOVAqA=;
        b=gzBBbWcPLUnEbC7CQwlKYN64ftiUYTmr9628kplhczLIDy/tBbcgY0q1E4XGzXkquqBjIo
        IDBMLqHNFzYONJc/BvWOxupJTRmXKAZKfH8LxY3ygIFp44gEW/M/by79Sk/e1PUIeWbYlV
        XqOFXmcsEZgUruJAGd/QLFK0NfbedM8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] mm/memory-failure.c: minor clean up for
 memory_failure_dev_pagemap
Message-ID: <20220214144723.GA2624914@u2004>
References: <20220210141733.1908-1-linmiaohe@huawei.com>
 <20220210141733.1908-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220210141733.1908-2-linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:17:26PM +0800, Miaohe Lin wrote:
> The flags always has MF_ACTION_REQUIRED and MF_MUST_KILL set. So we do
> not need to check these flags again.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
