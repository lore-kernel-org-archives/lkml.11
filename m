Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FFCC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 13:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236780AbiCRNow (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiCRNou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 09:44:50 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6769925F3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647611011; x=1679147011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F49qIqOFgRujygUf9hfOLLpLuRLi9JWuENJ0sCiKPX0=;
  b=FWYQuoFU8LP0laOZyNOclqbA85yK86mjPJw18UY5OKJ7SBQ+RK2jL73Z
   XKp+lgH3d2Wl4StGyrssWd7UjT0sWTsO2FFCOhdJoh1vYIkwiExmS4cLS
   qLMCwYblk0/WaknOdlmBXnfch7njjD2U2SRiXI75hweb2RpcPc/Y8LHmk
   nt7pwCMR4kCN5ENv7xT5Xpeyq4PbaryPCTAQ2IoqyRYjE/kSFBS6xfCsp
   gzM1CyrLDrxtHYVSDS09GnHrl2BWAioTNyxGPP2hBuA/Wsa9YB32MAfdv
   UEQkwXGdaf8Hhx7Fzvi/O0Z6uUETeNH95q+hAXFtFTWx1tR7XYqM7PtUy
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343572559"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="343572559"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:43:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="499252768"
Received: from smile.fi.intel.com ([10.237.72.59])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 06:43:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nVCsS-002FjN-V1;
        Fri, 18 Mar 2022 15:42:48 +0200
Date:   Fri, 18 Mar 2022 15:42:48 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] drm: Fix monochrome conversion for sdd130x
Message-ID: <YjSMWDFxTeJZZ/CB@smile.fi.intel.com>
References: <20220317081830.1211400-1-geert@linux-m68k.org>
 <f94c0f44-36f1-e1a9-5963-5da0bafb8c90@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f94c0f44-36f1-e1a9-5963-5da0bafb8c90@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 17, 2022 at 12:39:57PM +0100, Javier Martinez Canillas wrote:
> On 3/17/22 09:18, Geert Uytterhoeven wrote:

> By the way, you should probably request commit access to the drm-misc tree:
> 
> https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html

Does it really work? I tried and no one replied to request.
Keeping silent is a bad service. If people don't want a person
to have such access it should be well communicated.

-- 
With Best Regards,
Andy Shevchenko


