Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E84C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Mar 2022 12:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241806AbiCBMcu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 07:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbiCBMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:32:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF2C1CA7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:32:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FF6F6190F
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B6FC340E9;
        Wed,  2 Mar 2022 12:31:57 +0000 (UTC)
Date:   Wed, 2 Mar 2022 12:31:54 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, james.morse@arm.com,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com
Subject: Re: [PATCH v2 RESEND 1/2] arm64: avoid flushing icache multiple
 times on contiguous HugeTLB
Message-ID: <Yh9julZqG+sr6IV9@arm.com>
References: <20220302084624.33340-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302084624.33340-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 04:46:23PM +0800, Muchun Song wrote:
> When a contiguous HugeTLB page is mapped, set_pte_at() will be called
> CONT_PTES/CONT_PMDS times.  Therefore, __sync_icache_dcache() will
> flush cache multiple times if the page is executable (to ensure
> the I-D cache coherency).  However, the first flushing cache already
> covers subsequent cache flush operations.  So only flusing cache
> for the head page if it is a HugeTLB page to avoid redundant cache
> flushing.  In the next patch, it is also depends on this change
> since the tail vmemmap pages of HugeTLB is mapped with read-only
> meanning only head page struct can be modified.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

(for this patch only, I have yet to figure out whether Anshuman's and
Mark's comments have been addressed in patch 2)

-- 
Catalin
