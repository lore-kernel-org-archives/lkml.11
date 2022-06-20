Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7CAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 09:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbiFTJpE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiFTJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:45:01 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD86312AEE
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655718300; x=1687254300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ApHirUKwJbkQ2/N/RCN2hTRbd6HWIqyDT3G03p6IYD4=;
  b=C0HEmx2v1EM+jZgzUBOIhTiEqdLVzffjDty/lY7L++ruMjTBO/FpImrS
   JZlVmdPpAlxTtT46QoqZ1vZff99v//9RCv/PWxOz98vUL+XB6LbvVDUav
   /+8s1WxH9ne4rr1pKvwO5F8Ywrfzilf2ZXFUK+1kbxKaUqIEgCuzwwWpK
   6hB/HqlhfjKoUoUpf828msjnZNNCXolc39v5KadZCtceVOVQszP22/4ub
   S+DLavaCGikxAQukWHbMWpfG8EYn9rSIVNAvAZzZ+hmKnJq4MRWodlVpY
   H+HO6u5hd0Oct6poEwsrBcfeQI/nR6FhjtcCzhDV2WsxhBhRWvaWiN4E3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="277400979"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="277400979"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:45:00 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="654598246"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:44:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3Dvi-000h2n-Sd;
        Mon, 20 Jun 2022 12:42:46 +0300
Date:   Mon, 20 Jun 2022 12:42:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/9] mfd: intel_soc_pmic_crc: Merge Intel PMIC core to
 crc
Message-ID: <YrBBFop5DrTVNWQi@smile.fi.intel.com>
References: <20220616182524.7956-1-andriy.shevchenko@linux.intel.com>
 <81201d93-ffc5-024c-c132-36f91d9e663e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81201d93-ffc5-024c-c132-36f91d9e663e@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 11:04:38AM +0200, Hans de Goede wrote:
> p.s.
> 
> I've added this commit to my local tree, so that the next time I boot
> a device with a CRC PMIC it will get some testing.

Thanks!

-- 
With Best Regards,
Andy Shevchenko


