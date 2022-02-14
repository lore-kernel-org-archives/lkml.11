Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC627C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Feb 2022 18:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiBNSsK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Feb 2022 13:48:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiBNSsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:48:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1263574DEE;
        Mon, 14 Feb 2022 10:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644864472; x=1676400472;
  h=message-id:subject:from:reply-to:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ekRjbB8Xr3cd6nK9ZonihX8LkoahzdWDfNA9LgE3lAA=;
  b=aFNl57ZLk3xxN8m13d1hUEIm/QPg+Y3Mr5oterlEKWv/KTyd0K4dWvG9
   Cg9ualE/WxKUuu3Slb6RHddaGPxuSSvUbaNzyZ9emZeoKqfXRBaf3nWdN
   Ga/WDGYTcixZte2txVlfIfbwLfHJyjl5bMOLA8NQ6ML+QaNT9BzIEaopC
   Mpo5RsVliEywcizJDvBMGvvUipVEOmaK8e4CQxC66QKDUjKFCwgMhpKG0
   PGoijcHtomN0YEQgfWeP5NYCy3hjotnY+wwIlxshCbgD7F5eYAT3zhHS/
   uOg7dOOJOFKg96M8JV6+xCupbONcq/732LDKXgmukBZM1QdJ+Svr6j/94
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250365379"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="250365379"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 10:47:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="703230321"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2022 10:47:30 -0800
Received: from debox1-desk1.jf.intel.com (debox1-desk1.jf.intel.com [10.54.75.53])
        by linux.intel.com (Postfix) with ESMTP id 300B8580638;
        Mon, 14 Feb 2022 10:47:30 -0800 (PST)
Message-ID: <29515b9c1a250b060174af74299ab6187e346387.camel@linux.intel.com>
Subject: Re: [PATCH V7 2/3] tools arch x86: Add Intel SDSi provisiong tool
From:   "David E. Box" <david.e.box@linux.intel.com>
Reply-To: david.e.box@linux.intel.com
To:     Hans de Goede <hdegoede@redhat.com>, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Mon, 14 Feb 2022 10:47:30 -0800
In-Reply-To: <16187bb8-ebe6-f260-c255-530095472a03@redhat.com>
References: <20220212013252.1293396-1-david.e.box@linux.intel.com>
         <20220212013252.1293396-3-david.e.box@linux.intel.com>
         <16187bb8-ebe6-f260-c255-530095472a03@redhat.com>
Organization: David E. Box
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-14 at 11:56 +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/12/22 02:32, David E. Box wrote:
> > Add tool for key certificate and activation payload provisioning on
> > Intel CPUs supporting Software Defined Silicon (SDSi).
> > 
> > Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> > ---
> > V7
> >   - No changes.
> > V6
> >   - No changes.
> > V5
> >   - Update copyright to 2022
> > V4
> >   - No changes.
> > V3
> >   - Move from samples to tools.
> >   - Fix bit fields in availability structure.
> >   - Check provisioning availability before issuing command.
> > 
> > V2
> >   - New patch.
> > 
> >  MAINTAINERS                        |   1 +
> >  tools/arch/x86/intel_sdsi/Makefile |   9 +
> >  tools/arch/x86/intel_sdsi/sdsi.c   | 540 +++++++++++++++++++++++++++++
> >  3 files changed, 550 insertions(+)
> >  create mode 100644 tools/arch/x86/intel_sdsi/Makefile
> >  create mode 100644 tools/arch/x86/intel_sdsi/sdsi.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 29d0945f5a63..80325cbde3bd 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -9873,6 +9873,7 @@ INTEL SDSI DRIVER
> >  M:     David E. Box <david.e.box@linux.intel.com>
> >  S:     Supported
> >  F:     drivers/platform/x86/intel/sdsi.c
> > +F:     tools/arch/x86/intel_sdsi/
> >  
> >  INTEL SKYLAKE INT3472 ACPI DEVICE DRIVER
> >  M:     Daniel Scally <djrscally@gmail.com>
> > diff --git a/tools/arch/x86/intel_sdsi/Makefile
> > b/tools/arch/x86/intel_sdsi/Makefile
> > new file mode 100644
> > index 000000000000..1c2d102ff8fb
> > --- /dev/null
> > +++ b/tools/arch/x86/intel_sdsi/Makefile
> > @@ -0,0 +1,9 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +.PHONY: sdsi
> > +
> > +sdsi: sdsi.o
> > +       $(CC) -Wall $^ -o $@
> > +
> > +clean:
> > +       rm *.o sdsi
> 
> I assume that this is also going to be an official tool (next to a UI one?)
> which users may use to provision AKCs and CAPs ?
> 
> In that case the binary really should also be named intel_sdsi like the
> directory
> and an install target should be added, see for example how:
> 
> tools/arch/x86/kcpuid/Makefile
> 
> does this.

Will do.

David


