Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80B5C25B08
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 01:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242349AbiHRBFy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Aug 2022 21:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiHRBFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 21:05:51 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E213719B8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 18:05:49 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VMYSBOp_1660784746;
Received: from 30.97.48.48(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VMYSBOp_1660784746)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 09:05:46 +0800
Message-ID: <d7f85c9f-ca36-4731-e51c-840907cf1660@linux.alibaba.com>
Date:   Thu, 18 Aug 2022 09:05:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] mm/damon: Validate if the pmd entry is present before
 accessing
To:     SeongJae Park <sj@kernel.org>
Cc:     akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220817160902.98613-1-sj@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220817160902.98613-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/2022 12:09 AM, SeongJae Park wrote:
> Hi Baolin,
> 
> 
> Thank you always for your great patch!
> 
> On Wed, 17 Aug 2022 14:21:12 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
>> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
>> page, also including the case of non-present (migration or hwpoisoned)
>> pmd entry on arm64 or x86 architectures. Thus we should validate if it
>> is present before making the pmd entry old or getting young state,
>> otherwise we can not get the correct corresponding page.
> 
> Maybe I'm missing something, but... I'm unsure if the page is present or not
> really matters from the perspective of access checking.  In the case, DAMON
> could simply report the page has accessed once for the first check after the
> page being non-present if it really accessed before, and then report the page
> as not accessed, which is true.

Yes, that's the patch's goal to make the accesses correct. However if 
the PMD entry is not present, we can not get the correct page object by 
pmd_pfn(*pmd), since the non-present pmd entry will contain swap type 
and swap offset with below format on ARM64, that means the pfn number is 
saved in bits 8-57 in a migration or poisoned entry, but pmd_pfn() still 
treat bits 12-47 as the pfn number on ARM64, which may get an incorrect 
page struct (also maybe is NULL by pfn_to_online_page()) to make the 
access statistics incorrect.

/*
  * Encode and decode a swap entry:
  *	bits 0-1:	present (must be zero)
  *	bits 2:		remember PG_anon_exclusive
  *	bits 3-7:	swap type
  *	bits 8-57:	swap offset
  *	bit  58:	PTE_PROT_NONE (must be zero)
  */


Moreoever I don't think we should still waste time to get the page of 
the non-present entry, just treat it as not-accessed and skip it, that 
keeps consistent with non-present pte level entry.

Does that make sense for you? Thanks.
