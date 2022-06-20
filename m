Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC5C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jun 2022 09:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiFTJkH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jun 2022 05:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbiFTJkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:40:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E5E13D60
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655718002; x=1687254002;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JxyaOExcfQqBeg/LyVMbFoLcpenVJuI250w/2kkbsX8=;
  b=APvHILTyaaGsQGTyszgpKAMTA/rgFUF0PvqycREyYasvOA6mzLXtwtTM
   gxHp0poeJC+8dMchZhpSTYy4HCNUAuFsckFY/TMtKePlpxyE7PjHsU8Jh
   pEfRsyRgCZCv/lbe2qeaE0kIbKWE7hyqw0p475lbwBPoO0m9xiNP0epdw
   PmMuq4XIbSXNGGb8Kl9EsPMmFbb28QDkBYuGpG+VRSnganfCSR9IEHMpV
   H2ei9bZQBGUPb4ZNDU7WXbDWoPeCwshnwAh0By44mgZkIPIB1zCIEMww/
   hub6RgW5JK/1zuKMX09ZlXQ/+qP5P3qRbuNHQIEoZ/lydhWbnhU9nUJ4V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343844592"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343844592"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:40:02 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="833033877"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 02:40:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1o3Dt0-000h2R-34;
        Mon, 20 Jun 2022 12:39:58 +0300
Date:   Mon, 20 Jun 2022 12:39:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 2/2] mfd: intel_soc_pmic_chtwc: Switch from
 __maybe_unused to pm_sleep_ptr() etc
Message-ID: <YrBAbYsSB3SZPQvt@smile.fi.intel.com>
References: <20220616171009.43524-1-andriy.shevchenko@linux.intel.com>
 <20220616171009.43524-2-andriy.shevchenko@linux.intel.com>
 <8c0ddc7c-c3e0-f370-3cca-9b6c0ab03e3d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0ddc7c-c3e0-f370-3cca-9b6c0ab03e3d@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 10:38:34AM +0200, Hans de Goede wrote:
> On 6/16/22 19:10, Andy Shevchenko wrote:
> > Letting the compiler remove these functions when the kernel is built
> > without CONFIG_PM_SLEEP support is simpler and less heavier for builds
> > than the use of __maybe_unused attributes.
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> I don't see how this helps, __maybe_unused only means the compiler should not
> warn AFAIK it is still allowed to remove static globals which are unused
> even of they are marked __maybe_unused ?

__maybe_unused will force compiler to compile and linker to drop the section.
The proposed approach saves resources on build, i.e. it's already compiler that
decides not to compile the code.

> And DEFINE_SIMPLE_DEV_PM_OPS does not mark the dev_pm_ops as
> __maybe_unused where as pm_sleep_ptr() will not reference the struct
> when CONFIG_PM is not set.
> 
> But I guess that the new PTR_IF magic:
> 
> #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
> 
> Still counts as referencing the struct so we don't get
> an unused warning and since cond is a const 0 value the compiler
> can optimize things away ?

See above, it's not olny about warning and compiler.


-- 
With Best Regards,
Andy Shevchenko


