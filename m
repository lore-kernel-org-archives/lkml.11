Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A2AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239235AbiDHTbf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 15:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiDHTbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 15:31:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F7843EF2;
        Fri,  8 Apr 2022 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649446167; x=1680982167;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IeX+LwFKu9WkBhOrMB4NDU8d3pZ1SH+32hd88PLD2W4=;
  b=ITpHK21TcM1iohOJaQFnvsqt5KgQStAd9Ha5zDcniRDcvV6j2EnmbjaN
   SdNfKGAdVDH+w3JyiDShiN0CnvldhCTrEZ3Y3UxSLDT1KxUY3eMZyJkTw
   CbpJH2MR/SdFV1ot2KvVSzWBiQb1MiMLWc8NrLPHCkO5wjniWWM8jCFLu
   v6IAIQZGudoYqacst+ngr7AE0I1lb0SEx/K/mSTtZ+WaV+1h+zdBj8Hg6
   T8kKj3KfTku7oIbPO+UF1FCffEqNHJX+wuFTrHLqzUJjpHpiGsdeDS/3q
   Wu5/Wzo/MxMMmT+Wq/wonQZWtPnJm/AzxT+oXiBwuRkxuAFesngYmXWnJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="249199123"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="249199123"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:29:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="506670178"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 12:29:26 -0700
Date:   Fri, 8 Apr 2022 12:29:24 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Koralahalli Channabasappa, Smita" <skoralah@amd.com>
Cc:     Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [RFC PATCH 5/5] x86/mce: Handle AMD threshold interrupt storms
Message-ID: <YlCNFCZgV0tOk4LI@agluck-desk3.sc.intel.com>
References: <20220406063542.183946-1-Smita.KoralahalliChannabasappa@amd.com>
 <20220406063542.183946-6-Smita.KoralahalliChannabasappa@amd.com>
 <b140590dadea411ca3641b0537bfcd9f@intel.com>
 <30c01863-85ef-4cd4-9e73-340e2d98b9bf@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30c01863-85ef-4cd4-9e73-340e2d98b9bf@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 02:48:47AM -0500, Koralahalli Channabasappa, Smita wrote:
> Hi,
> 
> On 4/6/22 5:44 PM, Luck, Tony wrote:
> 
> > +		/* Return early on an interrupt storm */
> > +		if (this_cpu_read(bank_storm[bank]))
> > +			return;
> > 
> > Is you reasoning for early return that you already have plenty of
> > logged errors from this bank, so OK to skip additional processing
> > of this one?
> 
> The idea behind this was: Once, the interrupts are turned off by
> track_cmci_storm() on a storm, (which is called before this "if
> statement") logging and handling of subsequent corrected errors
> will be taken care by machine_check_poll(). Hence, no need to
> redo this again in the handler....
> 
> Let me know what are your thoughts on this?

Makes sense. There's a storm, so picking up this error now,
or waiting for machine_check_poll() to get it makes little
difference.

-Tony
