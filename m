Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E24ECAAD5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Aug 2022 01:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345005AbiH0BkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Aug 2022 21:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiH0BkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 21:40:15 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1FFC9E86
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 18:40:13 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1661564411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=egzH6offlKzuA7WOnMVVRuXOMtC+rmqQ05wM0dkNMOA=;
        b=n1gGPOItnrDyCHrlp4sCdinGfMRbAsG8CUYsR+qdY21vq3VqPJWrdYxrOm0yj0EfWVuBnD
        6Q1yQBI3BKmHy6tMMxCdMw/R+2mc8DT8K9lJ+3seV2YPWdh5pXAji19YcEP86ppTLqR26S
        RHyK1OGFJsWY8p66Wohk05sbFNx+7LI=
MIME-Version: 1.0
Subject: Re: [PATCH 01/10] hugetlb: make hugetlb_cma_check() static
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20220826092422.39591-2-linmiaohe@huawei.com>
Date:   Sat, 27 Aug 2022 09:40:08 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>, mike.kravetz@oracle.com,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CD6C71BC-7426-4505-8032-E5CE3C876995@linux.dev>
References: <20220826092422.39591-1-linmiaohe@huawei.com>
 <20220826092422.39591-2-linmiaohe@huawei.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 26, 2022, at 17:24, Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> Make hugetlb_cma_check() static as it's only used inside mm/hugetlb.c.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
