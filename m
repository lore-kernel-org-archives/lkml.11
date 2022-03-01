Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F845C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Mar 2022 19:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiCATwn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiCATwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:52:38 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26CB6E546
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 11:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164305; x=1677700305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+3NrUlf9Wkgu+Vf7MKNPaVPzoo3R7L3C1fJJ7wyPj0=;
  b=i63prrElQ1lMNYZDzLUjEwMYvLSmFZ73oz9j/EEFkD8Tt2WQdu/YHuXs
   u8c9isZA8YUdt1KigV6kLvQRe7/wDkgMCJNVZD7+3vQHEDqMlU1nzYThq
   UBX+dJ+p8cq07KZ565QkevEtftB2roAbshJm7ycplhi+pGE1Adub+b4Fn
   dxA3U7EZtty/zZoQq0zvoZSQfPWuwJ/3C4O1zZ7GrCAbKxoNBc702YDQo
   PKV8rON72iHBNkD8UU8O5VFC4GulzJ0ZcrFcFW+YvhVT+j2JSFaaaj/qM
   ngM7NxdgLo1+BBGtwSc9kK18EfasK1FMe9pUCUjqMyxm8vMiGUB1r77GE
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="252052872"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="252052872"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:50:41 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="545217614"
Received: from bklinvil-mobl.amr.corp.intel.com (HELO localhost) ([10.212.48.220])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:50:41 -0800
Date:   Tue, 1 Mar 2022 11:50:41 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 41/44] kmap: Ensure kmap works for devmap pages
Message-ID: <Yh55EQ4BTN/VNpAI@iweiny-desk3>
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-42-ira.weiny@intel.com>
 <CAPcyv4h1Q6H6_VApe3eFhEwe0McqbrFGRmy9rzFSPP0ATsTeTw@mail.gmail.com>
 <Yh535Zqe/GtuF/Xh@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yh535Zqe/GtuF/Xh@iweiny-desk3>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:41AM -0800, Ira Weiny wrote:
> On Fri, Feb 04, 2022 at 01:07:10PM -0800, Dan Williams wrote:
> > On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
> > >
> > > From: Ira Weiny <ira.weiny@intel.com>
> > >
> 
> > 
> > > Co-opt the kmap_{local_page,atomic}() to mediate access to PKS protected
> > > pages via the devmap facility.  kmap_{local_page,atomic}() are both
> > > thread local mappings so they work well with the thread specific
> > > protections available.
> > >
> > > kmap(), on the other hand, allows for global mappings to be established,
> > > Which is incompatible with the underlying PKS facility.
> > 
> > Why is kmap incompatible with PKS? I know why, but this is a claim
> > without evidence. If you documented that in a previous patch, there's
> > no harm and copying and pasting into this one. A future git log user
> > will thank you for not making them go to lore to try to find the one
> > patch with the  details.
> 
> Good point.
> 

FWIW, I just noticed the previous paragraph mentioned the PKS protections were
thread local.  I'll still reiterate and clarify here.

Ira
