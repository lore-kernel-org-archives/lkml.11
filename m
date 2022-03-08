Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8178BC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 02:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiCHCMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 21:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiCHCMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 21:12:10 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B362722BDF
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 18:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646705475; x=1678241475;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=G+wlG1e5jlQm2JpD3zgFHXxJ97ey1tEQEMtTK2VbvrI=;
  b=ZmyLoD76WFRzm760NJYG028prmzcz2NrtqSmVjJj3IfM1WW+hiIvgOcY
   Fog+370pSx65Ka8YEzxoZ5yqVsgoT3lRMsjymZSNoaZA/RxARn8/231vB
   Q1MABRqugtEdvuIiiJp30uAK6Ay4qyNvqyYeROi0++O/gQU7hdn1QN6m/
   34nZV+ukz6fzhcnxtbNEyon0v35A6LpGc0+qqKWdvaqHK404Y9XgmIW5G
   VFtdaAP7LuoK0LA8EAkqRPsp0Oqs6THw0o6A9mkMjag3+xMqMpBuIjaQM
   M6PigH15heC5IYK+NbeotbpXNZguX0Dym0ouYmPv43EMiUkjmVBpYxvNL
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="242001779"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="242001779"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 18:11:15 -0800
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="512926436"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 18:11:13 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 2/2 UPDATE] NUMA balancing: avoid to migrate task to
 CPU-less node
References: <20220214121553.582248-1-ying.huang@intel.com>
        <20220214121553.582248-2-ying.huang@intel.com>
        <87y21lkxlv.fsf_-_@yhuang6-desk2.ccr.corp.intel.com>
Date:   Tue, 08 Mar 2022 10:11:11 +0800
In-Reply-To: <87y21lkxlv.fsf_-_@yhuang6-desk2.ccr.corp.intel.com> (Ying
        Huang's message of "Tue, 08 Mar 2022 10:05:16 +0800")
Message-ID: <87tuc9kxc0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

"Huang, Ying" <ying.huang@intel.com> writes:

> In a typical memory tiering system, there's no CPU in slow (PMEM) NUMA
> nodes.  But if the number of the hint page faults on a PMEM node is
> the max for a task, The current NUMA balancing policy may try to place
> the task on the PMEM node instead of DRAM node.  This is unreasonable,
> because there's no CPU in PMEM NUMA nodes.  To fix this, CPU-less
> nodes are ignored when searching the migration target node for a task
> in this patch.
>
> To test the patch, we run a workload that accesses more memory in PMEM
> node than memory in DRAM node.  Without the patch, the PMEM node will
> be chosen as preferred node in task_numa_placement().  While the DRAM
> node will be chosen instead with the patch.
>
> Known issue: I don't have systems to test complex NUMA topology type,
> for example, NUMA_BACKPLANE or NUMA_GLUELESS_MESH.
>
> v3:
>
> - Fix a boot crash for some uncovered marginal condition.  Thanks Qian
>   Cai for reporting and testing the bug!
>
> - Fix several missing places to use CPU-less nodes as migrating
>   target.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reported-and-tested-by: Qian Cai <quic_qiancai@quicinc.com> # boot crash
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

Can you update the patch to fix the bug?  Or you prefer the incremental
patch?

Best Regards,
Huang, Ying
