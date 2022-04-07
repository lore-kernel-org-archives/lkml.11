Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0066C433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 01:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232977AbiDGBCt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Apr 2022 21:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiDGBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:02:48 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C65BEAC99;
        Wed,  6 Apr 2022 18:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649293250; x=1680829250;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Xr/aMM/aBRiUNqncfjg8FGIVBvzbGhbRBKe75kPJqs=;
  b=Sl3LZQN7tAFTHLEdcw/ZK9zvcYKihmVqMOft5DdlxKhXJckJruLIl18+
   ReD4kfMIaI0bdkv5ksG+gD9znjTRhjm1teRAWHbQ+A9yfQSgwfwsXERmA
   ZrNN+XRbUkD/H5GuhTKJLG7G4r/+3clefQvIpfwFsubVMYm4C+YPwEPjF
   CEosn58eBTIsjSLYHWIpp5Y0PYUKV5pa1oACsqeVsnZZ+IECaVewc/iKX
   fysG4TJRFN4lL+5O/Pf30givkpceR6hWezxljZuQNu4BVuHZgeuR4hswW
   V4evBWAOb6lm3Ok5xLzsqUKiXKgeVXo353XxNRx3iGk+f+VrguwRkitLV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10309"; a="241788577"
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="241788577"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:00:49 -0700
X-IronPort-AV: E=Sophos;i="5.90,241,1643702400"; 
   d="scan'208";a="570818409"
Received: from mgailhax-mobl.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.55.23])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 18:00:46 -0700
Message-ID: <0a717d253785b3b6ea5f889d7399ad06ca465896.camel@intel.com>
Subject: Re: [RFC PATCH v5 023/104] x86/cpu: Add helper functions to
 allocate/free MKTME keyid
From:   Kai Huang <kai.huang@intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Date:   Thu, 07 Apr 2022 13:00:44 +1200
In-Reply-To: <cec13fb656f05d8c9d231c225587072076448d71.camel@intel.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
         <a1d1e4f26c6ef44a557e873be2818e6a03e12038.1646422845.git.isaku.yamahata@intel.com>
         <2386151bc0a42b2eda895d85b459bf7930306694.camel@intel.com>
         <20220331201550.GC2084469@ls.amr.corp.intel.com>
         <cec13fb656f05d8c9d231c225587072076448d71.camel@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > 
> > Also export the global TDX private host key id that is used to encrypt TDX
> > module, its memory and some dynamic data (e.g. TDR).  
> > 

Sorry I was replying too quick.

This sentence is not correct.  Hardware doesn't use global KeyID to encrypt TDX
module itself.  In current generation of TDX, global KeyID is used to encrypt
TDX memory metadata (PAMTs) and TDRs.


> > When VMM releasing
> > encrypted page to reuse it, the page needs to be flushed with the used host
> > key id.  VMM needs the global TDX private host key id to flush such pages
> > TDX module accesses with the global TDX private host key id.
> > 
> > 
> 
> Find to me.
> 

