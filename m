Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FF6ECAAD5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 01:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241925AbiH0Bsl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 21:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0Bsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:48:37 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053D3EA8A2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:48:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661564915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkX8AyY7yYS6m2CvyA60Y5eGio2aHXuyXJEZp8ZG8cM=;
        b=oRAMmYxz6PjJAvcwt+NZLHV4VmWV1mkC/1oUXLqc40ahOANlKnwt0RbJhAfpFYLkBzv/3w
        oI2rgRgXNZuIGSQ0IANHXTwH8mjLjLtshauA1MWtYlqgCow++p0EqpuMIxezHwHp3xDgRc
        nqH1hb0b7n214b7cLaTP+zKSAoSnbPE=
MIME-Version: 1.0
Subject: Re: [PATCH 05/10] hugetlb: Use helper {huge_pte|pmd}_lock()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220826092422.39591-6-linmiaohe@huawei.com>
Date:   Sat, 27 Aug 2022 09:48:32 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <87F2E6DA-D44C-40F5-8CBF-849C1AF33ACA@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-6-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> Use helper huge_pte_lock and pmd_lock to simplify the code. No functional
> change intended.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
