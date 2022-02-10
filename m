Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 628CDC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 01:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbiBJB3T (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:29:19 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiBJB27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:28:59 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E67220D9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644456541; x=1675992541;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ErZtXFwJLIN8bzOwaB2g6bzU6pDmrgMvbOfEPnQnOLY=;
  b=TZRwHFUa17/aBrNn8jxPixKSekjBP/aAmrXGy+rnlg04kJZfwSI7HDT3
   THtSoG4gCtmjmdgwauNsPcgzPyGBHXnKqPR+CyY1jLs4oDhWz6qRozL3y
   KFX5Do9vh0vyjcQBB0yGbHsveVcd3pm5NMskKq5easYZouxZXjeAFmf3C
   op2YhQOdNG+7uNnruPDCG6G+b3miNbg0hxfw7dwmwf/X/racwnpddcTqE
   Lu9wtvtNwSKveoRjWEqTPey9MwsquuZTlNnpIow0u06yWdpbfyuDE2s7r
   P9mnSSGGV663k94gkf5mTTocj5Dhoy376NPstzXl6KLuLpCsAfqJkPHzu
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310114353"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="310114353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:25:41 -0800
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="701470843"
Received: from jratner-mobl.ger.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.251.129.27])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:25:35 -0800
Date:   Thu, 10 Feb 2022 13:25:32 +1300
From:   Kai Huang <kai.huang@intel.com>
To:     <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <dave.hansen@intel.com>,
        <luto@kernel.org>, <peterz@infradead.org>, <aarcange@redhat.com>,
        <ak@linux.intel.com>, <dan.j.williams@intel.com>,
        <david@redhat.com>, <hpa@zytor.com>, <jgross@suse.com>,
        <jmattson@google.com>, <joro@8bytes.org>, <jpoimboe@redhat.com>,
        <knsathya@kernel.org>, <pbonzini@redhat.com>, <sdeep@vmware.com>,
        <seanjc@google.com>, <tony.luck@intel.com>, <vkuznets@redhat.com>,
        <wanpengli@tencent.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 16/29] x86/boot: Add a trampoline for booting APs via
 firmware handoff
Message-Id: <20220210132532.5318b631924df114bc1bfccc@intel.com>
In-Reply-To: <25fec256-7feb-e94d-5e37-3a174b6c6a66@linux.intel.com>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
        <20220124150215.36893-17-kirill.shutemov@linux.intel.com>
        <Yfpqk0amEbcyte+w@zn.tnic>
        <25fec256-7feb-e94d-5e37-3a174b6c6a66@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> >> Reported-by: Kai Huang <kai.huang@intel.com>
> > I wonder what that Reported-by tag means here for this is a feature
> > patch, not a bug fix or so...
> 
> I think it was added when Sean created the original patch. I don't have the
> full history.
> 
> Sean, since this is not a bug fix, shall we remove the Reported-by tag?

Sorry just saw.  Please remove :)
