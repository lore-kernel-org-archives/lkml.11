Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3921C433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 13:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348721AbiCONci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 09:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348699AbiCONcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:32:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA6E51307;
        Tue, 15 Mar 2022 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647351079; x=1678887079;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=l3FFNBnyruc55ZkrcTRN2YwGaSvieHvJ8ZAP2IQOlf0=;
  b=nt3d/Yv5PNM34fQDOrIjj1zKC6ko900JLfWDS08ZV8mE8WPpiJFvAN2Y
   M2kQTl4jdYJjnN0n+5tS87wqzhEZQ/dZb2PcfGFJKM0cQ+a29tPeHdXR8
   evcT3FGHS4TnkpQuV77XrfWBdouRgbKDVXhRrFBQA9DSt62abKzsRuOMN
   ydI/YI6Tvoo+FS5GOqiujsyVHp80mDmBzd1ONrR/jPgGMTPt7K0XAx6DS
   h657en2XHfoMoed+4rN8RE8B3kHJkGVELxR6imMpDAJkDSgeO6G+ncfDH
   AWnyo0p93iEsC8+yqW0xbscSDV0A4vIRdZN4IAQH04wB82SEOzUS4ga3s
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="281069239"
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="281069239"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:30:53 -0700
X-IronPort-AV: E=Sophos;i="5.90,183,1643702400"; 
   d="scan'208";a="549596268"
Received: from rgatlin-mobl.amr.corp.intel.com (HELO [10.251.10.152]) ([10.251.10.152])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 06:30:52 -0700
Message-ID: <314aea98-7054-09aa-042d-a91796dcbd43@intel.com>
Date:   Tue, 15 Mar 2022 06:30:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        pbonzini@redhat.com, seanjc@google.com, srutherford@google.com,
        ashish.kalra@amd.com, darren.kenny@oracle.com,
        venu.busireddy@oracle.com, boris.ostrovsky@oracle.com,
        kvm@vger.kernel.org
References: <20220309220608.16844-1-alejandro.j.jimenez@oracle.com>
 <8498cff4-3c31-f596-04fe-62013b94d7a4@intel.com>
 <746497ff-992d-4659-aa32-a54c68ae83bf@oracle.com>
 <20220314224346.GA3426703@ls.amr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC 0/3] Expose Confidential Computing capabilities on sysfs
In-Reply-To: <20220314224346.GA3426703@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 15:43, Isaku Yamahata wrote:
>                 xfam_fixed0        fixed-0 value for TD xfam value as a
>                                    hexadecimal number with the "0x" prefix.
>                 xfam_fixed1        fixed-1 value for TD xfam value as a
>                                    hexadecimal number with the "0x" prefix.

I don't think we should be exporting things and creating ABI just for
the heck of it.  These are a prime example.  XFAM is reported to the
guest in CPUID.  Yes, these may be used to help *build* XFAM, but
userspace doesn't need to know how XFAM was built.  It just needs to
know what features it can use.


