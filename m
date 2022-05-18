Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE6DC433FE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 May 2022 19:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiERTvR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 15:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiERTvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 15:51:15 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78825A444;
        Wed, 18 May 2022 12:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652903473; x=1684439473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qI2hRvQWGqLlvCgm5r1r2wIsZFcii9ZgTyxajRKplqk=;
  b=HnF17rcebY7JhrTHtbMkV9gZnCRCyOeotFWbV5UC1PS6FO46q9AjRe0E
   ARodhDmCNdA5Ukt8xz95d6R9qcZPBK6Uedg7eoWuNywTnG/TdhJjpTADH
   XzomDAaau/qzQPMhtbIwwW+xgGYgQJ+WjcJQGDp7GCHovG5D3P5TPGpFO
   mJSEE80YzLz3ZNDtAN4EUIIfzR0vcRUGCS++qiBOLtFOYV2yuqULXI9R+
   0vcwOQW+iVJqB35YCmg+nAp2eNVptCfTe4+RQnHciFPPJ5sIkeEbzU1n4
   xDKoMyVTkge5FNb6uHZiZG+bM7t9LGXJqp+uSdGQnABoFHqHtCuCe0aRt
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="253913619"
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="253913619"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 12:51:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,235,1647327600"; 
   d="scan'208";a="817618883"
Received: from kackerma-mobl2.amr.corp.intel.com (HELO [10.209.69.102]) ([10.209.69.102])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 12:51:11 -0700
Message-ID: <afd96793-549d-94eb-607c-6a785788397a@intel.com>
Date:   Wed, 18 May 2022 12:51:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] Revert "mm/vmscan: never demote for memcg reclaim"
Content-Language: en-US
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <guro@fb.com>
References: <20220518190911.82400-1-hannes@cmpxchg.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220518190911.82400-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/22 12:09, Johannes Weiner wrote:
> However, with NUMA balancing now doing tier promotions, demotion is
> part of the page aging process. Global reclaim demotes the coldest
> toptier pages to secondary memory, where their life continues and from
> which they have a chance to get promoted back. Essentially, tiered
> memory systems have an LRU order that spans multiple nodes.

Thanks for the detailed explanation.  Ultimately, this was just intended
as an optimization to make cgroup reclaim more efficient.  But, I agree
that ordering correctness should trump efficiency.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>

