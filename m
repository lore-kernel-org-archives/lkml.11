Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5371CC38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 14:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236564AbiIBO7I (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237224AbiIBO6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:58:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065552838
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 07:25:16 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="297277175"
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="297277175"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:25:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,283,1654585200"; 
   d="scan'208";a="681300258"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 07:25:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1oU7bY-007QK2-2q;
        Fri, 02 Sep 2022 17:25:08 +0300
Date:   Fri, 2 Sep 2022 17:25:08 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com,
        perex@perex.cz, amadeuszx.slawinski@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com,
        lgirdwood@gmail.com, kai.vehmanen@linux.intel.com,
        peter.ujfalusi@linux.intel.com, ranjani.sridharan@linux.intel.com,
        yung-chuan.liao@linux.intel.com, willy@infradead.org,
        linux-kernel@vger.kernel.org, andy@kernel.org,
        intel-poland@eclists.intel.com
Subject: Re: [PATCH v5 2/2] ASoC: SOF: Remove strsplit_u32() and
 tokenize_input()
Message-ID: <YxISRG13SGScC5Fn@smile.fi.intel.com>
References: <20220902133256.789165-1-cezary.rojewski@intel.com>
 <20220902133256.789165-3-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902133256.789165-3-cezary.rojewski@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 03:32:56PM +0200, Cezary Rojewski wrote:
> Make use of global integer-array parsing helper instead of the internal
> one as both serve same purpose. With that, both strsplit_u32() and
> tokenize_input() become unused so remove them.

More minor comments...

...

> +	ret = parse_int_array_user(from, count, (int **)&array);
>  	if (ret < 0)
>  		return ret;

> +	num_elems = *array;
> +	bytes = sizeof(*array) * num_elems;
> +	if (!num_elems || (bytes % sizeof(*desc))) {

!num_elems is a dup since previous already does this check.

...

> +	ret = parse_int_array_user(from, count, (int **)&array);
>  	if (ret < 0)
>  		return ret;
> +
> +	num_elems = *array;

> +	if (!num_elems) {
>  		ret = -EINVAL;
>  		goto exit;
>  	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


