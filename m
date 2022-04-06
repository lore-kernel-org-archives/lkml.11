Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2571C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Apr 2022 14:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbiDFOfV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiDFOfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:35:09 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F9B27DEAF;
        Tue,  5 Apr 2022 19:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649211806; x=1680747806;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWSZigN9zjZPcQHDhvD/0azSxy/Mi8BXWsISXs8a9Kw=;
  b=SO/I1jn2EfX07pWz/EBTjLozS9N2SRuPZkw+7TpPtSzBohUpVjnCSXL/
   pmRm4rApuUO1Y+dF7nTlJf7NFXE3h9T2t484gf01F7ibhURV3Q7gjEEHr
   2rkOjjuaTqo3egvp01FEv5Lq0/KgLLy9SgbBPTeB9PUlMYTy6CkPaI42g
   ZkHcYKIJeT7Cke03+areLPRegSTYtDg5ZHTdK//ypi7OS16gk4kqbgAb8
   rAoqVfl8PezquZazu1JZLM9fhcutYOH9Pyt/aedDF+jiw3z05J75bnbCu
   IrL9qnlogw8uXSEpOgTkmAp69cCkpGrYwJhFP5PLxzPoAbHB9k5B4djf/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="321626941"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="321626941"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 19:23:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="658274055"
Received: from dchang1-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.29.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 19:23:23 -0700
Message-ID: <f9cd6947441e43cc27a6b21a089da61bb7fed9b0.camel@intel.com>
Subject: Re: [RFC PATCH v5 033/104] KVM: x86: Add infrastructure for stolen
 GPA bits
From:   Kai Huang <kai.huang@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, isaku.yamahata@intel.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     isaku.yamahata@gmail.com, Jim Mattson <jmattson@google.com>,
        erdemaktas@google.com, Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Date:   Wed, 06 Apr 2022 14:23:20 +1200
In-Reply-To: <5443b630-d2c8-b0c3-14f5-2b6b3f71221c@redhat.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
         <a21c1f9065cf27db54820b2b504db4e507835584.1646422845.git.isaku.yamahata@intel.com>
         <2b8038c17b85658a054191b362840240bd66e46b.camel@intel.com>
         <5443b630-d2c8-b0c3-14f5-2b6b3f71221c@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > > 
> > >  
> > > -		gfn = gpte_to_gfn(gpte);
> > > +		gfn = gpte_to_gfn(vcpu, gpte);
> > >  		pte_access = sp->role.access;
> > >  		pte_access &= FNAME(gpte_access)(gpte);
> > >  		FNAME(protect_clean_gpte)(vcpu->arch.mmu, &pte_access, gpte);
> > 
> > In commit message you mentioned "Don't support stolen bits for shadow EPT" (you
> > actually mean shadow MMU I suppose), yet there's bunch of code change to shadow
> > MMU.
> 
> It's a bit ugly, but it's uglier to keep two versions of gpte_to_gfn.

gpte_to_gfn() is only used in paging_tmpl.h.  Could you elaborate why we need to
keep two versions of it?


-- 
Thanks,
-Kai


