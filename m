Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E99C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Feb 2022 21:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244440AbiBOVga (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:36:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243511AbiBOVg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:36:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07569AD87
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644960975; x=1676496975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8gzKBru8GgOzz6cp/s/35s7HP2t1xdgR2V/cuCWSmiI=;
  b=Ei6gvXUgZXKWwOdP2Y4HNCvCKgRnjDhMsO6z/aUDwDuB1zpeSf0QVMUQ
   S6K6a4UqqlQKGxtk9gJSetsO58HoV3wfIHH8w6KswW6ltpstM7ZTDZdWW
   g0wt2TFk3Ck05CBOU/3MW+K1J95mFoU3ipTb+uTZPxcjBSbP048FFHKbD
   zu3TW/cdzFimCDWHpIliN+Uisqz34n8CU0x4rzqYauJVJkUOnkZtPANtk
   MMb6wyyUO+ZhzUqbx6T8IzdhNW6JCIsJPdu917AhTnKP35EcTORcHgpds
   kTOifmfbTzah05yDcN2pv19kt7o2Irj6yY6Z5+/TmgnUS0/IqfRBv7QNA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250404639"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250404639"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 13:36:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="539553214"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 15 Feb 2022 13:36:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 640A1166; Tue, 15 Feb 2022 23:36:24 +0200 (EET)
Date:   Wed, 16 Feb 2022 00:36:24 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Kai Huang <kai.huang@intel.com>
Subject: Re: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Message-ID: <20220215213624.tzdahmbhucupwtqe@black.fi.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
 <Yfpqk0amEbcyte+w@zn.tnic>
 <25fec256-7feb-e94d-5e37-3a174b6c6a66@linux.intel.com>
 <Yf0vB+TBR2AjHmV5@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yf0vB+TBR2AjHmV5@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 02:49:59PM +0100, Borislav Petkov wrote:
> On Fri, Feb 04, 2022 at 03:27:19AM -0800, Kuppuswamy, Sathyanarayanan wrote:
> > trampoline_start and sev_es_trampoline_start are not mutually exclusive.
> > Both are
> > used in arch/x86/kernel/sev.c.
> 
> I know - I've asked Jörg to have a look here.
> 
> > But trampoline_start64 can be removed and replaced with trampoline_start.
> > But using
> > _*64 suffix makes it clear that is used for 64 bit(CONFIG_X86_64).
> > 
> > Adding it for clarity seems to be fine to me.
> 
> Does it matter if the start IP is the same for all APs? Or do will there
> be a case where you have some APs starting from the 32-bit trampoline
> and some from the 64-bit one, on the same system? (that would be weird
> but what do I know...)

I'm not sure I follow. SMP bring up is new topic for me.

We want a single kernel binary that boots everywhere, so we cannot know at
build time if a secondary CPU will start in 32- or 64-bit mode.

How can signle trampoline_start cover all cases?

-- 
 Kirill A. Shutemov
