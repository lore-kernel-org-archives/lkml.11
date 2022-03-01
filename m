Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B40C433FE
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 01:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbiCABRH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Feb 2022 20:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCABRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:17:05 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1B110F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646097386; x=1677633386;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=43A+I2DRhzesNA9DrxPAzZEy9Kax5aljFE3cXiDt9D0=;
  b=VkzOPiGIqDJBRwWhSosS2Butuo/eMaTK0ROla3MPwWBinslpV6ulyE6o
   mzHNKJPgctJszcIWOAEglsuAiUiXkeeoZeghsM5Ioce+NIGaQXTiCAQUb
   ChM4UQFB/gs9fMBxFqZObYS3IRVjwBpC0WtouQx4at0ZHqSZZUq95uxOR
   m4zLIdc1c9DtC7DM6FLrgdMrQRDsTODRKdRVC6/mntQ0HBJR6QEpsp+U+
   DLhflkpornD7t2p31Y37C0SqjL2bJUyCql8fj4WFONWYLfZb7dyMJtt8z
   SIfYeRXwQtm5gvz8731Y93HtWSSQfwPXXHDdBtBGjfgTzDpDlE87xk4gr
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316244083"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316244083"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 17:16:24 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="550492306"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 17:16:20 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Feng Tang <feng.tang@intel.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        zhongjiang-ali <zhongjiang-ali@linux.alibaba.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH -V13 2/3] NUMA balancing: optimize page placement for
 memory tiering system
References: <20220221084529.1052339-1-ying.huang@intel.com>
        <20220221084529.1052339-3-ying.huang@intel.com>
        <YhzwO/lw1xx7EjNb@localhost.localdomain>
Date:   Tue, 01 Mar 2022 09:16:18 +0800
In-Reply-To: <YhzwO/lw1xx7EjNb@localhost.localdomain> (Oscar Salvador's
        message of "Mon, 28 Feb 2022 16:54:35 +0100")
Message-ID: <87czj6321p.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Oscar,

Oscar Salvador <osalvador@suse.de> writes:

> On Mon, Feb 21, 2022 at 04:45:28PM +0800, Huang Ying wrote:
>> b. Make kswapd of the fast memory node to reclaim pages until the free
>>    pages are a little more than the high watermark (named as promo
>>    watermark).  Then, if the free pages of the fast memory node reaches
>>    high watermark, and some hot pages need to be promoted, kswapd of the
>>    fast memory node will be waken up to demote more cold pages in the
>>    fast memory node to the slow memory node.  This will free some extra
>>    space in the fast memory node, so the hot pages in the slow memory
>>    node can be promoted to the fast memory node.
>
> The patch looks good to me, but I think I might be confused by the wording
> here.
>
> IIUC, we define a new wmark (wmark_promo) which is higher than
> wmark_high.
> When we cannot migrate a page to another numa node because it has less
> than wmark_high free pages, we wake up kswapd, and we keep reclaiming
> until we either have mark_promo pages free when
> NUMA_BALANCING_MEMORY_TIERING, or mark_high pages free. Is that right?

Yes.  And we only wake up kswapd for promotion when
NUMA_BALANCING_MEMORY_TIERING.

> Because above you say "Then, if the free pages of the fast memory node reaches
> high watermark, and some hot pages need to be promoted..."

What I wanted to say is that

If the free pages of the fast memory will become lower than the high
watermark, and some hot pages need to be promoted...

That is, "reach high watermark" here is from "free pages more than high
watermark" to "free pages lower or equal high watermark".  This appears
confusing.

> but that should read promo watermark instead? Am I missing something?

Sorry for confusing.  How about the following?

 b. Make kswapd of the fast memory node to reclaim pages until the free
    pages are a little more than the high watermark (named as promo
    watermark).  If we want to promote some hot pages from the slow
    memory to the fast memory, but the free pages of the fast memory
    node will become lower than the high watermark after promotion, we
    will wake up kswapd of the fast memory node to demote more cold
    pages in the fast memory node to the slow memory node firstly.  This
    will free some extra space in the fast memory node, so the hot pages
    in the slow memory node can be promoted to the fast memory node.

Best Regards,
Huang, Ying
