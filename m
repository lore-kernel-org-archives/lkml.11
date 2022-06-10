Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA3CC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 16:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349506AbiFJQhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243758AbiFJQgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:36:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3656F83
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654879007; x=1686415007;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8q5yMTIXOZ7mG0+/Uh9dptn1Eld7c9q8vQLWMVlD6Bc=;
  b=I+PSwuAWerkCQD6Njwj+jqmI5MBb4brL0Sj6aXcBy50rKnvNzzxdKeQa
   3pLqJR29N+o6uF4drQ3p9vBcN2namWELHudq1Yc8zUtxrJvUr/XfCZqBs
   eS1DlbVXSFkYfCClnDDDktCsjPximOZtlNj3RHaMohaiFbKqy0kKai5Qs
   dFiKA12m6hQTk4ytsWK026TO94gl9jkPg4eaBKMK5xDsJYabbBCfHiZ++
   9VOQhzZ9ubWF0r7KTPxrNHpUgM6+NPu1vuEpC6s1/oyZlni3dwBujcBWh
   uCj1mimRRE8ERuVwxtLqou+RHfRxlf5Oxa1URcT4EUN7M7rrlA+Bzi0x2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="266445916"
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="266445916"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 09:36:46 -0700
X-IronPort-AV: E=Sophos;i="5.91,290,1647327600"; 
   d="scan'208";a="725032952"
Received: from pljackso-mobl.amr.corp.intel.com (HELO [10.213.190.122]) ([10.213.190.122])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 09:36:44 -0700
Message-ID: <0c493f72-de7f-4c57-f1d5-47f982abc3c8@linux.intel.com>
Date:   Fri, 10 Jun 2022 09:53:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] soundwire: Intel: add trigger callback
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vinod.koul@linaro.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, sanyog.r.kale@intel.com,
        bard.liao@intel.com
References: <20220610023537.27223-1-yung-chuan.liao@linux.intel.com>
 <20220610023537.27223-3-yung-chuan.liao@linux.intel.com>
 <YqLV7qexsdhCI7ZZ@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <YqLV7qexsdhCI7ZZ@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Where is the in-kernel user of this new callback?  Without that, there
> is no need for this, NOR is there a way to properly review this commit.
> 
> sorry,

ASoC/SOF will be the user, this is a dependency before Mark Brown can
take additional code in his tree. It was spelled out in the cover letter.

To be clearer, the ONLY user of all the soundwire:intel code is
precisely the ASoC/SOF driver.

