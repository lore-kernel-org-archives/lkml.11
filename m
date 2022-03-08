Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D374C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 20:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350245AbiCHUei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbiCHUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:34:37 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A88B2E0A8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 12:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646771620; x=1678307620;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=t9mXcqYkKMLoTXPnC2xeKyNs9DuUIYQRxyY8sYPhpg0=;
  b=MzSclyr2gGExw3XllTS2rWcWJqvUhDV3shpmlVJB+bJpjnxZwxqGqLeP
   XssI+SFgDgNi/AZrXIakPBkIeACl2PqAZXND9mtNkSwv6PbsUlHQf4sxf
   /KsYEeOXMCFIPkKUEAheRc6vA6gCJRuKqFWYi07ODCuzu6+hVfWE7beyR
   3QrySByhciWmAHb6nMRRK5R8lOWTjfNTIOHkNxBLCeNmsqDeIT1Qkc+NE
   yi+LGlJyXTULMtdOb54vWuOlNDEX6BUGcOvNWYmewUFTZQLtr+6iYAC1B
   X2yy3crSCWDn1cKtbfgqf2GDzcydgdeo+nBUL+5XKT1I75XNNGpdm7Ciu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254997106"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="254997106"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:33:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="547396698"
Received: from ntebyanx-mobl7.amr.corp.intel.com (HELO [10.212.224.65]) ([10.212.224.65])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 12:33:39 -0800
Message-ID: <133a741f-02ae-49bd-1bc4-87ec42ab024b@intel.com>
Date:   Tue, 8 Mar 2022 12:33:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-11-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv5 10/30] x86/tdx: Handle CPUID via #VE
In-Reply-To: <20220302142806.51844-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 06:27, Kirill A. Shutemov wrote:
> In TDX guests, most CPUID leaf/sub-leaf combinations are virtualized
> by the TDX module while some trigger #VE.
> 
> Implement the #VE handling for EXIT_REASON_CPUID by handing it through
> the hypercall, which in turn lets the TDX module handle it by invoking
> the host VMM.
> 
> More details on CPUID Virtualization can be found in the TDX module
> specification, the section titled "CPUID Virtualization".
> 
> Note that VMM that handles the hypercall is not trusted. It can return
> data that may steer the guest kernel in wrong direct. Only allow  VMM
> to control range reserved for hypervisor communication. Return all-zeros
> for any CPUID outside the range.
> 
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

It would be nice to also mention the implications of the all-zero CPUID
policy.  I'll plan to add a sentence or two when we apply this.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
