Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDB2C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 May 2022 14:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238721AbiEZOpw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiEZOpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:45:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2325D9EB9
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653576340; x=1685112340;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XY4xTFg1Cm+/4wGKq/OeIAMVg6gQw7TTfMCb+yZ/U80=;
  b=hr7z7Ris0PG9Vl/QxnyFQGRVqZ+TRThMnZ4nNkNx9irnn6qvpysW9Mtj
   lWYhnVePhoa2BkOYlJsRoUs047D8+6eXGqyAqccX4Rq1yQmQ1mQ+Wd6ub
   tDQ9uVpiR/3QqSwBAtiFzvva5PxIylhQLEUopqxcGFuITIZPG/9oBWosm
   CCJNAc5bFP38A60lMFB3AY+ilHA/ulD6I3SGJsT0QkyLyv8uJXX708sOH
   KFonn7uu+GX6/JyCKJnSthjkMoUI4SAOBnATnvi6xoaJRD3cvnePFrQTh
   9Fj4SBaU0tJdmBCh1R7xk64sRyrf0RMk4kAzCU9hSdDnguR9yKuoDJQQW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="271748733"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="271748733"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 07:45:35 -0700
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="527453064"
Received: from akanabar-mobl1.amr.corp.intel.com (HELO [10.212.217.237]) ([10.212.217.237])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 07:45:35 -0700
Message-ID: <ffe3ab74-4258-cf54-86df-c2db5aa06504@linux.intel.com>
Date:   Thu, 26 May 2022 07:45:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v7 2/5] x86/tdx: Add TDX Guest event notify interrupt
 support
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220524040517.703581-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yo+FN8Utbrn5FYlT@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Yo+FN8Utbrn5FYlT@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/26/22 6:48 AM, Wander Lairson Costa wrote:
> On Mon, May 23, 2022 at 09:05:14PM -0700, Kuppuswamy Sathyanarayanan wrote:
>>   
>> -#define LOCAL_TIMER_VECTOR		0xec
>> +#if IS_ENABLED(CONFIG_INTEL_TDX_GUEST)
>> +/* Vector on which TDX Guest event notification is delivered */
>> +#define TDX_GUEST_EVENT_NOTIFY_VECTOR	0xec
>> +#endif
> 
> We can simplify this a bit by removing the #if conditional without harm
> to the code.

In non TDX environment, we don't initialize this vector. It is similar
to definitions related to HYPERV or KVM which also use #if defined. So
followed the same format.

> 
>> +
>> +#define LOCAL_TIMER_VECTOR		0xeb
>>   
>>   #define NR_VECTORS			 256
>>   
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
