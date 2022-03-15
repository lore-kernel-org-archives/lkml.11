Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2226DC433FE
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Mar 2022 21:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbiCOVsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiCOVst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:48:49 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3865E4B842;
        Tue, 15 Mar 2022 14:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647380857; x=1678916857;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sxJ0PeNFpa8k8NqCl/p0Z4qDp7WiPd3vqrAMJehfQmo=;
  b=LACXnHid7Y5b8ru8cLRrVZYZu+1dqfnT8makL7oB1mPROiMAVE6/1evK
   kJ/P03bXWRIcxUjIsXrNxzqN8M6JDELCeVgF20eBlal+vrlV5bfIixZnq
   mM3eA5GHot8eDFGV4rbAJOF+7ynw45IwVmhWFYhDwJjNH5FwHH1PAFukW
   4k+g/yOHaA630K9ZQmfFzKSdUWJEb9ivON2bmSIwuLko9ihbs/IGnVINw
   w3ctcchxITDIflNvDs8gqVPimxf8VCB677bWAHjaiYIbl7FKrnIHgLmss
   oAZGPT5rEG6wQ1StzrONSY+Xq8gwlJggRMDVD+OUlFWQQTozFgAiHZNd5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256153206"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="256153206"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:47:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="549751434"
Received: from mtakoush-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.254.51.132])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 14:47:33 -0700
Message-ID: <9b90aaac2d55674550d35ce5a4ddd604825423c3.camel@intel.com>
Subject: Re: [RFC PATCH v5 010/104] KVM: TDX: Make TDX VM type supported
From:   Kai Huang <kai.huang@intel.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     isaku.yamahata@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Date:   Wed, 16 Mar 2022 10:47:31 +1300
In-Reply-To: <20220315210350.GE1964605@ls.amr.corp.intel.com>
References: <cover.1646422845.git.isaku.yamahata@intel.com>
         <0596db2913da40660e87d5005167c623cee14765.1646422845.git.isaku.yamahata@intel.com>
         <18a150fd2e0316b4bae283d244f856494e0dfefd.camel@intel.com>
         <20220315210350.GE1964605@ls.amr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-03-15 at 14:03 -0700, Isaku Yamahata wrote:
> On Mon, Mar 14, 2022 at 12:08:59PM +1300,
> Kai Huang <kai.huang@intel.com> wrote:
> 
> > On Fri, 2022-03-04 at 11:48 -0800, isaku.yamahata@intel.com wrote:
> > > From: Isaku Yamahata <isaku.yamahata@intel.com>
> > > 
> > > As first step TDX VM support, return that TDX VM type supported to device
> > > model, e.g. qemu.  The callback to create guest TD is vm_init callback for
> > > KVM_CREATE_VM.  Add a place holder function and call a function to
> > > initialize TDX module on demand because in that callback VMX is enabled by
> > > hardware_enable callback (vmx_hardware_enable).
> > 
> > Should we put this patch at the end of series until all changes required to run
> > TD are introduced?  This patch essentially tells userspace KVM is ready to
> > support a TD but actually it's not ready.  And this might also cause bisect
> > issue I suppose?
> 
> The intention is that developers can exercise the new code step-by-step even if
> the TDX KVM isn't complete.

What is the purpose/value to allow developers to exercise the new code step-by-
step?  Userspace cannot create TD successfully anyway until all patches are
ready.

-- 
Thanks,
-Kai
