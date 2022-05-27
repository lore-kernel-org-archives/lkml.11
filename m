Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C231CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 02:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233957AbiE0CQ3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 May 2022 22:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiE0CQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 22:16:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1230ADE337;
        Thu, 26 May 2022 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653617785; x=1685153785;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7wcML4YcopdOTdMnWTUfdcf3U1Fv9g7lT9KTevkhGuU=;
  b=PzH7PEdMYiZKxaDk76u0OtJUehgAO7BBHiPjgwvUFNM/B/8Pz70K1Oz+
   GmgxDIauQBBPD0hNRfqFG3KGjs5y7u5dJwWZ//YHjgO2WKVTIFJUoXxv5
   FvwUfgfBP7mbzt1gMFJQcZ215gmdhFcj9Cv9XcHetsQ7/62/fKk1BHz4x
   KKx+WUZOkKy76WzJ4xX5Cvy6uO35ZnFP8dmDeKuIeFa3V2euToqH15fuK
   IY/LNSNbeerIKKznGMFAtWOABDKKPFaGL3ymbZfdK1s/6HetNxujeJj/t
   IUfAuI9IzqTNpGlAzGyJIASaScXx/ACmXi0o1mO1y82/bF7errnHfEpSr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="274360197"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="274360197"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 19:16:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="704888819"
Received: from leiwang7-mobl.ccr.corp.intel.com (HELO [10.254.211.236]) ([10.254.211.236])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 19:16:22 -0700
Message-ID: <2a2dacc7-c907-1af4-bc97-326860a21759@intel.com>
Date:   Fri, 27 May 2022 10:16:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v7 2/8] KVM: VMX: Add proper cache tracking for PKRS
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, chenyi.qiang@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220424101557.134102-1-lei4.wang@intel.com>
 <20220424101557.134102-3-lei4.wang@intel.com> <Yo1Hemue8+l5CPIT@google.com>
From:   "Wang, Lei" <lei4.wang@intel.com>
In-Reply-To: <Yo1Hemue8+l5CPIT@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/2022 5:00 AM, Sean Christopherson wrote:
> The patch looks fine, but this needs to be moved to the end of the series.
> Definitely after "KVM: VMX: Expose PKS to guest", and maybe even after "KVM: VMX:
> Enable PKS for nested VM".

OK, will do that.

