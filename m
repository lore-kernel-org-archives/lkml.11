Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06666C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 10:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbiDNKWB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 06:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240820AbiDNKV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:21:56 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB14201B3;
        Thu, 14 Apr 2022 03:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649931571; x=1681467571;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1H7W2dFZu874zyjYcwHjCram/hpVx9FDF3bHVg0Fut4=;
  b=NcBlD+olaD2HhfB8E34eeyLLgSc8jN+vTfakNoCkfjOaYZM0UKO5SUez
   4vdJA7uGzt+Oou+JxDaDelFP5Zlt7A0Ra1admxWhIxra75lS4T6goKDal
   eI1BWr61XvwEJ592rBpd99s6H6vVSg1KYhrVvqAHtJUHegY6A22LlZuI0
   1aF+vLIi/CpY1K7eLvHG4BY7hK9sNQIrKMDJKzUgL0z3SoxgVbbamdWs/
   a9vW9CKmUJWfswKSsVYSBLcieOPYNd+CMCRwqaVnK32nFdAbLX4PpKtBs
   zxKhFsDPrvzqymdrynwZ33/V/NsUT5snyTouNdYsU74WPrTpm3vbZHgLU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="325804271"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="325804271"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 03:19:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="612282028"
Received: from simerjee-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.56.41])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 03:19:28 -0700
Message-ID: <a455029a6420b3ea31489063a8b613d5a1578300.camel@intel.com>
Subject: Re: [PATCH v3 00/21] TDX host kernel support
From:   Kai Huang <kai.huang@intel.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     seanjc@google.com, pbonzini@redhat.com, dave.hansen@intel.com,
        len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, peterz@infradead.org, ak@linux.intel.com,
        kirill.shutemov@linux.intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        isaku.yamahata@intel.com
Date:   Thu, 14 Apr 2022 22:19:26 +1200
In-Reply-To: <cover.1649219184.git.kai.huang@intel.com>
References: <cover.1649219184.git.kai.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-04-06 at 16:49 +1200, Kai Huang wrote:
> Intel Trusted Domain Extensions (TDX) protects guest VMs from malicious
> host and certain physical attacks.  This series provides support for
> initializing the TDX module in the host kernel.  KVM support for TDX is
> being developed separately[1].
> 
> The code has been tested on couple of TDX-capable machines.  I would
> consider it as ready for review. I highly appreciate if anyone can help
> to review this series (from high level design to detail implementations).
> For Intel reviewers (CC'ed), please help to review, and I would
> appreciate Reviewed-by or Acked-by tags if the patches look good to you.

Hi Intel reviewers,

Kindly ping.  Could you help to review?

--
Thanks,
-Kai


