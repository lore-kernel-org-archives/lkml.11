Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E365C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Feb 2022 13:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242432AbiBJNs6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 08:48:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiBJNs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 08:48:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6A4191
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 05:48:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9ABFB82557
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30CFC004E1;
        Thu, 10 Feb 2022 13:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644500935;
        bh=QI5LDB2KPQTsI0Rf8cfbWacWSB1sk8X6zQXAsK+3whk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dFBZodrbTVhElVqc2vFBBsPARCCo5mBBJX6FR2cvh9qqZIk3XZvF0axuJzDyhYR2c
         2vjzZSsyS0DBW48d8vD0JL0o0LXB5YYXBQwV+VwTM5FWlb24FR3tW9aFgsoR32VLIk
         A4uSWtOSCRkJvCN41sAjUzXtilYmAdJ//FI1lvC/OBnBM8weHxaGhKL6S43JZd38dj
         wMvV6k2l5OstMy3gelb+0grLRZ3IKSxz4WTukDolpMysbLGBPiheTFZ8cKX/14ax5e
         lbBsJGchIN9G7HxA3CPXbi+H77OnwWc+mCkcK38TpajDolsBo6Tw7unyuBpWxt1Pbr
         6BFFrIK+kd/oA==
Date:   Thu, 10 Feb 2022 19:18:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH] soundwire: bus: add dev_warn() messages to track
 UNATTACHED devices
Message-ID: <YgUXw59EzUx8BXYm@matsya>
References: <20220126011527.27930-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126011527.27930-1-yung-chuan.liao@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-01-22, 09:15, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> In rare cases, some devices seem to lose sync and never re-attach on
> the bus. This seems to happen only when there are more than one device
> per link, which suggests either an electrical issue, a race condition
> or a state machine issue.
> 
> Add two dev_warn() messages to identify the sequence by which the
> devices become UNATTACHED.

Applied, thanks

-- 
~Vinod
