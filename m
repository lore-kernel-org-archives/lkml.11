Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A81C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 03:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiBJDNQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 22:13:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiBJDNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:13:14 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F191EAE1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644462797; x=1675998797;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZcyIvusHwZnfRVfKt2PwWs6i0TMwMkq3rmt+VlQRRGM=;
  b=h3zM5TecLiM1PKMjh/F6EWB2LAoFjoKcUEmnOm1VuuxkcDBTDwizmkVs
   zcdUnBS9d7xig1SXcJ+tVaGpxDY4ogBB3+TrMMwH2Izr98sya21seIxnS
   Sf5ZL8J8BZzh2ncKM2fm8u31Al5PoVXzRQqcOEuvh9lZw+2vZZ52dfW5h
   6lWs8EHlFQms2eZ4nTYe9z+cfXDL3OvnQK/iRvdBdAHrLzZmKSCq9iJ9O
   AAghwDr1YjCAYO0McOpZJoT0d9AVyYGfXNsT9ytU9mirhAkRvw4dddpua
   iFE9AZoi+kGtbqggMZgVhKPlbAjNYTT3Muu9FL1zT7kxxnW76MjJK9t6Y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="335813000"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="335813000"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 19:13:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="485527252"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 19:13:16 -0800
Date:   Wed, 9 Feb 2022 19:16:14 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Tony Luck" <tony.luck@intel.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, "x86" <x86@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <20220209191614.5a3b42d4@jacob-builder>
In-Reply-To: <20220207230254.3342514-6-fenghua.yu@intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
        <20220207230254.3342514-6-fenghua.yu@intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com> wrote:

> @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> *dev, struct mm_struct *mm, void }
>  
>  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> -	if (IS_ERR_OR_NULL(sva))
> -		intel_svm_free_pasid(mm);
If bind fails, the PASID has no IOMMU nor CPU context. It should be safe to
free here.

Thanks,

Jacob
