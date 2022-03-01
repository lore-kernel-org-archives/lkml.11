Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD0C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 08:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiCAI4h (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiCAI4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 03:56:36 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94000527D8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 00:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646124956; x=1677660956;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=q9CSw9+KwZyY3pFgpvMt2nuLZL9noym1PdGJ279DFHI=;
  b=PzBF8XmzjXIzYqei0mnallmT7KCC+3vfLf+srmkIgbB4/324q2zBvlJq
   kgOUXZfYXnaqDQGveAQp6hh4mwSBAiHygE+SqzNkIKFTlqWewNZb4OLtE
   UihiOHZStDxfyvwNF1FmNGBQazlf5R3bYJHe52oyOZHfffCTuwEX0hyIB
   0cvWD9WOuAumKBvCt4ucnS5YHVpI7a4zpP9wrdejxcAncf880J6BgSpNV
   iQp90Uns9y1FB9NCN49s7iqmJJe49A+iVEOD+WUOe3aaREkuGy2XjtI+O
   iXI90LmYkz6vDrygOkRvIyy1zkfi5ZD2ip98zctdi8gQirx+zwNRJUXad
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316305201"
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="316305201"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 00:55:56 -0800
X-IronPort-AV: E=Sophos;i="5.90,145,1643702400"; 
   d="scan'208";a="534814602"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 00:55:52 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Wei Xu <weixugc@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH -V14 0/3] NUMA balancing: optimize memory placement for
 memory tiering system
References: <20220301085329.3210428-1-ying.huang@intel.com>
Date:   Tue, 01 Mar 2022 16:55:51 +0800
In-Reply-To: <20220301085329.3210428-1-ying.huang@intel.com> (Huang Ying's
        message of "Tue, 1 Mar 2022 16:53:26 +0800")
Message-ID: <87zgma127c.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew,

There are no any code change in this new version.  I just revised the
patch description based on comments.

Best Regards,
Huang, Ying
