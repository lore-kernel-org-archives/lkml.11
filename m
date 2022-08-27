Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BE4ECAAD5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 02:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345264AbiH0CD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 22:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiH0CD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 22:03:27 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375BBDAA37
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 19:03:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661565802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D/7slZr7aKprYNwHgvO651SPT0Z8XLhxiDf8lcRtpQw=;
        b=tDZZB4JRrLkqVe4E2jf4nrLsdHCCIn8o015HtLYrQN3xj39KJHXil5iV8dnAPPTXtbJecy
        UIPJXhTCbR15TLbIwBxx3EfH+wV3DwCOQGdGWxv7WtyIGNTomfPmdWiWSpVZzjbM0urfrz
        1NQUuRgjfzsnqMHIzpO0VYTA7Wk+Q1I=
MIME-Version: 1.0
Subject: Re: [PATCH 09/10] hugetlb: remove meaningless BUG_ON(huge_pte_none())
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220826092422.39591-10-linmiaohe@huawei.com>
Date:   Sat, 27 Aug 2022 10:03:19 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <399D37BF-B33B-476F-97D4-AEB812316617@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-10-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> When code reaches here, invalid page would have been accessed if huge pte
> is none. So this BUG_ON(huge_pte_none()) is meaningless. Remove it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.

