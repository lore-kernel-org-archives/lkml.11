Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4965AC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jun 2022 15:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240787AbiFFPhV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jun 2022 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240867AbiFFPhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:37:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877221C13C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654529835; x=1686065835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/xJVlrzvB0ZyAOelEUbAeApqQ9bzGpQ7WVJHyZbehPg=;
  b=K5xJ1vs1TnQCICeCalHzlHE1Oo05n+vCAA1LKeDUtuwWqKpPQ8gj4Gi6
   +eFmlh9JXf73Ko6RUP8HyejsfchJakOhqTc0nAfVAz2/h9Omp0Tai/0nL
   XsWnC5dkGPHm4DkRxzK19KrYqF9ddXYGY+y3pI3b6Whdaj+oljNWmylU6
   V6VtyrotH3SO7dlYhsMro53vLeCAr8ZWpBakjx0OTgbQq6sB1T0TyvvHi
   +Ld7r6wm0vFjoEqNe6kw2g/OhVLjbnDPa7chYc3GieBxxALxznHq1pN+A
   8fZzjnbQi3bI5zOe59w8fohJRDUwIJf+AlL5KwOEUh/hI48VxvAsbhJ4r
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="363008346"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="363008346"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 08:37:15 -0700
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="825879988"
Received: from kplovato-mobl1.amr.corp.intel.com (HELO [10.212.186.68]) ([10.212.186.68])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 08:37:14 -0700
Message-ID: <0f8417ab-a0f8-82d9-c075-594e5f5fd835@intel.com>
Date:   Mon, 6 Jun 2022 08:37:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>, Wyes Karny <wyes.karny@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <cover.7d2ba81d1918bbfd8ae5e6774db8da0502f7ed67.1653324016.git-series.wyes.karny@amd.com>
 <67ca737f7cdabfc75f930cf59b49d910d8c491d6.1653324016.git-series.wyes.karny@amd.com>
 <1cc1af5000ceb5197c3b266ac82e7770d771a7b4.camel@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <1cc1af5000ceb5197c3b266ac82e7770d771a7b4.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/22 05:50, Zhang Rui wrote:
> I couldn't evaluate the impact to other vendors, but at least for
> Intel platforms,
> 
> Test-by: Zhang Rui <rui.zhang@intel.com>

I you mean:

Tested-by: Zhang Rui <rui.zhang@intel.com>

right?
