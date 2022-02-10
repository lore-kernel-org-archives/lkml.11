Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AABC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 23:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345554AbiBJXPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 18:15:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344689AbiBJXPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:15:15 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCFE5F44
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644534916; x=1676070916;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lh6tjCWAtV9Sv/IHSE2GQfvx+Z+uUWNu3HE21O/Ggpo=;
  b=YyDEIyPfT4zHrvVlbpaR7QvU7mc4TuNTKlSowSHhVwCmaRIdUlgc2Zr0
   ++MwaAoBo8K7hfzloEoSS9t65xhxavULJDl8tkR100g02KQNThqoGSKsp
   10JoINDPEMqboDh1+4c/SfvmEXBCOFpq0mf/unfCJ8nKtobbkUayCVQQv
   veT9mB17LdSopOzz4B39GCG/mJdFW+4iugn4G1LCUedymC0dwgucE0nDA
   7xChMYrhmgYMezZsqfdhP1S/1/UoVeOyGHnPraNRZ1WDVUmmMtQN1oGFc
   662juvD5MuKrv1Bmue2pnHTB3CedoZKnZWC9erOCnkafa3sVOqhiFbreX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336037762"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="336037762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 15:15:16 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="633862803"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 15:15:15 -0800
Date:   Thu, 10 Feb 2022 15:15:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YgWcfhbu3o5C6jQT@otcwcpicx3.sc.intel.com>
References: <20220207230254.3342514-1-fenghua.yu@intel.com>
 <20220207230254.3342514-6-fenghua.yu@intel.com>
 <20220209191614.5a3b42d4@jacob-builder>
 <20220210104904.6c6131f2@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210104904.6c6131f2@jacob-builder>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 10:49:04AM -0800, Jacob Pan wrote:
> 
> On Wed, 9 Feb 2022 19:16:14 -0800, Jacob Pan
> <jacob.jun.pan@linux.intel.com> wrote:
> 
> > Hi Fenghua,
> > 
> > On Mon,  7 Feb 2022 15:02:48 -0800, Fenghua Yu <fenghua.yu@intel.com>
> > wrote:
> > 
> > > @@ -1047,8 +1040,6 @@ struct iommu_sva *intel_svm_bind(struct device
> > > *dev, struct mm_struct *mm, void }
> > >  
> > >  	sva = intel_svm_bind_mm(iommu, dev, mm, flags);
> > > -	if (IS_ERR_OR_NULL(sva))
> > > -		intel_svm_free_pasid(mm);  
> > If bind fails, the PASID has no IOMMU nor CPU context. It should be safe
> > to free here.
> > 
> Actually, here we cannot tell if the bind is the first of the mm so I think
> this is fine.
> 
> Reviewed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Thank you very much for your review, Jacob!

-Fenghua
