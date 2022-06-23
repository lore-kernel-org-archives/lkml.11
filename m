Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F29C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 04:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiFWEn3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 00:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241110AbiFWDik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:38:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10435271
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655955519; x=1687491519;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U5JwulRGEY1I1BJUk8tkPc0NZfI5FzapZ/tvQYnIU7A=;
  b=L6TQ795FlAUEmi45WH7cVPx001dKc11mPcKdjeFpStuMaqF1RrkgG4yy
   DP2S+MKNaniSQwufKomiW8xtYScyLBGZFIz+YBqTImOqOvq8mQq3jXMzo
   v2fpSUi3eyzI9f9QGrq2LYds37+r5M0pfnoryQHxDg9qfzGcRwrpjBD5h
   AO3OlbV9wYrxQW/DNNN6n0rsEpFSBpH/j3ytsOPlYGPOQQeWghO6gKdHc
   T9s7Ay4IDTyTSUTB6hfNzKbux07M+sYQFd9ibcJ7LkL+wgHBZw6rV4bcf
   hNzp/lxQuQcqVTyLnLl5mIRZnJEBy+i82reS5WtBtg8vpqooli8EcBt9Y
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281342007"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281342007"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 20:38:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="644525123"
Received: from yutaoxu-mobl.ccr.corp.intel.com (HELO [10.249.172.190]) ([10.249.172.190])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 20:38:36 -0700
Message-ID: <f3139dc1-2530-bb24-93ae-a74f895822c8@linux.intel.com>
Date:   Thu, 23 Jun 2022 11:38:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Steve Wahl <steve.wahl@hpe.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kyung Min Park <kyung.min.park@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iommu/vt-d: Make DMAR_UNITS_SUPPORTED a config setting
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>
References: <9d6177ac-802f-eb11-4307-b0e49d8126b5@linux.intel.com>
 <20220615183650.32075-1-steve.wahl@hpe.com>
 <96984350-3a04-812a-60f1-a09138014fac@linux.intel.com>
 <CALzcdduhpOebY18hiOpMcXLcH83bY_u4fZT09pBcoz2ObqXnGg@mail.gmail.com>
 <f0e4adc8-5d67-b76a-d0f1-2df83bd69a82@linux.intel.com>
 <20220623025126.ld45k72c2okodvvk@cantor>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220623025126.ld45k72c2okodvvk@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/23 10:51, Jerry Snitselaar wrote:
>> The real problem here is that the iommu sequence ID overflows if
>> DMAR_UNITS_SUPPORTED is not big enough. This is purely a software
>> implementation issue, I am not sure whether user opt-in when building a
>> kernel package could help a lot here.
>>
> Is this something that could be figured out when parsing the dmar
> table? It looks like currently iommu_refcnt[], iommu_did[], and
> dmar_seq_ids[] depend on it.

That's definitely a better solution.

Best regards,
baolu
