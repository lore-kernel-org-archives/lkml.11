Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6943CC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Apr 2022 03:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348159AbiDSDld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 23:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiDSDl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:41:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA37B1FA;
        Mon, 18 Apr 2022 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650339528; x=1681875528;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQyDAhIW68Som/ku3Jrd/qF0VCpteuvHqR0Y8MoNXvY=;
  b=RV3v7IwIAHi+ELmcPfPRCO2eB0gVjs7KEYDlif02wZJRDXpBUyksNAWN
   P22cK20zgEI+QckLFlR5VEOSJ263W/F9bTRLCTgZUkEnMZ9U+sQ939E6e
   UZO5N0UTyV99ma5dAtvE4daFaAWlQejjPf5JuUQtbmpEpwhB70DfRGU5W
   fadgDlZgD0u+ull9UjsLckkLHGiphmVF8Wi2AL6nyYspGUaeCJjAMdkL8
   E7gqU2D1Ry/Qsjw96urCZXMd1OkVXzWoL4D+pTzzoB/RZO0TLAcx5JF9p
   ABje7BJ4dAnOQ6/devUiC1yPzW+d95FAligGhPNkA3K1mFfgEydysX+rx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288760826"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="288760826"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:38:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="554524814"
Received: from jaspuehl-mobl2.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.31.185])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:38:44 -0700
Message-ID: <caa2ae100494c4604d08d9459e6d3314be2dcf26.camel@intel.com>
Subject: Re: [PATCH v3 01/21] x86/virt/tdx: Detect SEAM
From:   Kai Huang <kai.huang@intel.com>
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, peterz@infradead.org, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com, isaku.yamahata@intel.com
Date:   Tue, 19 Apr 2022 15:38:42 +1200
In-Reply-To: <8e2269a7-3e71-5030-8d04-1e8e3fc4323f@linux.intel.com>
References: <cover.1649219184.git.kai.huang@intel.com>
         <ab118fb9bd39b200feb843660a9b10421943aa70.1649219184.git.kai.huang@intel.com>
         <8e2269a7-3e71-5030-8d04-1e8e3fc4323f@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > +
> > +static void detect_seam(struct cpuinfo_x86 *c)
> > +{
> 
> why not do this check directly in tdx_detect_cpu()?

The second patch will detect TDX KeyID too.  I suppose you are saying below is
better?

void tdx_detect_cpu(struct cpuinfo_x86 *c)
{
	if (c == &boot_cpu_data) {
		detect_seam_bsp(c);
		detect_tdx_keyids_bsp(c);
	} else {
		detect_seam_ap(c);
		detect_tdx_keyids_ap(c);
	}
}

I personally don't see how above is better than the current way.  Instead, I
think having SEAM and TDX KeyID detection code in single function respectively
is more flexible for future extension (if needed).


> 
> > +	if (c == &boot_cpu_data)
> > +		detect_seam_bsp(c);
> > +	else
> > +		detect_seam_ap(c);
> > +}
> > +
> > +void tdx_detect_cpu(struct cpuinfo_x86 *c)
> > +{
> > +	detect_seam(c);
> > +}
> 

